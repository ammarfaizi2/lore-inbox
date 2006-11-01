Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946241AbWKAA1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946241AbWKAA1T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 19:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946244AbWKAA1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 19:27:19 -0500
Received: from smtp3.netcabo.pt ([212.113.174.30]:18635 "EHLO
	exch01smtp12.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1946241AbWKAA1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 19:27:18 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAO93R0VThFhodGdsb2JhbACMSQE
X-IronPort-AV: i="4.09,376,1157324400"; 
   d="p7s'?scan'208"; a="131810690:sNHT1086970194"
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(83.132.128.48):SA:0(-1.3/5.0):. Processed in 2.891968 secs Process 10419)
Subject: Re: 2.6.19-rc[1-4]: boot fail with (lapic && on_battery)
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: earny@net4u.de
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200610312227.54617.list-lkml@net4u.de>
References: <200610312227.54617.list-lkml@net4u.de>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-VKkg2VLaLsHTFuJu0tje"
Date: Wed, 01 Nov 2006 00:27:07 +0000
Message-Id: <1162340827.2962.13.camel@localhost.portugal>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
X-OriginalArrivalTime: 01 Nov 2006 00:27:17.0031 (UTC) FILETIME=[7C3C5B70:01C6FD4C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-VKkg2VLaLsHTFuJu0tje
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-10-31 at 22:27 +0100, Ernst Herzberg wrote:
> With 2.6.18.x everything works fine.
>=20
> But 2.16.19-rc does not boot if the laptop runs on battery _and_ lapic
> is=20
> defined as boot parameter.
>=20
> The kernel loads and starts, for a fraction of a second some messages
> appears,
> then the screen goes blank and nothing more happens.
>=20
> I'm unable to read the last message, screen blanking is to fast, but
> the
> 'picture' looks like that he stops near the messages where at the
> normal
> boot demsg "Local APIC disabled by BIOS -- you can enable it with
> "lapic""
> appears. =20

Hi,
If you don't enable lapic, you will see cat /proc/interrupts with
XT-PIC.
if you try enable lapic, somehow IRQ routing should change=20
and if /proc/interrupts still the same, with IRQs on XT-PIC.
I think, lapic still not enable and you just get problems.
Unless you know that lapic works, you should try it enable because it a
trap that just give you a problem.=20
Some years ago (2002/3) was a very common bug kernel try enable
automatically lapic (when BIOS don't) and computer hangs .=20


--=20
S=E9rgio M.B.

--=-VKkg2VLaLsHTFuJu0tje
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
SIb3DQEJBTEPFw0wNjExMDEwMDI3MDRaMCMGCSqGSIb3DQEJBDEWBBQkIvczDs1hPIyPDYuCnNNS
QZPg7zANBgkqhkiG9w0BAQEFAASCAQCMZByb55GZT5+d498sLPNb+imALuHMJsUWjNEeF7ybI4BJ
yTh+3oAjHGrao3GjEBK3k3xI3z19RaVqEh4kbZnRBhfxrGSnugwgsnDlbvs1d6SuYQcIjMDdXqSa
fwkNcGJKRCztLsdAff5H0nE7hjrsynIl67tNDH0BD5XcWbebVyHRyu8Z5canIkIcADUAQqI1Hq2Z
Eck16w5i2WA33A/SGDqtESDcIZD+pf3k9sNhwl8YljYmagKFm5EWLHlPVrMU3nIsXbOVOQi98luS
j+njb0UREKaiEwTJ5N7xkxeDeC5q6u0SVMcsEg72sgkB//gSBA1c6JPTIIUsBz75i30dAAAAAAAA



--=-VKkg2VLaLsHTFuJu0tje--
