unit ExHash1;

interface

uses
  LCLIntf, LCLType,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ExtCtrls,
  SysUtils,
  Classes;

type
  TForm1 = class(TForm)
    edtDigest: TEdit;
    Label1: TLabel;
    edtMessage: TEdit;
    Label2: TLabel;
    rgHashMethod: TRadioGroup;
    btnGo: TButton;
    procedure btnGoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

uses
  LbCipher, LbUtils;

type
  THashMethod = (hmMD5, hmSHA1, hmLMD, hmELF);

var
  MD5Digest  : TMD5Digest;
  SHA1Digest : TSHA1Digest;
  ELFDigest  : Longint;
  LMDDigest  : Longint;

procedure TForm1.btnGoClick(Sender: TObject);
var
  TextMessage : UTF8String;
begin
  TextMessage := StringToUTF8(edtMessage.Text);
  case THashMethod(rgHashMethod.ItemIndex) of
    hmMD5 : begin
              StringHashMD5(MD5Digest, TextMessage);
              edtDigest.Text := BufferToHex(MD5Digest, SizeOf(MD5Digest));
            end;
    hmSHA1 : begin
              StringHashSHA1(SHA1Digest, TextMessage);
              edtDigest.Text := BufferToHex(SHA1Digest, SizeOf(SHA1Digest));
             end;
    hmLMD : begin
              StringHashLMD(LMDDigest, SizeOf(LMDDigest), TextMessage);
              edtDigest.Text := BufferToHex(LMDDigest, SizeOf(LMDDigest));
            end;
    hmELF : begin
              StringHashELF(ELFDigest, TextMessage);
              edtDigest.Text := BufferToHex(ELFDigest, SizeOf(ELFDigest));
            end;
  end;
end;

end.
