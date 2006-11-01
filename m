Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423869AbWKABOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423869AbWKABOS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 20:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423906AbWKABOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 20:14:18 -0500
Received: from smtp4.netcabo.pt ([212.113.174.31]:25659 "EHLO
	exch01smtp11.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1423869AbWKABOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 20:14:17 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAAGqDR0VThFhofmdsb2JhbACMSQEB
X-IronPort-AV: i="4.09,377,1157324400"; 
   d="p7s'?scan'208"; a="127034744:sNHT42968772"
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(83.132.128.48):SA:0(-1.3/5.0):. Processed in 2.680166 secs Process 10836)
Subject: Re: 2.6.19-rc[1-4]: boot fail with (lapic && on_battery)
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: earny@net4u.de
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1162340827.2962.13.camel@localhost.portugal>
References: <200610312227.54617.list-lkml@net4u.de>
	 <1162340827.2962.13.camel@localhost.portugal>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-ZbIurkIwC1++cMVBu5B2"
Date: Wed, 01 Nov 2006 01:14:08 +0000
Message-Id: <1162343648.21234.1.camel@localhost.portugal>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
X-OriginalArrivalTime: 01 Nov 2006 01:14:15.0725 (UTC) FILETIME=[0C4EEDD0:01C6FD53]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZbIurkIwC1++cMVBu5B2
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-11-01 at 00:27 +0000, Sergio Monteiro Basto wrote:
> On Tue, 2006-10-31 at 22:27 +0100, Ernst Herzberg wrote:
> > With 2.6.18.x everything works fine.
> >=20
> > But 2.16.19-rc does not boot if the laptop runs on battery _and_ lapic
> > is=20
> > defined as boot parameter.
> >=20
> > The kernel loads and starts, for a fraction of a second some messages
> > appears,
> > then the screen goes blank and nothing more happens.
> >=20
> > I'm unable to read the last message, screen blanking is to fast, but
> > the
> > 'picture' looks like that he stops near the messages where at the
> > normal
> > boot demsg "Local APIC disabled by BIOS -- you can enable it with
> > "lapic""
> > appears. =20
>=20
> Hi,
> If you don't enable lapic, you will see cat /proc/interrupts with
> XT-PIC.
> if you try enable lapic, somehow IRQ routing should change=20
> and if /proc/interrupts still the same, with IRQs on XT-PIC.
> I think, lapic still not enable and you just get problems.
> Unless you know that lapic works, you should try it enable because it a
> trap that just give you a problem.=20
> Some years ago (2002/3) was a very common bug kernel try enable
> automatically lapic (when BIOS don't) and computer hangs .=20
>=20
>=20

s/you should try/you shouldn't try/


--=20
S=E9rgio M.B.

--=-ZbIurkIwC1++cMVBu5B2
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
SIb3DQEJBTEPFw0wNjExMDEwMTE0MDRaMCMGCSqGSIb3DQEJBDEWBBQvMlHopIjd96k29b+1XzlY
w4toNTANBgkqhkiG9w0BAQEFAASCAQA69u1mZX2H4hkMnEi8uYfc9KzttGwEkMauGseXoSoFV4lI
PLhh4qlhHqiSIc0Wxk3OQ4sJNwj/4ioYxoYwkXjDYqO9tDGBkYv5Sb9xEOb4dsZpTNXXEYNoR4vR
hMzbnRFYQ+cIywHqdwIvofEQEH03xURPDrsRKTcry416JNofJkjBtFoZHksOhajo+uRuABUk1kpY
CTsAVDvTCK6Wi8fJPWXJBlWWVfn9iJEpd2nSIZ4YJOvf9bz4GGtVeJF/TF7ko+LgJetMf9VS43q+
M/bx7DA8EpqRlf4qs1uWAaRyMC5Jn0o46mB/dL2VGbe1ELEtd/FSUk60LvvVf85WqYU2AAAAAAAA



--=-ZbIurkIwC1++cMVBu5B2--
