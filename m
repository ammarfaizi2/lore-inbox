Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267566AbUIPAZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267566AbUIPAZn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 20:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267563AbUIOVcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 17:32:48 -0400
Received: from uni21mr.unity.ncsu.edu ([152.1.2.137]:22942 "EHLO
	uni21mr.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S267507AbUIOVaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 17:30:11 -0400
Message-ID: <4148B459.6060306@mbio.ncsu.edu>
Date: Wed, 15 Sep 2004 17:30:01 -0400
From: Will Beers <whbeers@mbio.ncsu.edu>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kostadin Karaivanov <k.karaivanov@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: less
References: <6dd83da040914074469c4f521@mail.gmail.com>
In-Reply-To: <6dd83da040914074469c4f521@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms050103010109080505040404"
X-PMX-Version: 4.6.1.107272, Antispam-Core: 4.6.1.106808, Antispam-Data: 2004.9.15.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms050103010109080505040404
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I had this problem (and quite a few others), and what seems to work for me 
is to disable CONFIG_LEGACY_PTYS.

Will

Kostadin Karaivanov wrote:
> I'm slackware user
> today I upgraded mu box to kernel 2.6.9-rc2
> for surprize the command less stops to work
> after displaying of exactly one screen output it exits with following
> 
> here is e example 
> #man ip
> ...........................
> Error executing formatting or display command.
> System command /bin/bzip2 -c -d /usr/man/cat8/ip.8.bz2 | /usr/bin/less
> -is exited with status 256.
> root@larry:~#
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--------------ms050103010109080505040404
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
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wNDA5MTUyMTMwMDFa
MCMGCSqGSIb3DQEJBDEWBBQyAJkwkglT6B41F9q/mG9TWZ83rTBSBgkqhkiG9w0BCQ8xRTBD
MAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzAN
BggqhkiG9w0DAgIBKDB4BgkrBgEEAYI3EAQxazBpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQK
ExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29u
YWwgRnJlZW1haWwgSXNzdWluZyBDQQIDDKVlMHoGCyqGSIb3DQEJEAILMWugaTBiMQswCQYD
VQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UE
AxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECAwylZTANBgkqhkiG9w0B
AQEFAASCAQAm5dADYKPR8h4GbTyVKUC6H45QATSfw0mbFWg6ofCi/dBpRpLNeRADiUT9hUNv
eVvia2FaFeqsBerrcLDTwAyZb//efa2xx552M5T3175Sxepll0D2GUwPdjwgVFTPwnbDsKmd
l8F3r/VJUSOgpmScqLk9wq3Ag8gzKLpHtMhM2wIc18AEJiOqwtc2gf2d0tk5/0qzZ2wCUWzV
iECcdibDH9cmoL3+ezFuwBMzFDfiwueI7oWHgANjFgM5UtBGjMSezPwiJbjLd+wcUSzYu2dX
KWQEEHKl/ZR4MM99S/3o6IcZ/0/tTs1T32irSmkGCsmxnF2M2XttMUZyyFwKt7s9AAAAAAAA

--------------ms050103010109080505040404--
