Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266536AbUGQAWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266536AbUGQAWo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 20:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266663AbUGQAWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 20:22:44 -0400
Received: from [213.239.201.226] ([213.239.201.226]:12446 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S266536AbUGQAWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 20:22:38 -0400
Message-ID: <40F873C4.8050404@shadowconnect.com>
Date: Sat, 17 Jul 2004 02:33:08 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linuxpower.ca>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: Problem with ioremap which returns NULL in 2.6 kernel
References: <40BC788A.3020103@shadowconnect.com> <20040601142122.GA7537@havoc.gtf.org> <40BC9EF7.4060502@shadowconnect.com> <Pine.LNX.4.58.0406011228130.1794@montezuma.fsmlabs.com> <40BDC553.4060809@shadowconnect.com> <Pine.LNX.4.58.0407161328030.26950@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.58.0407161328030.26950@montezuma.fsmlabs.com>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms060007090505040008030605"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms060007090505040008030605
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Zwane Mwaikambo wrote:
>>>>>probably too large an area to be remapping.  Try remapping only the
>>>>>memory area needed, and not the entire area.
>>>>Is there a way, to increase the size, which could be remapped, or is
>>>>there a way, to find out what is the maximum size which could be remapped?
>>>>Thank you very much for the fast answer!
>>>You could try a 4G/4G enabled kernel, /proc/meminfo tells you how much
>>>vmalloc (ioremap) space there is too.
>>VmallocTotal:   245752 kB
>>VmallocUsed:    137720 kB
>>VmallocChunk:   107904 kB
>>Okay, i see the problem now, the largest piece of memory which could be
>>allocated is 107904 kB, right?
>>Is the 4G/4G split already in the kernel? If yes, which entry activates it?
 >
> No it's not in the current kernel, you'd have to download the patch, the
> most uptodate being the one in the Fedora/Redhat kernel tree.

Okay, thank you very much!

Best regards,


Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com

--------------ms060007090505040008030605
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIKPzCC
Az8wggKooAMCAQICAQ0wDQYJKoZIhvcNAQEFBQAwgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQI
EwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEaMBgGA1UEChMRVGhhd3RlIENv
bnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24gU2VydmljZXMgRGl2aXNpb24xJDAi
BgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTErMCkGCSqGSIb3DQEJARYccGVy
c29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMzA3MTcwMDAwMDBaFw0xMzA3MTYyMzU5
NTlaMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBM
dGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQTCBnzAN
BgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAxKY8VXNV+065yplaHmjAdQRwnd/p/6Me7L3N9Vvy
Gna9fww6YfK/Uc4B1OVQCjDXAmNaLIkVcI7dyfArhVqqP3FWy688Cwfn8R+RNiQqE88r1fOC
dz0Dviv+uxg+B79AgAJk16emu59l0cUqVIUPSAR/p7bRPGEEQB5kGXJgt/sCAwEAAaOBlDCB
kTASBgNVHRMBAf8ECDAGAQH/AgEAMEMGA1UdHwQ8MDowOKA2oDSGMmh0dHA6Ly9jcmwudGhh
d3RlLmNvbS9UaGF3dGVQZXJzb25hbEZyZWVtYWlsQ0EuY3JsMAsGA1UdDwQEAwIBBjApBgNV
HREEIjAgpB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVsMi0xMzgwDQYJKoZIhvcNAQEFBQAD
gYEASIzRUIPqCy7MDaNmrGcPf6+svsIXoUOWlJ1/TCG4+DYfqi2fNi/A9BxQIJNwPP2t4WFi
w9k6GX6EsZkbAMUaC4J0niVQlGLH2ydxVyWN3amcOY6MIE9lX5Xa9/eH1sYITq726jTlEBpb
NU1341YheILcIRk13iSx0x1G/11fZU8wggN6MIIC46ADAgECAgML8dEwDQYJKoZIhvcNAQEE
BQAwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0
ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA0
MDMxODE0MzM0MVoXDTA1MDMxODE0MzM0MVowgeAxCzAJBgNVBAYTAkRFMQ8wDQYDVQQIEwZC
YXllcm4xETAPBgNVBAcTCEtydW1iYWNoMScwJQYDVQQKEx5TaGFkb3cgQ29ubmVjdCBHbWJI
IChJbnRlcm5ldCkxHTAbBgNVBAwTFFNlbmlvciBJVCBDb25zdWx0YW50MQ4wDAYDVQQEEwVM
aWRlbDEPMA0GA1UEKhMGTWFya3VzMRUwEwYDVQQDEwxNYXJrdXMgTGlkZWwxLTArBgkqhkiG
9w0BCQEWHk1hcmt1cy5MaWRlbEBzaGFkb3djb25uZWN0LmNvbTCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBAPmIWQ2zrKutnkd7iB3AQTEwE9q9p7Cs7F3f92dh29+RHpDpAGMv
ZlVxLBNPBkvPdhcVeWLHbKI2XKfjzLzXhVPZEs41KkSecQ9bOLMSu+T6y2SKvcnf0Qxw8pZ1
KJwkIJ0RcLyIUPE0RI/RG0DaBY6toApoLQEJOzKsdxuTUOK94m9kwSCRNJdjuZtYCAOihAVC
fl9vJJNFUw9h4mmZ4RWsjh85kvvqKK3Bo6eYia74AuXH6kWgvuvkyW0w8S9J8f62KXcVNQ8N
Zr9Gd4rclfNj55i73p+FL6opHjhryKa9GIV7IzpEp6q1LQ1OD/glJEaR/Vl0l1YQVWU24dUR
NtsCAwEAAaM7MDkwKQYDVR0RBCIwIIEeTWFya3VzLkxpZGVsQHNoYWRvd2Nvbm5lY3QuY29t
MAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEEBQADgYEADutiuioIWfT1dzLD72TWc2y3yxg2
sJOZhJQYvZYxdwFh3MOht+Jd/JizLQvOsM+HXuU4qLTyCpYB+AfPpQH3xObQVBWV23d6nBkA
2QWie/BD18wl8Xv2bKykXyvW66l2Kk9VsROUlAQi2GyLiFGd9SvNJcTwNtbqV/8ojXmu7XIw
ggN6MIIC46ADAgECAgML8dEwDQYJKoZIhvcNAQEEBQAwYjELMAkGA1UEBhMCWkExJTAjBgNV
BAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA0MDMxODE0MzM0MVoXDTA1MDMxODE0MzM0
MVowgeAxCzAJBgNVBAYTAkRFMQ8wDQYDVQQIEwZCYXllcm4xETAPBgNVBAcTCEtydW1iYWNo
MScwJQYDVQQKEx5TaGFkb3cgQ29ubmVjdCBHbWJIIChJbnRlcm5ldCkxHTAbBgNVBAwTFFNl
bmlvciBJVCBDb25zdWx0YW50MQ4wDAYDVQQEEwVMaWRlbDEPMA0GA1UEKhMGTWFya3VzMRUw
EwYDVQQDEwxNYXJrdXMgTGlkZWwxLTArBgkqhkiG9w0BCQEWHk1hcmt1cy5MaWRlbEBzaGFk
b3djb25uZWN0LmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAPmIWQ2zrKut
nkd7iB3AQTEwE9q9p7Cs7F3f92dh29+RHpDpAGMvZlVxLBNPBkvPdhcVeWLHbKI2XKfjzLzX
hVPZEs41KkSecQ9bOLMSu+T6y2SKvcnf0Qxw8pZ1KJwkIJ0RcLyIUPE0RI/RG0DaBY6toApo
LQEJOzKsdxuTUOK94m9kwSCRNJdjuZtYCAOihAVCfl9vJJNFUw9h4mmZ4RWsjh85kvvqKK3B
o6eYia74AuXH6kWgvuvkyW0w8S9J8f62KXcVNQ8NZr9Gd4rclfNj55i73p+FL6opHjhryKa9
GIV7IzpEp6q1LQ1OD/glJEaR/Vl0l1YQVWU24dURNtsCAwEAAaM7MDkwKQYDVR0RBCIwIIEe
TWFya3VzLkxpZGVsQHNoYWRvd2Nvbm5lY3QuY29tMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcN
AQEEBQADgYEADutiuioIWfT1dzLD72TWc2y3yxg2sJOZhJQYvZYxdwFh3MOht+Jd/JizLQvO
sM+HXuU4qLTyCpYB+AfPpQH3xObQVBWV23d6nBkA2QWie/BD18wl8Xv2bKykXyvW66l2Kk9V
sROUlAQi2GyLiFGd9SvNJcTwNtbqV/8ojXmu7XIxggM7MIIDNwIBATBpMGIxCzAJBgNVBAYT
AlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNU
aGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIDC/HRMAkGBSsOAwIaBQCgggGn
MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA0MDcxNzAwMzMw
OVowIwYJKoZIhvcNAQkEMRYEFHbf1ek4ebro5hYdDfG4zG1YEqONMFIGCSqGSIb3DQEJDzFF
MEMwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIH
MA0GCCqGSIb3DQMCAgEoMHgGCSsGAQQBgjcQBDFrMGkwYjELMAkGA1UEBhMCWkExJTAjBgNV
BAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAgML8dEwegYLKoZIhvcNAQkQAgsxa6BpMGIxCzAJ
BgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYD
VQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIDC/HRMA0GCSqGSIb3
DQEBAQUABIIBACGkP5QnMoAqh7J85jINAm8RCNSPokI4Y0MBeTwgrjMbXT+NGUzU3XSVlbNP
6oepoy2iJh3UaT2lYTo37RokkcKsO9d8bB8WTjzVVvVaENmXGOTjD0vbgtWSHH8UGFCxM9Af
sMDL0WWYN4a4pqxsTVBNpw/ElndCyaNuPpdfC8HiqSNypntnUrXL9cB1ZFadbDrHZIbnEfe1
9Fwnl+WvM1YP3O2ftcS51ZuDa4i6WlSfSdi7/BI4Sm5B8gKrDfv+T+FL1IGJhFw1T4LA3GwL
2+5u9EfBMebOuisyummtnsnLfpnzaICuUSs/cvqdA7PvBR1QXQ1DIibJB/+9tqD2HboAAAAA
AAA=
--------------ms060007090505040008030605--
