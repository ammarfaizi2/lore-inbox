Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbWJHRAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWJHRAK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 13:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWJHRAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 13:00:10 -0400
Received: from hentges.net ([81.169.178.128]:36017 "EHLO
	h6563.serverkompetenz.net") by vger.kernel.org with ESMTP
	id S1751265AbWJHRAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 13:00:08 -0400
Subject: Re: sky2 (was Re: 2.6.18-mm2)
From: Matthias Hentges <oe@hentges.net>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Netdev List <netdev@vger.kernel.org>
In-Reply-To: <20061008092001.0c83a359@localhost.localdomain>
References: <20060928155053.7d8567ae.akpm@osdl.org>
	 <451C5599.80402@garzik.org> <20060928161956.5262e5d3@freekitty>
	 <1159930628.16765.9.camel@mhcln03>
	 <20061003202643.0e0ceab2@localhost.localdomain>
	 <1160250529.4575.7.camel@mhcln03> <1160314905.4575.21.camel@mhcln03>
	 <20061008092001.0c83a359@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-E4wShPgtc11sE/7WXjlZ"
Date: Sun, 08 Oct 2006 19:00:01 +0200
Message-Id: <1160326801.4575.27.camel@mhcln03>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-E4wShPgtc11sE/7WXjlZ
Content-Type: multipart/mixed; boundary="=-cOkUOSPGrjZ6oeQiwI8l"


--=-cOkUOSPGrjZ6oeQiwI8l
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Sonntag, den 08.10.2006, 09:20 -0700 schrieb Stephen Hemminger:
> On Sun, 08 Oct 2006 15:41:45 +0200
> Matthias Hentges <oe@hentges.net> wrote:

[...]

> > I have verified this behavior (works fine w/o debug patch, freezes with
> > patch applied) with:
> > - 2.6.19-rc1-git4=20
> > - 2.6.18-git something=20
> > - 2.6.18-mm3
> >  =20
>=20
> Does 2.6.18 work?

2.6.18 does not require the patch ( in fact, the patch won't apply at
all) and thus does not freeze when the NIC goes down.

> What is the PCI config of the device (lspci -vvvx)?

I've attached the lspci dump of both onboard sky2 NICs.

> What is the chip version (dmesg | grep sky2)?
>=20

+root@mhcln01:..patches/generic/coretemp >dmesg |grep sky2
[   34.833453] sky2 v1.7 addr 0xfa9fc000 irq 17 Yukon-EC (0xb6) rev 2
[   34.833527] sky2 eth0: addr 00:17:31:f4:f1:8c
[   34.833663] sky2 v1.7 addr 0xfa8fc000 irq 16 Yukon-EC (0xb6) rev 2
[   34.833729] sky2 eth1: addr 00:17:31:f4:f7:cc
[   42.165687] sky2 eth1: enabling interface
[   43.847972] sky2 eth1: Link is up at 100 Mbps, full duplex, flow
control both

--=20
Matthias 'CoreDump' Hentges=20

My OS: Debian SID. Geek by Nature, Linux by Choice

--=-cOkUOSPGrjZ6oeQiwI8l
Content-Disposition: attachment; filename=lspci-vvvv_sky2-1.txt
Content-Type: text/plain; name=lspci-vvvv_sky2-1.txt; charset=ISO-8859-15
Content-Transfer-Encoding: base64

MDM6MDAuMCBFdGhlcm5ldCBjb250cm9sbGVyOiBNYXJ2ZWxsIFRlY2hub2xvZ3kgR3JvdXAgTHRk
LiA4OEU4MDUzIFBDSS1FIEdpZ2FiaXQgRXRoZXJuZXQgQ29udHJvbGxlciAocmV2IDIwKQ0KCVN1
YnN5c3RlbTogQVNVU1RlSyBDb21wdXRlciBJbmMuIE1hcnZlbGwgODhFODA1MyBHaWdhYml0IEV0
aGVybmV0IGNvbnRyb2xsZXIgUENJZSAoQXN1cykNCglDb250cm9sOiBJL08rIE1lbSsgQnVzTWFz
dGVyKyBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJS
LSBGYXN0QjJCLQ0KCVN0YXR1czogQ2FwKyA2Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERF
VlNFTD1mYXN0ID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0NCglMYXRl
bmN5OiAwLCBDYWNoZSBMaW5lIFNpemU6IDE2IGJ5dGVzDQoJSW50ZXJydXB0OiBwaW4gQSByb3V0
ZWQgdG8gSVJRIDIxNg0KCVJlZ2lvbiAwOiBNZW1vcnkgYXQgZmE4ZmMwMDAgKDY0LWJpdCwgbm9u
LXByZWZldGNoYWJsZSkgW3NpemU9MTZLXQ0KCVJlZ2lvbiAyOiBJL08gcG9ydHMgYXQgYTgwMCBb
c2l6ZT0yNTZdDQoJRXhwYW5zaW9uIFJPTSBhdCBmYThjMDAwMCBbZGlzYWJsZWRdIFtzaXplPTEy
OEtdDQoJQ2FwYWJpbGl0aWVzOiBbNDhdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAyDQoJCUZs
YWdzOiBQTUVDbGstIERTSS0gRDErIEQyKyBBdXhDdXJyZW50PTBtQSBQTUUoRDArLEQxKyxEMiss
RDNob3QrLEQzY29sZCspDQoJCVN0YXR1czogRDAgUE1FLUVuYWJsZS0gRFNlbD0wIERTY2FsZT0x
IFBNRS0NCglDYXBhYmlsaXRpZXM6IFs1MF0gVml0YWwgUHJvZHVjdCBEYXRhDQoJQ2FwYWJpbGl0
aWVzOiBbNWNdIE1lc3NhZ2UgU2lnbmFsbGVkIEludGVycnVwdHM6IE1hc2stIDY0Yml0KyBRdWV1
ZT0wLzEgRW5hYmxlKw0KCQlBZGRyZXNzOiAwMDAwMDAwMGZlZTAxMDBjICBEYXRhOiA0MTUyDQoJ
Q2FwYWJpbGl0aWVzOiBbZTBdIEV4cHJlc3MgTGVnYWN5IEVuZHBvaW50IElSUSAwDQoJCURldmlj
ZTogU3VwcG9ydGVkOiBNYXhQYXlsb2FkIDEyOCBieXRlcywgUGhhbnRGdW5jIDAsIEV4dFRhZy0N
CgkJRGV2aWNlOiBMYXRlbmN5IEwwcyB1bmxpbWl0ZWQsIEwxIHVubGltaXRlZA0KCQlEZXZpY2U6
IEF0bkJ0bi0gQXRuSW5kLSBQd3JJbmQtDQoJCURldmljZTogRXJyb3JzOiBDb3JyZWN0YWJsZS0g
Tm9uLUZhdGFsLSBGYXRhbC0gVW5zdXBwb3J0ZWQtDQoJCURldmljZTogUmx4ZE9yZC0gRXh0VGFn
LSBQaGFudEZ1bmMtIEF1eFB3ci0gTm9Tbm9vcC0NCgkJRGV2aWNlOiBNYXhQYXlsb2FkIDEyOCBi
eXRlcywgTWF4UmVhZFJlcSA1MTIgYnl0ZXMNCgkJTGluazogU3VwcG9ydGVkIFNwZWVkIDIuNUdi
L3MsIFdpZHRoIHgxLCBBU1BNIEwwcywgUG9ydCAwDQoJCUxpbms6IExhdGVuY3kgTDBzIDwyNTZu
cywgTDEgdW5saW1pdGVkDQoJCUxpbms6IEFTUE0gRGlzYWJsZWQgUkNCIDEyOCBieXRlcyBDb21t
Q2xrKyBFeHRTeW5jaC0NCgkJTGluazogU3BlZWQgMi41R2IvcywgV2lkdGggeDENCg0K


--=-cOkUOSPGrjZ6oeQiwI8l
Content-Disposition: attachment; filename=lspci-vvvv_sky2-2.txt
Content-Type: text/plain; name=lspci-vvvv_sky2-2.txt; charset=ISO-8859-15
Content-Transfer-Encoding: base64

MDQ6MDAuMCBFdGhlcm5ldCBjb250cm9sbGVyOiBNYXJ2ZWxsIFRlY2hub2xvZ3kgR3JvdXAgTHRk
LiA4OEU4MDUzIFBDSS1FIEdpZ2FiaXQgRXRoZXJuZXQgQ29udHJvbGxlciAocmV2IDIwKQ0KCVN1
YnN5c3RlbTogQVNVU1RlSyBDb21wdXRlciBJbmMuIE1hcnZlbGwgODhFODA1MyBHaWdhYml0IEV0
aGVybmV0IGNvbnRyb2xsZXIgUENJZSAoQXN1cykNCglDb250cm9sOiBJL08rIE1lbSsgQnVzTWFz
dGVyKyBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJS
LSBGYXN0QjJCLQ0KCVN0YXR1czogQ2FwKyA2Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERF
VlNFTD1mYXN0ID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0NCglMYXRl
bmN5OiAwLCBDYWNoZSBMaW5lIFNpemU6IDE2IGJ5dGVzDQoJSW50ZXJydXB0OiBwaW4gQSByb3V0
ZWQgdG8gSVJRIDIxNw0KCVJlZ2lvbiAwOiBNZW1vcnkgYXQgZmE5ZmMwMDAgKDY0LWJpdCwgbm9u
LXByZWZldGNoYWJsZSkgW3NpemU9MTZLXQ0KCVJlZ2lvbiAyOiBJL08gcG9ydHMgYXQgYjgwMCBb
c2l6ZT0yNTZdDQoJRXhwYW5zaW9uIFJPTSBhdCBmYTljMDAwMCBbZGlzYWJsZWRdIFtzaXplPTEy
OEtdDQoJQ2FwYWJpbGl0aWVzOiBbNDhdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAyDQoJCUZs
YWdzOiBQTUVDbGstIERTSS0gRDErIEQyKyBBdXhDdXJyZW50PTBtQSBQTUUoRDArLEQxKyxEMiss
RDNob3QrLEQzY29sZCspDQoJCVN0YXR1czogRDAgUE1FLUVuYWJsZS0gRFNlbD0wIERTY2FsZT0x
IFBNRS0NCglDYXBhYmlsaXRpZXM6IFs1MF0gVml0YWwgUHJvZHVjdCBEYXRhDQoJQ2FwYWJpbGl0
aWVzOiBbNWNdIE1lc3NhZ2UgU2lnbmFsbGVkIEludGVycnVwdHM6IE1hc2stIDY0Yml0KyBRdWV1
ZT0wLzEgRW5hYmxlKw0KCQlBZGRyZXNzOiAwMDAwMDAwMGZlZTAzMDBjICBEYXRhOiA0MTRhDQoJ
Q2FwYWJpbGl0aWVzOiBbZTBdIEV4cHJlc3MgTGVnYWN5IEVuZHBvaW50IElSUSAwDQoJCURldmlj
ZTogU3VwcG9ydGVkOiBNYXhQYXlsb2FkIDEyOCBieXRlcywgUGhhbnRGdW5jIDAsIEV4dFRhZy0N
CgkJRGV2aWNlOiBMYXRlbmN5IEwwcyB1bmxpbWl0ZWQsIEwxIHVubGltaXRlZA0KCQlEZXZpY2U6
IEF0bkJ0bi0gQXRuSW5kLSBQd3JJbmQtDQoJCURldmljZTogRXJyb3JzOiBDb3JyZWN0YWJsZS0g
Tm9uLUZhdGFsLSBGYXRhbC0gVW5zdXBwb3J0ZWQtDQoJCURldmljZTogUmx4ZE9yZC0gRXh0VGFn
LSBQaGFudEZ1bmMtIEF1eFB3ci0gTm9Tbm9vcC0NCgkJRGV2aWNlOiBNYXhQYXlsb2FkIDEyOCBi
eXRlcywgTWF4UmVhZFJlcSA1MTIgYnl0ZXMNCgkJTGluazogU3VwcG9ydGVkIFNwZWVkIDIuNUdi
L3MsIFdpZHRoIHgxLCBBU1BNIEwwcywgUG9ydCAwDQoJCUxpbms6IExhdGVuY3kgTDBzIDwyNTZu
cywgTDEgdW5saW1pdGVkDQoJCUxpbms6IEFTUE0gRGlzYWJsZWQgUkNCIDEyOCBieXRlcyBDb21t
Q2xrKyBFeHRTeW5jaC0NCgkJTGluazogU3BlZWQgMi41R2IvcywgV2lkdGggeDENCg0K


--=-cOkUOSPGrjZ6oeQiwI8l--

--=-E4wShPgtc11sE/7WXjlZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFKS6RAq2P5eLUP5IRAv05AKCPsKZFBEgY30UgqDmd64OBONOjxACcCSpQ
/TdJXZSJzu33GBDRkik53X8=
=V2iq
-----END PGP SIGNATURE-----

--=-E4wShPgtc11sE/7WXjlZ--

