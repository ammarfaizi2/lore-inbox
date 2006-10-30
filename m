Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030493AbWJ3DLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030493AbWJ3DLI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 22:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030497AbWJ3DLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 22:11:08 -0500
Received: from smtp4.netcabo.pt ([212.113.174.31]:50300 "EHLO
	exch01smtp11.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1030493AbWJ3DLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 22:11:06 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CANb7REVThFhodGdsb2JhbACBTIpo
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(83.132.128.22):SA:0(-1.3/5.0):. Processed in 7.853461 secs Process 13682)
Subject: Re: AMD X2 unsynced TSC fix?
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: Andi Kleen <ak@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, Chris Friesen <cfriesen@nortel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>
In-Reply-To: <1162009373.26022.22.camel@localhost.localdomain>
References: <1161969308.27225.120.camel@mindpipe>
	 <1161986902.27225.206.camel@mindpipe>
	 <1162007907.26022.13.camel@localhost.localdomain>
	 <200610272106.13115.ak@suse.de>
	 <1162009373.26022.22.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-V2FCF72gJmVGwVJ3fS27"
Date: Mon, 30 Oct 2006 03:10:48 +0000
Message-Id: <1162177848.2914.13.camel@localhost.portugal>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
X-OriginalArrivalTime: 30 Oct 2006 03:11:04.0758 (UTC) FILETIME=[0930FD60:01C6FBD1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-V2FCF72gJmVGwVJ3fS27
Content-Type: multipart/mixed; boundary="=-A/sXUlm4INrn7/Gk5egh"


--=-A/sXUlm4INrn7/Gk5egh
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Sat, 2006-10-28 at 05:22 +0100, Sergio Monteiro Basto wrote:
> On Fri, 2006-10-27 at 21:06 -0700, Andi Kleen wrote:
> > > So far, has I can understand. Seems to me that my computer which have=
 a
> > > Pentium D (Dual Core) on VIA chipset, also have unsynchronized TSC an=
d
> > > with the patch of hrtimers on
> >=20
> > Intel systems (except for some large highend systems) have synchronized=
 TSCs.=20
> > Only exception so far seems to be a few systems that are=20
> > overclocked/overvolted and running outside their specification.=20
> > When you do that you'e on your own and we're not interested in a bug
> > report.
>=20
> and my computer :)=20
> http://www.asrock.com/product/775Dual-880Pro.htm
> http://www.asrock.com/support/CPU_Support/show.asp?Model=3D775Dual-880Pro
> Monday I will checkout if my computer is under specs.=20
> Seems that I like buy computers with many problems on Linux and fix :)

I bought this computer, on computers shop that have the best credits in
Portugal. And I don't change anything.

cat /proc/cpuinfo
processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      :               Intel(R) Pentium(R) D CPU 2.80GHz
stepping        : 4
cpu MHz         : 2793.050
cache size      : 1024 KB

with 2 x 1024 KB cache size just saw Pentium D 820 in=20
http://www.intel.com/products/processor_number/chart/pentium_d.htm

which is supported on
http://www.asrock.com/support/CPU_Support/show.asp?Model=3D775Dual-880Pro

775 Pentium D 820 2.80GHz 8O0MHz 2MB Smithfield All

Just see that don't have Enhanced Intel SpeedStep=AE Technology.

I attach here x86info which match with=20
http://processorfinder.intel.com/details.aspx?sSpec=3DSL88T

Other curiosity with kernel 2.6.18.1 and the hrtimers patch. Kernel boot
oops and hang , if I don't give "notsc" option.




>=20
> > There was also one BIOS found that had this problem, but it was old and=
 rare
> > and got fixed with a upgrade.

I have last BIOS released=20

> >=20
> > > Just to point out. This could be more a problem of chipsets than CPUs
> > > (AMD or Intel). AMD just begin first using x86_64 archs :)
> >=20
> > No.
> >=20
> > -Andi

--=20
S=E9rgio M.B.

--=-A/sXUlm4INrn7/Gk5egh
Content-Disposition: attachment; filename=x86info.txt
Content-Type: text/plain; name=x86info.txt; charset=ISO-8859-15
Content-Transfer-Encoding: base64

eDg2aW5mbyB2MS4xNy4gIERhdmUgSm9uZXMgMjAwMS0yMDA1DQpGZWVkYmFjayB0byA8ZGF2ZWpA
cmVkaGF0LmNvbT4uDQoNCkZvdW5kIDIgQ1BVcw0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCkNQVSAjMQ0K
Rm91bmQgdW5rbm93biBjYWNoZSBkZXNjcmlwdG9yczogODEgOTEgOTYgDQpGYW1pbHk6IDE1IE1v
ZGVsOiA0IFN0ZXBwaW5nOiA0IFR5cGU6IDAgQnJhbmQ6IDANCkNQVSBNb2RlbDogRXh0cmVtZSBF
ZGl0aW9uIFtBMF0NClByb2Nlc3NvciBuYW1lIHN0cmluZzogSW50ZWwoUikgUGVudGl1bShSKSBE
IENQVSAyLjgwR0h6DQoNCkZlYXR1cmUgZmxhZ3M6DQogZnB1IHZtZSBkZSBwc2UgdHNjIG1zciBw
YWUgbWNlIGN4OCBhcGljIHNlcCBtdHJyIHBnZSBtY2EgY21vdiBwYXQgcHNlMzYgY2xmbHNoIGRz
IGFjcGkgbW14IGZ4c3Igc3NlIHNzZTIgc3MgaHQgdG0gcGJlIHNzZTMgbW9uaXRvciBkcy1jcGwg
Y250eC1pZCBjeDE2IHhUUFINCkV4dGVuZGVkIGZlYXR1cmUgZmxhZ3M6DQogU1lTQ0FMTCBlbTY0
dA0KTDEgRGF0YSBjYWNoZToNCglTaXplOiAxNktCCVNlY3RvcmVkLCA4LXdheSBhc3NvY2lhdGl2
ZS4NCglsaW5lIHNpemU9NjQgYnl0ZXMuDQpJbnN0cnVjdGlvbiBUTEI6IDRLLCAyTUIgb3IgNE1C
IHBhZ2VzLCBmdWxseSBhc3NvY2lhdGl2ZSwgMTI4IGVudHJpZXMuDQpGb3VuZCB1bmtub3duIGNh
Y2hlIGRlc2NyaXB0b3JzOiA4MSA5MSA5NiANCkRhdGEgVExCOiA0S0Igb3IgNE1CIHBhZ2VzLCBm
dWxseSBhc3NvY2lhdGl2ZSwgNjQgZW50cmllcy4NClByb2Nlc3NvciBzZXJpYWw6IDAwMDAtMEY0
NC0wMDAwLTAwMDAtMDAwMC0wMDAwDQpUaGUgcGh5c2ljYWwgcGFja2FnZSBzdXBwb3J0cyAyIGxv
Z2ljYWwgcHJvY2Vzc29ycyANCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCkNQVSAjMg0KRm91bmQgdW5r
bm93biBjYWNoZSBkZXNjcmlwdG9yczogODEgOTEgOTYgDQpGYW1pbHk6IDE1IE1vZGVsOiA0IFN0
ZXBwaW5nOiA0IFR5cGU6IDAgQnJhbmQ6IDANCkNQVSBNb2RlbDogRXh0cmVtZSBFZGl0aW9uIFtB
MF0NClByb2Nlc3NvciBuYW1lIHN0cmluZzogSW50ZWwoUikgUGVudGl1bShSKSBEIENQVSAyLjgw
R0h6DQoNCkZlYXR1cmUgZmxhZ3M6DQogZnB1IHZtZSBkZSBwc2UgdHNjIG1zciBwYWUgbWNlIGN4
OCBhcGljIHNlcCBtdHJyIHBnZSBtY2EgY21vdiBwYXQgcHNlMzYgY2xmbHNoIGRzIGFjcGkgbW14
IGZ4c3Igc3NlIHNzZTIgc3MgaHQgdG0gcGJlIHNzZTMgbW9uaXRvciBkcy1jcGwgY250eC1pZCBj
eDE2IHhUUFINCkV4dGVuZGVkIGZlYXR1cmUgZmxhZ3M6DQogU1lTQ0FMTCBlbTY0dA0KTDEgRGF0
YSBjYWNoZToNCglTaXplOiAxNktCCVNlY3RvcmVkLCA4LXdheSBhc3NvY2lhdGl2ZS4NCglsaW5l
IHNpemU9NjQgYnl0ZXMuDQpJbnN0cnVjdGlvbiBUTEI6IDRLLCAyTUIgb3IgNE1CIHBhZ2VzLCBm
dWxseSBhc3NvY2lhdGl2ZSwgMTI4IGVudHJpZXMuDQpGb3VuZCB1bmtub3duIGNhY2hlIGRlc2Ny
aXB0b3JzOiA4MSA5MSA5NiANCkRhdGEgVExCOiA0S0Igb3IgNE1CIHBhZ2VzLCBmdWxseSBhc3Nv
Y2lhdGl2ZSwgNjQgZW50cmllcy4NClByb2Nlc3NvciBzZXJpYWw6IDAwMDAtMEY0NC0wMDAwLTAw
MDAtMDAwMC0wMDAwDQpUaGUgcGh5c2ljYWwgcGFja2FnZSBzdXBwb3J0cyAyIGxvZ2ljYWwgcHJv
Y2Vzc29ycyANCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCg==


--=-A/sXUlm4INrn7/Gk5egh--

--=-V2FCF72gJmVGwVJ3fS27
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
SIb3DQEJBTEPFw0wNjEwMzAwMzEwNDNaMCMGCSqGSIb3DQEJBDEWBBStHg2shJbaatMkkBWVNwif
hE/8CjANBgkqhkiG9w0BAQEFAASCAQAMMvNlGzVHhfkkdpMV57tjs4T8bZ5sPjf+t8SCRXaPRwmO
WWMBSKlM18/J+uVwtouW9+U3libM9WpZvrX6ZaJvdItE7SnCFJRLr9fewoZW5rFiOyWKyThIA77t
WsorLDD7Ck4R4Q3EM4UQXbrKzULkJndU7oOlBdcQr1faklEWvtAhxc6v8gfYfMvoLVnFSuNDVJZy
lKl0Geq0hbBawzVFesE9Sz1ytpjDr6MQHxDS1djWsYfiD+361DaRrQbzaG26lmhza+aig9oJNt+V
SkaAJrtIRw13xiJFSnSzo3uaEG+OeMUlOOk+eko1imwdd5C2Yny269OvYkonUEDPBEjsAAAAAAAA



--=-V2FCF72gJmVGwVJ3fS27--
