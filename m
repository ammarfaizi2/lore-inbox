Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161291AbWJYAmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161291AbWJYAmA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 20:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161295AbWJYAmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 20:42:00 -0400
Received: from smtp1.netcabo.pt ([212.113.174.28]:64420 "EHLO
	exch01smtp10.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1161291AbWJYAmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 20:42:00 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CACpQPkVThFhodGdsb2JhbACBTIplAQ
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(83.132.128.144):SA:0(0.6/5.0):. Processed in 4.177876 secs Process 724)
Subject: RE: PROBLEM: Oops when doing disk heavy disk I/O
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: Michael <michael.sallaway@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <453eae16.5da1afe7.3681.ffffb56e@mx.google.com>
References: <453eae16.5da1afe7.3681.ffffb56e@mx.google.com>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-38oo0klig/38Maq7awca"
Date: Wed, 25 Oct 2006 01:41:46 +0100
Message-Id: <1161736906.2922.14.camel@localhost.portugal>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
X-OriginalArrivalTime: 25 Oct 2006 00:41:58.0171 (UTC) FILETIME=[608B66B0:01C6F7CE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-38oo0klig/38Maq7awca
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-10-25 at 10:21 +1000, Michael wrote:
> =20
> > -----Original Message-----
> > From: Sergio Monteiro Basto [mailto:sergio@sergiomb.no-ip.org]=20
> > Sent: Wednesday, 25 October 2006 3:27 AM
> >=20
> > Hi,=20
> > please boot with "report_lost_ticks" like
> > http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D115545986619977&w=3D=
2
> > and see if you have=20
> > time.c: Lost n timer tick(s)!
> >=20
> > and=20
> > cat /sys/devices/system/clocksource/clocksource0/
> >=20
> > cat /sys/devices/system/clocksource/clocksource0/current_clocksource
> >=20
> >=20
>=20
> Hi,
>=20
> Yep, seems to be losing some ticks -- I'm not sure what that means, but i=
s
> it bad? :-)
>=20

well I don't know for sure , but after this initials Lost Timer tick ,
it appears more after a few time of uptime ?=20


> [ root @ barbossa : ~ ] # dmesg | grep tick
> Command line: root=3D/dev/md1 ro report_lost_ticks
> Kernel command line: root=3D/dev/md1 ro report_lost_ticks
> time.c: Lost 1 timer tick(s)! rip release_console_sem+0x196/0x20c)
> time.c: Lost 12 timer tick(s)! rip setup_boot_APIC_clock+0x11f/0x121)
> time.c: Lost 2 timer tick(s)! rip __do_softirq+0x4a/0xc4)
>=20

>=20
> Also, for the clocksource:
> [ root @ barbossa : ~ ] # cat
> /sys/devices/system/clocksource/clocksource0/available_clocksource
> jiffies
>=20
> [ root @ barbossa : ~ ] # cat
> /sys/devices/system/clocksource/clocksource0/current_clocksource
> jiffies
>=20
>=20
> Thanks for your help.
>=20
> Cheers,
> Michael
>=20

--=20
S=E9rgio M.B.

--=-38oo0klig/38Maq7awca
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
SIb3DQEJBTEPFw0wNjEwMjUwMDQxNDFaMCMGCSqGSIb3DQEJBDEWBBQNbysIzr0w4J3yyKNBPZxX
El03lTANBgkqhkiG9w0BAQEFAASCAQAaDbI3Fz6Gr8c/ccxJ7zktObIBG9cKJA2FtlP0rDXQPRn/
0/wbtYQHYUT3XC2dNPVI19HkxCDf3mnXEpRPAX7xqYAQMp3vwBBL73Mb06/JcwPcbc4qAZtPPW88
9qE/ZD2L9skGqm0X22uvzDmBFKEBt+A9HdQ85Wk1kJqXE6QSqk3Oavd/zzM1MdyD3gGaRtAK8yXh
k/+8Lr2o2Wt02cxl31TFXQHlLMj0kWJU4lO1z4ilM7nCBGWBIInps3m8QlCgEWDCwuja+ohb97Xv
wx/ExUf/PsZ9WsS16xkggshfcQ32TJLPz8gB59r+PeF6BXNi/8HVOrhIOeAoWJXTgjRjAAAAAAAA



--=-38oo0klig/38Maq7awca--
