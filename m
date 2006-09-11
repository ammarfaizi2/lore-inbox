Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965070AbWIKVYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965070AbWIKVYI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 17:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965068AbWIKVYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 17:24:08 -0400
Received: from smtp4.netcabo.pt ([212.113.174.31]:13574 "EHLO
	exch01smtp11.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S965067AbWIKVYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 17:24:05 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AcwMAOFwBUWBT4hh
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(83.132.181.24):SA:0(-1.2/5.0):. Processed in 4.531118 secs Process 26446)
Subject: Re: [PATCH V3] VIA IRQ quirk behaviour change
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: Stian Jordet <liste@jordet.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Daniel Drake <dsd@gentoo.org>,
       akpm@osdl.org, torvalds@osdl.org, jeff@garzik.org, greg@kroah.com,
       cw@f00f.org, bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org,
       harmon@ksu.edu, len.brown@intel.com, vsu@altlinux.ru
In-Reply-To: <1158005769.4748.0.camel@localhost.localdomain>
References: <20060907223313.1770B7B40A0@zog.reactivated.net>
	 <1157811641.6877.5.camel@localhost.localdomain>
	 <4502D35E.8020802@gentoo.org>
	 <1157817836.6877.52.camel@localhost.localdomain>
	 <45033370.8040005@gentoo.org>
	 <1157848272.6877.108.camel@localhost.localdomain>
	 <450436F1.8070203@gentoo.org>
	 <1157906395.23085.18.camel@localhost.localdomain>
	 <4504621E.5090202@gentoo.org>
	 <1157917308.23085.26.camel@localhost.localdomain>
	 <1157916102.21295.9.camel@localhost.localdomain>
	 <1157988809.13889.5.camel@localhost.localdomain>
	 <1158005769.4748.0.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-ivKKwxb+TXH5yJGgRuU/"
Date: Mon, 11 Sep 2006 22:23:54 +0100
Message-Id: <1158009834.3434.4.camel@localhost.portugal>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
X-OriginalArrivalTime: 11 Sep 2006 21:24:03.0064 (UTC) FILETIME=[9AAA9F80:01C6D5E8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ivKKwxb+TXH5yJGgRuU/
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-09-11 at 22:16 +0200, Stian Jordet wrote:
> On man, 2006-09-11 at 16:33 +0100, Sergio Monteiro Basto wrote:
> > On Sun, 2006-09-10 at 21:21 +0200, Stian Jordet wrote:
> > > On s=F8n, 2006-09-10 at 20:41 +0100, Alan Cox wrote:
> > > > Feel free to cc me the lspci data and partial diagnostics and I'll =
try
> > > > and help too.
> > >=20
> > > Attached is lspci -xxx and dmesg from 2.6.18-rc6.
> > > http://bugzilla.kernel.org/show_bug.cgi?id=3D2874 has some further
> > > information about this (stupid) motherboard. Anything else you need?
> > >=20
> > > If anyone can help me with this, I'll promise to send the hero some
> > > boxes of Norwegian beer!
> > >=20
> > >=20
> > Hi, this isn't the case of one USB with IO-APIC-level on legacy
> > interrupts ?=20
> >  11:       5333       5326   IO-APIC-level  uhci_hcd:usb1, uhci_hcd:usb=
2, uhci_hcd:usb3
> >=20
> > if it is , was resolved with this [PATCH V3] VIA IRQ quirk behaviour ch=
ange ?=20
>=20
> I have no idea what you mean here, but it's by no means fixed by that
> patch, actually it just got worse (usb didn't work, but still got
> interrupts from eth0 - and it still used irq 11)

What ?! Aren't we talk about this computer=20
http://lkml.org/lkml/2006/9/6/178
and this=20
http://lkml.org/lkml/2006/9/7/220

if you don't get your device quirked we have add your hardware to the
list ...

Thanks,
--=20
S=E9rgio M. B.

--=-ivKKwxb+TXH5yJGgRuU/
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
SIb3DQEJBTEPFw0wNjA5MTEyMTIzNTBaMCMGCSqGSIb3DQEJBDEWBBQR6xCigrgT0NAIKv3qZoDX
ODH6fjANBgkqhkiG9w0BAQEFAASCAQAKtTIrxbpGOgcvWGWCRLpWXmCta6COhChqD+STOSqfgUMO
Q9HWVSeEp4RW0l4aLHkj2jWY5Zb2pbBr5fJDAMmpu3/lbBniOtyEtxOCoGWB4LTOPn5sQ+lUymzk
bTlWay88oKkuo9LQnRCv5qpK3pU8mYzBI89fIzVYsKPCxXQglDTqblXT0v8cSsYjuXLq/J2M3O+9
hmKkg103VhepMmzeIe1KqmIFtggdvAtA8eizdGN+0cJvtNcMBDC2GXkuUCqXNpiVHCf4RbNE4FBC
ra28wWsAKTN31fb1IGmJmUk8FdD904LVYoKcFuw8o8rwmc9aXYMVzT7wucD2IsYikpwHAAAAAAAA



--=-ivKKwxb+TXH5yJGgRuU/--
