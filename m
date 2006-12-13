Return-Path: <linux-kernel-owner+w=401wt.eu-S964939AbWLMF0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbWLMF0K (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 00:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964938AbWLMF0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 00:26:10 -0500
Received: from smtp2.netcabo.pt ([212.113.174.29]:32624 "EHLO
	exch01smtp09.hdi.tvcabo" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964939AbWLMF0I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 00:26:08 -0500
X-Greylist: delayed 549 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 00:26:08 EST
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CANYbf0VThFhodGdsb2JhbACNUwE
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(83.132.128.36):SA:0(-1.4/5.0):. Processed in 4.259227 secs Process 14408)
Subject: BUG# 6419, via-rhine II could be the problem
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Adam Majer <adamm@zombino.com>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-+TexyPvq8/Tj1xWegx/o"
Date: Wed, 13 Dec 2006 05:16:53 +0000
Message-Id: <1165987013.3437.24.camel@monteirov>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
X-OriginalArrivalTime: 13 Dec 2006 05:16:58.0092 (UTC) FILETIME=[E9814AC0:01C71E75]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+TexyPvq8/Tj1xWegx/o
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

My bug http://bugzilla.kernel.org/show_bug.cgi?id=3D6419

Today I found that my computer hang problem could be just a problem with
via-rhine II.

I got exactly the same problem describe on=20
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D245398;msg=3D107

I had transfer by eth0 (via-rhine II), about 3500 files, about 15 Giga
bytes and when rsync over ssh stops transfer (eth0 has got problems), I
could press ctrl-c , abort rsync restart network , and continue the
rsync.
Or just restart network which remove via-rhine modules and reinsert it.
But if I left the computer with rsync stopped after some minutes
computer hangs.

netstat -i also give me some 2 or 3 TX-ERR s=20
=20
Any ideas to test this ? =20

Thanks,
--=20
S=E9rgio M.B.

--=-+TexyPvq8/Tj1xWegx/o
Content-Type: application/x-pkcs7-signature; name=smime.p7s
Content-Disposition: attachment; filename=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGSTCCAwIw
ggJroAMCAQICAw/vkjANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhh
d3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVt
YWlsIElzc3VpbmcgQ0EwHhcNMDUxMTI4MjIyODU2WhcNMDYxMTI4MjIyODU2WjBLMR8wHQYDVQQD
ExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMSgwJgYJKoZIhvcNAQkBFhlzZXJnaW9Ac2VyZ2lvbWIu
bm8taXAub3JnMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApCNuKD3pz8GRKd1q+36r
m0z7z+TBsbTrVa45UQsEeh9OQGZIASJMH5erC0u6KbKJ+km97RLOdsgSlKG6+5xuzsk+aqU7A0Gp
kMjzIJT7UH/bbPnIFMQNnWJxluuYq1u+v8iIbfezQy1+SXyAyBv+OC7LnCOiOar/L9AD9zDy2fPX
EqEDlbO3CJsoaR4Va8sgtoV0NmKnAt7DA0iZ2dmlsw6Qh+4euI+FgZ2WHPBQnfJ7PfSH5GIWl/Nx
eUqnYpDaJafk/l94nX71UifdPXDMxJJlEOGqV9l4omhNlPmsZ/zrGXgLdBv9JuPjJ9mxhgwZsZbz
VBc8emB0i3A7E6D6rwIDAQABo1kwVzAOBgNVHQ8BAf8EBAMCBJAwEQYJYIZIAYb4QgEBBAQDAgUg
MCQGA1UdEQQdMBuBGXNlcmdpb0BzZXJnaW9tYi5uby1pcC5vcmcwDAYDVR0TAQH/BAIwADANBgkq
hkiG9w0BAQQFAAOBgQBIVheRn3oHTU5rgIFHcBRxkIhOYPQHKk/oX4KakCrDCxp33XAqTG3aIG/v
dsUT/OuFm5w0GlrUTrPaKYYxxfQ00+3d8y87aX22sUdj8oXJRYiPgQiE6lqu9no8axH6UXCCbKTi
8383JcxReoXyuP000eUggq3tWr6fE/QmONUARzCCAz8wggKooAMCAQICAQ0wDQYJKoZIhvcNAQEF
BQAwgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUg
VG93bjEaMBgGA1UEChMRVGhhd3RlIENvbnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24g
U2VydmljZXMgRGl2aXNpb24xJDAiBgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTEr
MCkGCSqGSIb3DQEJARYccGVyc29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMzA3MTcwMDAw
MDBaFw0xMzA3MTYyMzU5NTlaMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3Vs
dGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWlu
ZyBDQTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAxKY8VXNV+065yplaHmjAdQRwnd/p/6Me
7L3N9VvyGna9fww6YfK/Uc4B1OVQCjDXAmNaLIkVcI7dyfArhVqqP3FWy688Cwfn8R+RNiQqE88r
1fOCdz0Dviv+uxg+B79AgAJk16emu59l0cUqVIUPSAR/p7bRPGEEQB5kGXJgt/sCAwEAAaOBlDCB
kTASBgNVHRMBAf8ECDAGAQH/AgEAMEMGA1UdHwQ8MDowOKA2oDSGMmh0dHA6Ly9jcmwudGhhd3Rl
LmNvbS9UaGF3dGVQZXJzb25hbEZyZWVtYWlsQ0EuY3JsMAsGA1UdDwQEAwIBBjApBgNVHREEIjAg
pB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVsMi0xMzgwDQYJKoZIhvcNAQEFBQADgYEASIzRUIPq
Cy7MDaNmrGcPf6+svsIXoUOWlJ1/TCG4+DYfqi2fNi/A9BxQIJNwPP2t4WFiw9k6GX6EsZkbAMUa
C4J0niVQlGLH2ydxVyWN3amcOY6MIE9lX5Xa9/eH1sYITq726jTlEBpbNU1341YheILcIRk13iSx
0x1G/11fZU8xggHvMIIB6wIBATBpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29u
c3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNz
dWluZyBDQQIDD++SMAkGBSsOAwIaBQCgXTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqG
SIb3DQEJBTEPFw0wNjEyMTMwNTE2NTNaMCMGCSqGSIb3DQEJBDEWBBQmONuiYlKuoFMK+zol3PEh
h39pnDANBgkqhkiG9w0BAQEFAASCAQAPNapaoTvXEHOiBMJfLr1fzxHF+re/haJDhwRX8V5a+C8+
+Di5rMmt8HsMuvb5/LZkmw7nmABN7vxLAucRODzPfexXK7hOS6FQeofNmXXBIpNqnu882vjeid4o
Y9i2O3hPPzehrR1wVCc7mhNIX5hBG3WOuCroj60viHr/buHLFiq9kfdJF+Hl4/vetCDfB6OwqK5h
FocSaX7Xy3Akt9wsH+ej0pN/sLKVNXdpjAeUYmNj125Lh7kHU3K0TYeIy1u4yjq0fKF3s46w/QnT
X2fQTwlprNonSLDMa0DSR0AIWHOSl/WmJsw7Xcy5jW+K6T//s20Xw3qs7/20OAzAtJn3AAAAAAAA



--=-+TexyPvq8/Tj1xWegx/o--
