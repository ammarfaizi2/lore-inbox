Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264136AbTKSVhk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 16:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264151AbTKSVhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 16:37:40 -0500
Received: from mmp-2.gci.net ([208.138.130.81]:12381 "EHLO mmp-2.gci.net")
	by vger.kernel.org with ESMTP id S264136AbTKSVhh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 16:37:37 -0500
Date: Wed, 19 Nov 2003 12:37:33 -0900
From: leif <leif@gci.net>
Subject: RE: error in Sparc64 rwlock.S
In-reply-to: <20031118130956.1edd4a24.akpm@osdl.org>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <014401c3aee5$587aea20$31828ad0@internet.gci.net>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
Content-type: multipart/signed;
 boundary="----=_NextPart_000_0057_01C3AE99.E7C3BD20"; micalg=SHA1;
 protocol="application/x-pkcs7-signature"
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0057_01C3AE99.E7C3BD20
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Andrew Morton writes:
> leif <leif@gci.net> wrote:
>>
>> I'm going through the 2.6.0-test9 and some -mm3 patches, 
>> and have run into an issue with arch/sparc64/lib/rwlock.S
>> 
>> When compiling, the assembler complains of multiple
>> definitions of  __write_trylock.
> 
> OK, the lockmeter patch adds a write_trylock() implementation 
> to sparc64, but now Linus's tree has one anyway.
> 
> Does this fix it?

Now there's a different problem...

Error: local label '"100" (instance number 1 of a fb label)'
  is not defined

Should I try to grab a different -test9  bk version out of
Linus' tree?

If so, where would I look -- i've not been keeping up with
the bk info/requirements


Leif

------=_NextPart_000_0057_01C3AE99.E7C3BD20
Content-Type: application/x-pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIFuDCCAngw
ggHhoAMCAQICAwkdJTANBgkqhkiG9w0BAQQFADCBkjELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdl
c3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMQ8wDQYDVQQKEwZUaGF3dGUxHTAbBgNVBAsT
FENlcnRpZmljYXRlIFNlcnZpY2VzMSgwJgYDVQQDEx9QZXJzb25hbCBGcmVlbWFpbCBSU0EgMjAw
MC44LjMwMB4XDTAzMDEyMTIzMjkwOVoXDTA0MDEyMTIzMjkwOVowQTEfMB0GA1UEAxMWVGhhd3Rl
IEZyZWVtYWlsIE1lbWJlcjEeMBwGCSqGSIb3DQEJARYPbHNhd3llckBnY2kuY29tMIGfMA0GCSqG
SIb3DQEBAQUAA4GNADCBiQKBgQCu1qlKy81sgP+hQsDnPs7sZfShYyGKmkdL5spm0JpheqGIboGB
IeoGP2sUX++b5TcOhbg5ZCQDd2yT75O9BN0gJLlDzNxabms5mJRBbj5LzCwucQqZG25Seo9sHk8R
mW5hCOQbnULWPEMUTG/kDNtXFZjCr0Om5OWnnTuNHqK4KQIDAQABoywwKjAaBgNVHREEEzARgQ9s
c2F3eWVyQGdjaS5jb20wDAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQQFAAOBgQCChYp5yWCZ5Mh3
h6kbzZgoeCiKM09rHvckT157nuXOj1bqm/HEsCaXDZu/MecPsaEfDixMOFP6Qwg3U67ceGL01yVP
clnNJE/api0+DU7jRBaNI09+RgwegexT6VvIqanB8riRgOtbklZX/NOymHI87yrNshq9UBONeSzc
Pj8FqTCCAzgwggKhoAMCAQICEGZFcrfMdPXPY3ZFhNAukQEwDQYJKoZIhvcNAQEEBQAwgdExCzAJ
BgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEaMBgG
A1UEChMRVGhhd3RlIENvbnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24gU2VydmljZXMg
RGl2aXNpb24xJDAiBgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTErMCkGCSqGSIb3
DQEJARYccGVyc29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMDA4MzAwMDAwMDBaFw0wNDA4
MjcyMzU5NTlaMIGSMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQH
EwlDYXBlIFRvd24xDzANBgNVBAoTBlRoYXd0ZTEdMBsGA1UECxMUQ2VydGlmaWNhdGUgU2Vydmlj
ZXMxKDAmBgNVBAMTH1BlcnNvbmFsIEZyZWVtYWlsIFJTQSAyMDAwLjguMzAwgZ8wDQYJKoZIhvcN
AQEBBQADgY0AMIGJAoGBAN4zMqZjxwklRT7SbngnZ4HF2ogZgpcO40QpimM1Km1wPPrcrvfudG8w
vDOQf/k0caCjbZjxw0+iZdsN+kvx1t1hpfmFzVWaNRqdknWoJ67Ycvm6AvbXsJHeHOmr4BgDqHxD
QlBRh4M88Dm0m1SKE4f/s5udSWYALQmJ7JRr6aFpAgMBAAGjTjBMMCkGA1UdEQQiMCCkHjAcMRow
GAYDVQQDExFQcml2YXRlTGFiZWwxLTI5NzASBgNVHRMBAf8ECDAGAQH/AgEAMAsGA1UdDwQEAwIB
BjANBgkqhkiG9w0BAQQFAAOBgQAxsUtHXfkBceX1U2xdedY9mMAmE2KBIqcS+CKV6BtJtyd7BDm6
/ObyJOuR+r3sDSo491BVqGz3Da1MG7wD9LXrokefbKIMWI0xQgkRbLAaadErErJAXWr5edDqLiXd
iuT82w0fnQLzWtvKPPZE6iZph39Ins6ln+eE2MliYq0FxjGCAqowggKmAgEBMIGaMIGSMQswCQYD
VQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xDzANBgNV
BAoTBlRoYXd0ZTEdMBsGA1UECxMUQ2VydGlmaWNhdGUgU2VydmljZXMxKDAmBgNVBAMTH1BlcnNv
bmFsIEZyZWVtYWlsIFJTQSAyMDAwLjguMzACAwkdJTAJBgUrDgMCGgUAoIIBZTAYBgkqhkiG9w0B
CQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wMzExMTkyMTM3MzNaMCMGCSqGSIb3DQEJ
BDEWBBS4vFkcAyoYlsS/vpLIL4cUDpR9/zBYBgkqhkiG9w0BCQ8xSzBJMAoGCCqGSIb3DQMHMA4G
CCqGSIb3DQMCAgIAgDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDAHBgUrDgMCGjAKBggqhkiG9w0C
BTCBqwYJKwYBBAGCNxAEMYGdMIGaMIGSMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBD
YXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xDzANBgNVBAoTBlRoYXd0ZTEdMBsGA1UECxMUQ2VydGlm
aWNhdGUgU2VydmljZXMxKDAmBgNVBAMTH1BlcnNvbmFsIEZyZWVtYWlsIFJTQSAyMDAwLjguMzAC
AwkdJTANBgkqhkiG9w0BAQEFAASBgGWstG/rq6MjU3AmGbbEEW0uPV0TBxhpmNYWH8acqZfZVA9y
13MI6AGqGHZye0IwGHEgYQRK5Db30MAGkKsosdy/p7Jm4J00VMs9Cqoii3rClWiCgd8LZGZhueGq
vdRNxcVNOvUyW1Ajr9n1viU7LvGXeb3trlhBxME6H1/+zpasAAAAAAAA

------=_NextPart_000_0057_01C3AE99.E7C3BD20--

