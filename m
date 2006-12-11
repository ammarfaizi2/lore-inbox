Return-Path: <linux-kernel-owner+w=401wt.eu-S1760803AbWLKBnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760803AbWLKBnH (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 20:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761779AbWLKBnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 20:43:07 -0500
Received: from smtp1.netcabo.pt ([212.113.174.28]:19995 "EHLO
	exch01smtp10.hdi.tvcabo" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760803AbWLKBnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 20:43:04 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAAL5FfEVThFhodGdsb2JhbACNTgE
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(83.132.128.105):SA:0(0.1/5.0):. Processed in 4.284683 secs Process 19053)
Subject: Re: RFC: PCI quirks update for 2.6.16
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Daniel Drake <dsd@gentoo.org>, Daniel Ritz <daniel.ritz@gmx.ch>,
       Jean Delvare <khali@linux-fr.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Linus Torvalds <torvalds@osdl.org>, Brice Goglin <brice@myri.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       Bauke Jan Douma <bjdouma@xs4all.nl>,
       Tomasz Koprowski <tomek@koprowski.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <20061210160053.GD10351@stusta.de>
References: <20061207132430.GF8963@stusta.de> <45782774.8060002@gentoo.org>
	 <1165723779.334.3.camel@localhost.localdomain>
	 <20061210160053.GD10351@stusta.de>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-PdyIA3glG/bL2/4cnYSl"
Date: Mon, 11 Dec 2006 01:42:48 +0000
Message-Id: <1165801368.2987.20.camel@monteirov>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
X-OriginalArrivalTime: 11 Dec 2006 01:42:58.0679 (UTC) FILETIME=[AFCAD870:01C71CC5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PdyIA3glG/bL2/4cnYSl
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-12-10 at 17:00 +0100, Adrian Bunk wrote:
> +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID,
> quirk_via_irq);

This is back to state of kernel 2.6.16 final (without .x)

In kernel 2.6.17 final we got
(http://lkml.org/lkml/2006/4/19/16)
commit 75cf7456dd87335f574dcd53c4ae616a2ad71a11=20
Author: Chris Wedgwood <cw@f00f.org>
Date:   Tue Apr 18 23:57:09 2006 -0700=20
    Signed-off-by: Chris Wedgwood <cw@f00f.org>
    Acked-by: Jeff Garzik <jeff@garzik.org>
    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
and=20
commit a7b862f663d81858531dfccc0537bc9d8a2a4121
Author: Chris Wedgwood <cw@f00f.org>
Date:   Mon May 15 09:43:55 2006 -0700
    [PATCH] VIA quirk fixup, additional PCI IDs   =20

BUT the latest stable and tested patch is the commit 09d6029f43ebbe7307854a=
bdae204c25d711ff94
PCI: VIA IRQ quirk behaviour change, which in my opinion that should go in.

Thanks,
--=20
S=E9rgio M.B.

--=-PdyIA3glG/bL2/4cnYSl
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
SIb3DQEJBTEPFw0wNjEyMTEwMTQyNDRaMCMGCSqGSIb3DQEJBDEWBBSwj00cc+IsKHatfRYQj2ug
MChrcDANBgkqhkiG9w0BAQEFAASCAQB2+JiXrxMbXyFqqljLGbB5bqI0Jv5b/FE/NMB0hR0J7Z+8
K4FpKhro1tZONYWsRmMy97KNhh9OMDZmx1NKGy5FHoSyy7KUS30mRHSnZ3CL2oDuhMDcCkWJGAxr
DaR2FOWOApau3idOdHgs8Win6tNLs2gNrKjJ1bMKYj/fMgZ0mJqxZINJDu/bYejyGRPXFPnEhKXv
TDDB/alsXOJbb/a4j8CzmXK6ULAkcCFbettc0BM8oeY+BCmWpZIBLCGD5N3CmLTVvidA5ItUYTaT
exV0bvlrNwXmEYpTAtaCXE/FPZTTFDaduLTjjMG3t2Hyg/rtVxE15tQbCrwwfItPZDlAAAAAAAAA



--=-PdyIA3glG/bL2/4cnYSl--
