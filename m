Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264286AbUGRRlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbUGRRlm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 13:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264346AbUGRRlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 13:41:42 -0400
Received: from ms-smtp-04-lbl.southeast.rr.com ([24.25.9.103]:12204 "EHLO
	ms-smtp-04-eri0.southeast.rr.com") by vger.kernel.org with ESMTP
	id S264286AbUGRRli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 13:41:38 -0400
Message-ID: <40FAB642.40509@mbio.ncsu.edu>
Date: Sun, 18 Jul 2004 13:41:22 -0400
From: Will Beers <whbeers@mbio.ncsu.edu>
User-Agent: Mozilla Thunderbird 0.7+ (X11/20040623)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, gtm.kramer@inter.nl.net
Subject: Re: Linux 2.6.8-rc2
References: <Pine.LNX.4.58.0407172237370.12598@ppc970.osdl.org> <1090149153.3198.3.camel@paragon.slim>
In-Reply-To: <1090149153.3198.3.camel@paragon.slim>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms080205080503080500050304"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms080205080503080500050304
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

 > Just gave it a try. My EHCI controller is still failing (Asus P4C800-E
 > i875p) as in the 2.6.7-mm series.

This was previously discussed as the subject "proper bios handoff in 
ehci-hcd".  Basically it's a broken bios, and David Brownell has a fix for 
it that hasn't made it into the kernel yet.

Changing the "return 1" at line 308 in drivers/usb/host/ehci-hcd.c" to a 
"return 0" works for me until the patch makes it into the tree.

-Will

--------------ms080205080503080500050304
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIII+TCC
AtcwggJAoAMCAQICAwylZTANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UE
ChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNv
bmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwHhcNMDQwNzA4MDY1OTI1WhcNMDUwNzA4MDY1OTI1
WjBHMR8wHQYDVQQDExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMSQwIgYJKoZIhvcNAQkBFhV3
aGJlZXJzQG1iaW8ubmNzdS5lZHUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCw
5/G6HmtFPp9fK1kCwjNTyx4sN3E/AO9uPXDV48IxqXFi7CANR/BvQMaawTEMEa5XjHoGab6O
HyvMGvr6csebsBAryt6LmCvTi3py0pNF5KLBaV98AfgFu4AyoJK+hxIM41XyF2BhS6Cfc/iD
uZuWeWybiUQZLhYVdbU5j928u5ad1jeUqMRNeU7GIC7TOy8lulpugpA9CRocxtNoyibNE7J/
pbSzZXEMVBrNqdwGlKPd7HEhvK941D5IZEId0xul1p0DjlXkugG8q59kapfDosWHfL987Kni
FmUwLbOBPOQagsvDeqd3RQQ6UMYq4Qewz1aAjghhQs/xKpkQfr0NAgMBAAGjMjAwMCAGA1Ud
EQQZMBeBFXdoYmVlcnNAbWJpby5uY3N1LmVkdTAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEB
BAUAA4GBAEN+A34ZDoOVt4uP6MuH1SLoGsMyjrpdLS5McYTz4GAFafHL1YHSKu5vlofkadBs
Hdln1Fe9QyMxA+Ycrp42pt3ZzzxqpF/Vfnp7yieXFjcg6Yg4m5pIfwmmKyU13BVbGfWDGasd
aJ1GpWWvsSDEYLjlWymVz3clCcfAi+yVJl6CMIIC1zCCAkCgAwIBAgIDDKVlMA0GCSqGSIb3
DQEBBAUAMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5
KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQTAe
Fw0wNDA3MDgwNjU5MjVaFw0wNTA3MDgwNjU5MjVaMEcxHzAdBgNVBAMTFlRoYXd0ZSBGcmVl
bWFpbCBNZW1iZXIxJDAiBgkqhkiG9w0BCQEWFXdoYmVlcnNAbWJpby5uY3N1LmVkdTCCASIw
DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALDn8boea0U+n18rWQLCM1PLHiw3cT8A7249
cNXjwjGpcWLsIA1H8G9AxprBMQwRrleMegZpvo4fK8wa+vpyx5uwECvK3ouYK9OLenLSk0Xk
osFpX3wB+AW7gDKgkr6HEgzjVfIXYGFLoJ9z+IO5m5Z5bJuJRBkuFhV1tTmP3by7lp3WN5So
xE15TsYgLtM7LyW6Wm6CkD0JGhzG02jKJs0Tsn+ltLNlcQxUGs2p3AaUo93scSG8r3jUPkhk
Qh3TG6XWnQOOVeS6Abyrn2Rql8OixYd8v3zsqeIWZTAts4E85BqCy8N6p3dFBDpQxirhB7DP
VoCOCGFCz/EqmRB+vQ0CAwEAAaMyMDAwIAYDVR0RBBkwF4EVd2hiZWVyc0BtYmlvLm5jc3Uu
ZWR1MAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEEBQADgYEAQ34DfhkOg5W3i4/oy4fVIuga
wzKOul0tLkxxhPPgYAVp8cvVgdIq7m+Wh+Rp0Gwd2WfUV71DIzED5hyunjam3dnPPGqkX9V+
envKJ5cWNyDpiDibmkh/CaYrJTXcFVsZ9YMZqx1onUalZa+xIMRguOVbKZXPdyUJx8CL7JUm
XoIwggM/MIICqKADAgECAgENMA0GCSqGSIb3DQEBBQUAMIHRMQswCQYDVQQGEwJaQTEVMBMG
A1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xGjAYBgNVBAoTEVRoYXd0
ZSBDb25zdWx0aW5nMSgwJgYDVQQLEx9DZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9u
MSQwIgYDVQQDExtUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgQ0ExKzApBgkqhkiG9w0BCQEW
HHBlcnNvbmFsLWZyZWVtYWlsQHRoYXd0ZS5jb20wHhcNMDMwNzE3MDAwMDAwWhcNMTMwNzE2
MjM1OTU5WjBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0
eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0Ew
gZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAMSmPFVzVftOucqZWh5owHUEcJ3f6f+jHuy9
zfVb8hp2vX8MOmHyv1HOAdTlUAow1wJjWiyJFXCO3cnwK4Vaqj9xVsuvPAsH5/EfkTYkKhPP
K9Xzgnc9A74r/rsYPge/QIACZNenprufZdHFKlSFD0gEf6e20TxhBEAeZBlyYLf7AgMBAAGj
gZQwgZEwEgYDVR0TAQH/BAgwBgEB/wIBADBDBgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3Js
LnRoYXd0ZS5jb20vVGhhd3RlUGVyc29uYWxGcmVlbWFpbENBLmNybDALBgNVHQ8EBAMCAQYw
KQYDVR0RBCIwIKQeMBwxGjAYBgNVBAMTEVByaXZhdGVMYWJlbDItMTM4MA0GCSqGSIb3DQEB
BQUAA4GBAEiM0VCD6gsuzA2jZqxnD3+vrL7CF6FDlpSdf0whuPg2H6otnzYvwPQcUCCTcDz9
reFhYsPZOhl+hLGZGwDFGguCdJ4lUJRix9sncVcljd2pnDmOjCBPZV+V2vf3h9bGCE6u9uo0
5RAaWzVNd+NWIXiC3CEZNd4ksdMdRv9dX2VPMYIDOzCCAzcCAQEwaTBiMQswCQYDVQQGEwJa
QTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhh
d3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECAwylZTAJBgUrDgMCGgUAoIIBpzAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wNDA3MTgxNzQxMjJa
MCMGCSqGSIb3DQEJBDEWBBSmkSRWNbGAbL9ey2NJlE8QVMiTHjBSBgkqhkiG9w0BCQ8xRTBD
MAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzAN
BggqhkiG9w0DAgIBKDB4BgkrBgEEAYI3EAQxazBpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQK
ExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29u
YWwgRnJlZW1haWwgSXNzdWluZyBDQQIDDKVlMHoGCyqGSIb3DQEJEAILMWugaTBiMQswCQYD
VQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UE
AxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECAwylZTANBgkqhkiG9w0B
AQEFAASCAQBzAzniIGq0+Uq72A8qVI1yyW/tDR91EiDjbbDDXcWvMyxcfSbVv0BWINdF0l4s
oU9+tLgLIepJHAwnZFdBsC0XRoFEAnOiOu9JG3mxyFxeeYLW97EtiyAMKj9E+Xw0QVcwVPu8
RrUTp/KSCJG4EXGSM6yfeI38tUHZfaGX40kaT0vE2lo+hYLgAbIAq/nDp67GZqGUaU9yPpJx
qZCtYpx6UbskNPKqpQsBPOgqTtk/qMXpM1/2rrQOsk4UchglXpVCdSiyGSv3fvl6pCluBop4
Zx1shjvFndn2wqgO1feDygyI9DfPZa3liTB8WU+MK0/wj/1WUPVDy56Q+hLxdHrnAAAAAAAA

--------------ms080205080503080500050304--
