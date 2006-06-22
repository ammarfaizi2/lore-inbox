Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1030467AbWFVAhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030467AbWFVAhK (ORCPT <rfc822;akpm@zip.com.au>);
	Wed, 21 Jun 2006 20:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030463AbWFVAhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 20:37:10 -0400
Received: from smtp1.netcabo.pt ([212.113.174.28]:13212 "EHLO
	exch01smtp10.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1030469AbWFVAhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 20:37:08 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AWYmALF9mUSBToRGgjU
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(213.22.222.3):SA:1(13.9/5.0):. Processed in 12.849663 secs Process 14569)
Subject: who I do know if a interrupt is ioapic_edge_type or 
	ioapic_level_type? [Was Re: [Fwd: Re: [Linux-usb-users] Fwd: Re:
	2.6.17-rc6-mm2 - USB issues]]
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: Johny <kernel@agotnes.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net,
        linux-usb-devel@lists.sourceforge.net, stern@rowland.harvard.edu,
        Chris Wedgwood <cw@f00f.org>, vsu@altlinux.ru
In-Reply-To: <4499245C.8040207@agotnes.com>
References: <44953B4B.9040108@agotnes.com>	<4497DA3F.80302@agotnes.com>
	 <20060620044003.4287426d.akpm@osdl.org>  <4499245C.8040207@agotnes.com>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-qwdcODCZdPSo1fW86WTM"
Date: Thu, 22 Jun 2006 01:36:46 +0100
Message-Id: <1150936606.2855.21.camel@localhost.portugal>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
X-OriginalArrivalTime: 22 Jun 2006 00:37:06.0109 (UTC) FILETIME=[FCD386D0:01C69593]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qwdcODCZdPSo1fW86WTM
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

who I do know if a interrupt is ioapic_edge_type or ioapic_edge_type ?=20

On Wed, 2006-06-21 at 20:50 +1000, Johny wrote:
> Success :)
>=20
> I simply made the change=20
> manually, based on your and others' inputs (it seemed the simpler
> option).
>=20
> Both kernels now boot, and all USB devices are recognised correctly.
>=20

> I run in XT_PIC mode for interrupts.
>=20

Hi, thanks for your positive test on "my" theory.

Here it goes the link that I talked about on last email=20
http://lkml.org/lkml/2005/8/18/92 (you can read the previous messages on
this thread)=20

The patch of this link doesn't compile (at least for me), but have a
simple idea, which is just quirk the VIA_PCIs if they are in XT_PIC mode
and I think that is the way of this quirks should go.

So someone help me out and do a patch that recognize if the interrupt is
in XT-PIC mode or not ?=20

Thanks, =20
--=20
S=E9rgio M. B.

--=-qwdcODCZdPSo1fW86WTM
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
SIb3DQEJBTEPFw0wNjA2MjIwMDM2MzlaMCMGCSqGSIb3DQEJBDEWBBQzt3z7OSrygfNfBcbIBUr0
vi48uTANBgkqhkiG9w0BAQEFAASCAQAr9rR+ijN3aoTbp1yMBi9O51oN7GbDtDEbYw6vrrqQYO8h
aE6sU/Mm9+F2/gBZfgHxQ4SAKog6tEL2CIxeKm9cznk8zcYS+hzPs4h38Ev2BA+WlVGFsq3fiY2c
yPcq3qikU/Kuhj/0ZC5XumRE/aU2rrtMhCA+HPYP5VtCVwkEcQVg4a0YEKGlQSXpvckM8NnyC/2v
x6dJbirBpb9k1P5hNaWoAdjNFlDXfG9xG4kHWzQu2hwqyXrFKRKwkHOC7JlcBMwNY1iEh1BCUwPf
OOMUCyP+3igMVA3oQ6LEd2WffVulS6dL8NgaePlifI4CRuEXovbfU+JNXsfEad/knU7QAAAAAAAA



--=-qwdcODCZdPSo1fW86WTM--
