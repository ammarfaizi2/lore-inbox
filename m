Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbUGMVoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUGMVoj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 17:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266132AbUGMVoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 17:44:39 -0400
Received: from ms-smtp-02-lbl.southeast.rr.com ([24.25.9.101]:61676 "EHLO
	ms-smtp-02-eri0.southeast.rr.com") by vger.kernel.org with ESMTP
	id S261500AbUGMVoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 17:44:04 -0400
Message-ID: <40F4579B.8090208@mbio.ncsu.edu>
Date: Tue, 13 Jul 2004 17:43:55 -0400
From: Will Beers <whbeers@mbio.ncsu.edu>
User-Agent: Mozilla Thunderbird 0.7+ (X11/20040623)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Olaf Hering <olh@suse.de>, Gary_Lerhaupt@Dell.com,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Stuart_Hayes@Dell.com
Subject: Re: [linux-usb-devel] [PATCH] proper bios handoff in ehci-hcd
References: <FD3BA83843210C4BA9E414B0C56A5E5C07DD91@ausx2kmpc104.aus.amer.dell.com> <40CF0049.2010307@pacbell.net> <20040713180727.GA11583@suse.de> <40F4457F.2010005@pacbell.net> <40F449BD.2030508@mbio.ncsu.edu> <40F44FFB.80707@pacbell.net> <40F45327.1080703@mbio.ncsu.edu> <40F455B0.2090008@pacbell.net>
In-Reply-To: <40F455B0.2090008@pacbell.net>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms060806060505080005050807"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms060806060505080005050807
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

 > more like the attached patch to _write_ the flag (untested).

Alright, sorry for the misunderstanding - that patch doesn't fix it either, 
so it must just be a broken bios.  But regardless, I'll go read those docs 
and hopefully it'll make more sense then.

-Will

--------------ms060806060505080005050807
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
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wNDA3MTMyMTQzNTVa
MCMGCSqGSIb3DQEJBDEWBBQHAst5euVk4/2Pn9e4+7r7COj0TTBSBgkqhkiG9w0BCQ8xRTBD
MAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzAN
BggqhkiG9w0DAgIBKDB4BgkrBgEEAYI3EAQxazBpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQK
ExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29u
YWwgRnJlZW1haWwgSXNzdWluZyBDQQIDDKVlMHoGCyqGSIb3DQEJEAILMWugaTBiMQswCQYD
VQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UE
AxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECAwylZTANBgkqhkiG9w0B
AQEFAASCAQCM0lSjppNp9LfPflQ3GIigiZTzJtnJBNvyg/iCxDvJHrcGGa7Z86OMUwKZFOI0
qelZHp4TaDh4dtAJWZzz6GYzoHRWUvSzO8mGDGmpu4ajqOV+aNWKJIExgdKg4650h/22PFnm
wEJ/WSuzmPC479PFfF49lggAIi3APblJAOnffCT35dGeUZ4cbnmc/XT4joOhxE6b0Tli7HmH
0zaXer7fImcOuiTfr26PNYvgsc3Ls4G/5TTYAuBJTyOMNqpAKH5UDqVIDig1rqNwdfJ19whH
5Q5jU8Wpm9DqOmARw72e4sRntwJCS7AZ5eD76w8yh0qKB3jybG3X0+WeyZK/YqeJAAAAAAAA

--------------ms060806060505080005050807--
