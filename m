Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751140AbWDWE75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWDWE75 (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 23 Apr 2006 00:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWDWE75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 00:59:57 -0400
Received: from smtp4.netcabo.pt ([212.113.174.31]:58979 "EHLO
	exch01smtp11.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1751140AbWDWE74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 00:59:56 -0400
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(213.22.17.137):SA:1(7.9/5.0):. Processed in 2.078913 secs Process 10456)
Subject: Re: [git Patch 1/1] avoid IRQ0 ioapic pin collision
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: Kimball Murray <kimball.murray@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
In-Reply-To: <20060420230931.10317.38083.sendpatchset@dhcp83-97.boston.redhat.com>
References: <20060420230931.10317.38083.sendpatchset@dhcp83-97.boston.redhat.com>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-rBq9qIkagZvS0K14JEog"
Date: Sun, 23 Apr 2006 06:02:24 +0100
Message-Id: <1145768544.2858.8.camel@localhost.portugal>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
X-OriginalArrivalTime: 23 Apr 2006 04:59:54.0428 (UTC) FILETIME=[C2B10FC0:01C66692]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rBq9qIkagZvS0K14JEog
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-04-20 at 19:14 -0400, Kimball Murray wrote:
> Our system uses an ACPI Interrupt Source Override to inform the OS
> that the
> 8254 timer (IRQ0) is on pin 1 of the ioapic.  On that same ioapic, pin
> 0
> handles an interrupt from a PCI device.  The work-around for the VIA
> chipset
> now causes pin 0 to get IRQ0 on our platform, which the timer also
> claims.
> The sad result is both pins 0 and 1 drive IRQ0, but pins 0 and 1 have
> different triggering characterists (and polarity), so time learches
> forward
> in an IRQ0 interrupt storm.=20

And how I now if my via motherboard suffers this problem ?

Could be something like this messages :
Losing some ticks... checking if CPU frequency changed.

Thanks,
--=20
S=E9rgio M. B.

--=-rBq9qIkagZvS0K14JEog
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
SIb3DQEJBTEPFw0wNjA0MjMwNTAyMTdaMCMGCSqGSIb3DQEJBDEWBBSt/qWVE/K7v3q0tTcfLKIe
EDO76TANBgkqhkiG9w0BAQEFAASCAQBlnqMsJ7kdsvEQmWOe5XbI/ooFl6Fh1ml4/P/dV7fP+O1b
5bDcQVUG7cQB4xVg5K41SFCKN9I6Vzj5cr3Gch8mQ0Iw9SfxyLvl2hLeLgWZzyR26B85gEq3q03f
Ds6AGSP35Vhi3c6rRPSLOEB5kMee01PTTkE+BA+VRBIlnbaw2uoRZnJ+3qqtnrMt21VRcEb9FUDi
CDpO0xF0Qu0NCtk1SlJLOfz+Wn8o0znh0djUtYdUVUgAJF+w/xm8dQGbmZHQ5VMEWYNmnFplvyzP
KtBhv8p/f2DcD6j8Xs3Q0OuZtofzwRqwjZU9bOJ7upCM8riPSErAzrepbIVuEtyxn53bAAAAAAAA



--=-rBq9qIkagZvS0K14JEog--

