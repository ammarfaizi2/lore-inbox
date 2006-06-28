Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932665AbWF1BPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932665AbWF1BPZ (ORCPT <rfc822;akpm@zip.com.au>);
	Tue, 27 Jun 2006 21:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932666AbWF1BPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 21:15:25 -0400
Received: from smtp4.netcabo.pt ([212.113.174.31]:38631 "EHLO
	exch01smtp11.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S932665AbWF1BPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 21:15:24 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AT0KAL50oUSBSocu
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(213.22.16.108):SA:1(8.7/5.0):. Processed in 5.383671 secs Process 19689)
Subject: Re: [Fwd: Re: [Linux-usb-users] Fwd: Re: 2.6.17-rc6-mm2 - USB
	issues]
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: Chris Wedgwood <cw@f00f.org>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, kernel@agotnes.com, akpm@osdl.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb-users@lists.sourceforge.net,
        linux-usb-devel@lists.sourceforge.net, stern@rowland.harvard.edu,
        vsu@altlinux.ru
In-Reply-To: <1151024444.2858.14.camel@localhost.portugal>
References: <4497DA3F.80302@agotnes.com>
	 <20060620044003.4287426d.akpm@osdl.org> <4499245C.8040207@agotnes.com>
	 <1150936606.2855.21.camel@localhost.portugal>
	 <20060621174754.159bb1d0.rdunlap@xenotime.net>
	 <1150938288.3221.2.camel@localhost.portugal>
	 <20060621210817.74b6b2bc.rdunlap@xenotime.net>
	 <1150977386.2859.34.camel@localhost.localdomain>
	 <20060622142902.5c8f8e67.rdunlap@xenotime.net>
	 <1151016398.3022.4.camel@localhost.portugal>
	 <20060622225405.GA5840@tuatara.stupidest.org>
	 <1151024444.2858.14.camel@localhost.portugal>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-FpUxO9khx51kTSzJj6Wy"
Date: Wed, 28 Jun 2006 02:08:32 +0100
Message-Id: <1151456912.2704.13.camel@localhost.portugal>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
X-OriginalArrivalTime: 28 Jun 2006 01:15:23.0296 (UTC) FILETIME=[5488F200:01C69A50]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FpUxO9khx51kTSzJj6Wy
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-06-23 at 02:00 +0100, Sergio Monteiro Basto wrote:
> On Thu, 2006-06-22 at 15:54 -0700, Chris Wedgwood wrote:
> > On Thu, Jun 22, 2006 at 11:46:38PM +0100, Sergio Monteiro Basto
> wrote:
> >=20
> > > yap, in my opinion this function should back to
> >=20
> > > +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID,
> quirk_via_irq);
> >=20
> >=20
> > this is *obviousyl* wrong, it should never have been merged like
> that
> > and there are reports and complaints this causes problems for some
> > people
> >
>=20
> It was like that in kernel 2.6.16 and previous since, I don't know,
> 2.6.9 or 2.6.13 ....=20

Hi, Chris Wedgwood=20
I found the bugzilla report where the initial version of this function
quirk_via_irq (drivers/pci/quirks.c) has been made:
http://bugzilla.kernel.org/show_bug.cgi?id=3D3319#c28
might be interesting  !
--=20
S=E9rgio M. B.

--=-FpUxO9khx51kTSzJj6Wy
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
SIb3DQEJBTEPFw0wNjA2MjgwMTA4MjdaMCMGCSqGSIb3DQEJBDEWBBRh45phCQcxgQX1GzmZHvhc
zWspDzANBgkqhkiG9w0BAQEFAASCAQCXfIxuwZNhnv+OPBL0eO3r+6v6rksLphArdEBnwLuaxJZt
zkhGktpUYRJ4Gdtg8pWczeLxdcDB/LtIAFYxlz4uTm29WmXbXU2n0d2WXUKPJAfaGo4xe6zP1MxB
wTO1yUaxrpwfPgGHNk3vnftRmzJwGcgN4kCjJMFQYV7lbCSkZNMiOJeN8K9wBL6xrAsE9/CuJb06
+npT0XmKsuw23fC+55fmJRMjGAAmdU/QUNdu3ESQzY0g53iyDsv3tU8gX6F4gliOwqsHUyzf8p6v
RL6Ttu5oVhTt5yLvLmIxmgRhs5wh5oQfMYt9wnke/49hTkXxduvp/xWhdeLRmXBS9wLPAAAAAAAA



--=-FpUxO9khx51kTSzJj6Wy--
