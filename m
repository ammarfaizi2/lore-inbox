Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265233AbTLFTdR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 14:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265235AbTLFTdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 14:33:17 -0500
Received: from c-130372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.19]:55953
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S265233AbTLFTdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 14:33:14 -0500
Subject: Re: Catching NForce2 lockup with NMI watchdog - found?
From: Ian Kumlien <pomac@vapor.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-TdzlbiDG5+YPFXRq9qAL"
Message-Id: <1070739194.1985.4.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 06 Dec 2003 20:33:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TdzlbiDG5+YPFXRq9qAL
Content-Type: multipart/mixed; boundary="=-bLaSnDeJDy/EcvRacO/Q"


--=-bLaSnDeJDy/EcvRacO/Q
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi, i'm now running this patch and it survived my grep in /usr/src.

It's mainly a correction of the apic patch and the ACPI halt disconnect
patch that was originally done for 2.6...

I'll get back to you about uptime, but i think this is it...=20

Although i would prefer a not so workaroundish approach =3D)

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-bLaSnDeJDy/EcvRacO/Q
Content-Description: 
Content-Disposition: inline; filename=nforce2.patch
Content-Type: text/x-diff; charset=ISO-8859-1
Content-Transfer-Encoding: base64

LS0tIGFyY2gvaTM4Ni9rZXJuZWwvbXBwYXJzZS5jLm9yaWcJMjAwMy0xMS0yOCAxOToyNjoxOS4w
MDAwMDAwMDAgKzAxMDANCisrKyBhcmNoL2kzODYva2VybmVsL21wcGFyc2UuYwkyMDAzLTEyLTA2
IDE5OjM1OjE1LjAwMDAwMDAwMCArMDEwMA0KQEAgLTExNDAsNyArMTE0MCw4IEBADQogCSAqLw0K
IAlmb3IgKGkgPSAwOyBpIDwgbXBfaXJxX2VudHJpZXM7IGkrKykgew0KIAkJaWYgKChtcF9pcnFz
W2ldLm1wY19kc3RhcGljID09IGludHNyYy5tcGNfZHN0YXBpYykgDQotCQkJJiYgKG1wX2lycXNb
aV0ubXBjX3NyY2J1c2lycSA9PSBpbnRzcmMubXBjX3NyY2J1c2lycSkpIHsNCisJCQkmJiAobXBf
aXJxc1tpXS5tcGNfc3JjYnVzaXJxID09IGludHNyYy5tcGNfc3JjYnVzaXJxKQ0KKwkJCSYmICht
cF9pcnFzW2ldLm1wY19pcnF0eXBlID09IGludHNyYy5tcGNfaXJxdHlwZSkpIHsNCiAJCQltcF9p
cnFzW2ldID0gaW50c3JjOw0KIAkJCWZvdW5kID0gMTsNCiAJCQlicmVhazsNCi0tLSBhcmNoL2kz
ODYva2VybmVsL3BjaS1wYy5jLm9yaWcJMjAwMy0xMi0wNiAxOTozMjo0NC4wMDAwMDAwMDAgKzAx
MDANCisrKyBhcmNoL2kzODYva2VybmVsL3BjaS1wYy5jCTIwMDMtMTItMDYgMTk6MzM6NTUuMDAw
MDAwMDAwICswMTAwDQpAQCAtMTMyOCw2ICsxMzI4LDE4IEBADQogCQlkZXYtPnRyYW5zcGFyZW50
ID0gMTsNCiB9DQogDQorLyoNCisgKiBIYWx0IERpc2Nvbm5lY3QgYW5kIFN0b3AgR3JhbnQgRGlz
Y29ubmVjdCAoYml0IDQgYXQgb2Zmc2V0IDB4NkYpDQorICogbXVzdCBiZSBkaXNhYmxlZCB3aGVu
IEFQSUMgaXMgdXNlZCAob3IgbG9ja3VwcyB3aWxsIGhhcHBlbikuDQorICovDQorc3RhdGljIHZv
aWQgX19kZXZpbml0IHBjaV9maXh1cF9uZm9yY2UyX2Rpc2Nvbm5lY3Qoc3RydWN0IHBjaV9kZXYg
KmQpDQorew0KKwl1OCB0Ow0KKw0KKwlwY2lfcmVhZF9jb25maWdfYnl0ZShkLCAweDZGLCAmdCk7
DQorCXBjaV93cml0ZV9jb25maWdfYnl0ZShkLCAweDZGLCAodCAmIDB4ZWYpKTsNCit9DQorDQog
c3RydWN0IHBjaV9maXh1cCBwY2liaW9zX2ZpeHVwc1tdID0gew0KIAl7IFBDSV9GSVhVUF9IRUFE
RVIsCVBDSV9WRU5ET1JfSURfSU5URUwsCVBDSV9ERVZJQ0VfSURfSU5URUxfODI0NTFOWCwJcGNp
X2ZpeHVwX2k0NTBueCB9LA0KIAl7IFBDSV9GSVhVUF9IRUFERVIsCVBDSV9WRU5ET1JfSURfSU5U
RUwsCVBDSV9ERVZJQ0VfSURfSU5URUxfODI0NTRHWCwJcGNpX2ZpeHVwX2k0NTBneCB9LA0KQEAg
LTEzNDMsNiArMTM1NSw3IEBADQogCXsgUENJX0ZJWFVQX0hFQURFUiwJUENJX1ZFTkRPUl9JRF9W
SUEsCVBDSV9ERVZJQ0VfSURfVklBXzgzNjdfMCwJcGNpX2ZpeHVwX3ZpYV9ub3J0aGJyaWRnZV9i
dWcgfSwNCiAJeyBQQ0lfRklYVVBfSEVBREVSLAlQQ0lfVkVORE9SX0lEX05DUiwJUENJX0RFVklD
RV9JRF9OQ1JfNTNDODEwLAlwY2lfZml4dXBfbmNyNTNjODEwIH0sDQogCXsgUENJX0ZJWFVQX0hF
QURFUiwJUENJX1ZFTkRPUl9JRF9JTlRFTCwJUENJX0FOWV9JRCwJCQlwY2lfZml4dXBfdHJhbnNw
YXJlbnRfYnJpZGdlIH0sDQorCXsgUENJX0ZJWFVQX0hFQURFUiwJUENJX1ZFTkRPUl9JRF9OVklE
SUEsCVBDSV9ERVZJQ0VfSURfTlZJRElBX05GT1JDRTIsCXBjaV9maXh1cF9uZm9yY2UyX2Rpc2Nv
bm5lY3QgfSwNCiAJeyAwIH0NCiB9Ow0KIA0K

--=-bLaSnDeJDy/EcvRacO/Q--

--=-TdzlbiDG5+YPFXRq9qAL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/0i767F3Euyc51N8RAv2cAJ9AMF4527TC5LG8htNFnY8YRmCEQQCfQN+y
juIZqT4Lu585Id539qSJ1nI=
=Vt98
-----END PGP SIGNATURE-----

--=-TdzlbiDG5+YPFXRq9qAL--

