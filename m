Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265559AbRFVWrU>; Fri, 22 Jun 2001 18:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265560AbRFVWrM>; Fri, 22 Jun 2001 18:47:12 -0400
Received: from rumor.cps.intel.com ([192.102.198.242]:1530 "EHLO
	rumor.cps.intel.com") by vger.kernel.org with ESMTP
	id <S265559AbRFVWqw>; Fri, 22 Jun 2001 18:46:52 -0400
Message-ID: <10C8636AE359D4119118009027AE998709BE50E3@FMSMSX34>
From: "Mroczek, Joseph T" <joseph.t.mroczek@intel.com>
To: linux-kernel@vger.kernel.org
Subject: RE: EEPRO100/S support
Date: Fri, 22 Jun 2001 15:46:34 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
MIME-Version: 1.0
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=SHA1;
	boundary="----=_NextPart_000_00C8_01C0FB32.7E3764F0"
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_00C8_01C0FB32.7E3764F0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit



>The e100 driver from intel claims to support these cards (the 100 S
>desktop adaptor, that is), but in fact the drivers lock up under heavy
>UDP load (at least they do for me in 2.2.19).  It seems to only be a
>problem with these newer cards, the e100 is solid with older cards
>(and things like the 100VE which is onboard on many Easterns).
>
>Intel are working on fixing the lockups, they thought it was related
>to the checksum offload though turning that off doesn't prevent the
>lockups.  Version 1.66 is much more stable than 1.55a (1.55a would
>lockup after 60-80M of traffic on these cards), I'm awaiting the next
>version to see if they have nailed it.
>

A temporary workaround for e100-1.6.6 that works in most cases is to
disable the CPUSaver features by using the ucode=0 option.

>
>I've no idea if the e100 works on anything other than ia32/ia64.

Yes it does. At this point it should be platform independent, I see all
the required changes for both big and little endian support. 

~joe

------=_NextPart_000_00C8_01C0FB32.7E3764F0
Content-Type: application/x-pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIFvzCCAo4w
ggH3oAMCAQICAwTI2DANBgkqhkiG9w0BAQQFADCBkjELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdl
c3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMQ8wDQYDVQQKEwZUaGF3dGUxHTAbBgNVBAsT
FENlcnRpZmljYXRlIFNlcnZpY2VzMSgwJgYDVQQDEx9QZXJzb25hbCBGcmVlbWFpbCBSU0EgMjAw
MC44LjMwMB4XDTAxMDUxMDIzMDM0M1oXDTAyMDUxMDIzMDM0M1owTDEfMB0GA1UEAxMWVGhhd3Rl
IEZyZWVtYWlsIE1lbWJlcjEpMCcGCSqGSIb3DQEJARYaam9zZXBoLnQubXJvY3pla0BpbnRlbC5j
b20wgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBALGbKjcIssEC6xteQxlAOfiRpWNYP0QNnX2s
xk7AyLOVTMWCVp2Aa4xXB8ira+9F0l3jtiwiV5O2ucGR7aQCQfROKhSS45mIknXgtTir9e8FHwZl
vuVYsbeppXUTZGlqLBcXyACwmM8E/sHNX3NwqKecabpFzTswQaQXoeG272+jAgMBAAGjNzA1MCUG
A1UdEQQeMByBGmpvc2VwaC50Lm1yb2N6ZWtAaW50ZWwuY29tMAwGA1UdEwEB/wQCMAAwDQYJKoZI
hvcNAQEEBQADgYEASG8nl40VCz5rEf72knoMmY+Sabz12R3MdBYVjzVRvjjUjxSnQIVW9D9UAnG6
610+JMbOr5qW0o/WF3zJFYHtgzRVm85KeNsbqiUZpIfEaSoOO6bq5O0YyUGnCM92TL5hXyzQI36s
XNe3vjPkNr5CBGOwJi+EW77B5zVvzckoy7MwggMpMIICkqADAgECAgEMMA0GCSqGSIb3DQEBBAUA
MIHRMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRv
d24xGjAYBgNVBAoTEVRoYXd0ZSBDb25zdWx0aW5nMSgwJgYDVQQLEx9DZXJ0aWZpY2F0aW9uIFNl
cnZpY2VzIERpdmlzaW9uMSQwIgYDVQQDExtUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgQ0ExKzAp
BgkqhkiG9w0BCQEWHHBlcnNvbmFsLWZyZWVtYWlsQHRoYXd0ZS5jb20wHhcNMDAwODMwMDAwMDAw
WhcNMDIwODI5MjM1OTU5WjCBkjELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTES
MBAGA1UEBxMJQ2FwZSBUb3duMQ8wDQYDVQQKEwZUaGF3dGUxHTAbBgNVBAsTFENlcnRpZmljYXRl
IFNlcnZpY2VzMSgwJgYDVQQDEx9QZXJzb25hbCBGcmVlbWFpbCBSU0EgMjAwMC44LjMwMIGfMA0G
CSqGSIb3DQEBAQUAA4GNADCBiQKBgQDeMzKmY8cJJUU+0m54J2eBxdqIGYKXDuNEKYpjNSptcDz6
3K737nRvMLwzkH/5NHGgo22Y8cNPomXbDfpL8dbdYaX5hc1VmjUanZJ1qCeu2HL5ugL217CR3hzp
q+AYA6h8Q0JQUYeDPPA5tJtUihOH/7ObnUlmAC0JieyUa+mhaQIDAQABo04wTDApBgNVHREEIjAg
pB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVsMS0yOTcwEgYDVR0TAQH/BAgwBgEB/wIBADALBgNV
HQ8EBAMCAQYwDQYJKoZIhvcNAQEEBQADgYEAcxtvJmWL/xU0S1liiu1EvknH6A27j7kNaiYqYoQf
uIdjdBxtt88aU5FL4c3mONntUPQ6bDSSrOaSnG7BIwHCCafvS65y3QZn9VBvLli4tgvBUFe17BzX
7xe21Yibt6KIGu05Wzl9NPy2lhglTWr0ncXDkS+plrgFPFL83eliA0gxggKaMIIClgIBATCBmjCB
kjELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3du
MQ8wDQYDVQQKEwZUaGF3dGUxHTAbBgNVBAsTFENlcnRpZmljYXRlIFNlcnZpY2VzMSgwJgYDVQQD
Ex9QZXJzb25hbCBGcmVlbWFpbCBSU0EgMjAwMC44LjMwAgMEyNgwCQYFKw4DAhoFAKCCAVUwGAYJ
KoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMDEwNjIyMjI0NjI0WjAjBgkq
hkiG9w0BCQQxFgQUFpO1T5hPuhgQSSGpHW8zwzrJ9+UwSAYJKoZIhvcNAQkPMTswOTAKBggqhkiG
9w0DBzAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDAHBgUrDgMCGjAKBggqhkiG9w0CBTCBqwYJKwYB
BAGCNxAEMYGdMIGaMIGSMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBDYXBlMRIwEAYD
VQQHEwlDYXBlIFRvd24xDzANBgNVBAoTBlRoYXd0ZTEdMBsGA1UECxMUQ2VydGlmaWNhdGUgU2Vy
dmljZXMxKDAmBgNVBAMTH1BlcnNvbmFsIEZyZWVtYWlsIFJTQSAyMDAwLjguMzACAwTI2DANBgkq
hkiG9w0BAQEFAASBgB7gBGxuqQc5u7FOdthNWJTkr+93OPEk33/AmQFYVmMRpFfhPyKgbmR9V89X
O7eGZxUg9gx5LH6XWdWQwkLrgvtYeY2Qoa3x9wqUHHsKT+HtEbL22oYFmUTu1ULBiHV6J2CU4QVJ
dq4+IFoPib2xAXGi8OMG50w9QYc12I9NqIWCAAAAAAAA

------=_NextPart_000_00C8_01C0FB32.7E3764F0--


