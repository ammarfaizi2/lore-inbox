Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265811AbUFIJzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265811AbUFIJzr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 05:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265773AbUFIJzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 05:55:46 -0400
Received: from fairchild-196.adsl.newnet.co.uk ([213.131.187.196]:4014 "HELO
	pinus.navaho") by vger.kernel.org with SMTP id S265811AbUFIJzZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 05:55:25 -0400
X-Sender-Local: 10.0.0.42
X-SPF: 8 (No SPF lookup)
Date: Wed, 9 Jun 2004 10:50:59 +0100 (BST)
From: Steve Hill <steve@navaho.co.uk>
X-X-Sender: steve@sorbus2.navaho
To: lkml@navaho.co.uk, support@cyclades.com
Subject: [PATCH] Cyclades Cyclom-Y devfs support
Message-ID: <Pine.LNX.4.58.0406091038580.4570@sorbus2.navaho>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="666112-891836631-1086774659=:4570"
X-Navaho-ID: 40c6c3d8
X-Domain-Forwarded-By: pinus.navaho
X-Navaho-Spam-Rating: 0.000000
X-Spam-Override: Local user [steve@navaho.co.uk]
X-Navaho-Spam: No
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--666112-891836631-1086774659=:4570
Content-Type: TEXT/PLAIN; charset=US-ASCII

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


The attached patch corrects a bug which prevented the Cyclades async 
multiport serial driver from registering it's devfs entries.  The patch is 
against the stock 2.4.24 kernel sources.

- - Steve Hill
Senior Software Developer                        Email: steve@navaho.co.uk
Navaho Technologies Ltd.                           Tel: +44-870-7034015

        ... Alcohol and calculus don't mix - Don't drink and derive! ...

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Public key available at http://linux.navaho.co.uk/pubkey.steve.txt

iD8DBQFAxt2Gb26jEkrydY4RAjS9AKDD4TkCWRzqjB09t6anrW0YgYzBegCfURxt
7FU5EtCklEqfjv1oKhWj/6I=
=pjoq
-----END PGP SIGNATURE-----
--666112-891836631-1086774659=:4570
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="linux-2.4.24-cyclades-devfs.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0406091050590.4570@sorbus2.navaho>
Content-Description: 
Content-Disposition: attachment; filename="linux-2.4.24-cyclades-devfs.patch"

ZGlmZiAtdXJOIGxpbnV4LTIuNC4yNC52YW5pbGxhL2RyaXZlcnMvY2hhci9j
eWNsYWRlcy5jIGxpbnV4LTIuNC4yNC9kcml2ZXJzL2NoYXIvY3ljbGFkZXMu
Yw0KLS0tIGxpbnV4LTIuNC4yNC52YW5pbGxhL2RyaXZlcnMvY2hhci9jeWNs
YWRlcy5jCUZyaSBKdW4gMTMgMTU6NTE6MzIgMjAwMw0KKysrIGxpbnV4LTIu
NC4yNC9kcml2ZXJzL2NoYXIvY3ljbGFkZXMuYwlUaHUgSnVuICAzIDExOjQ3
OjQ5IDIwMDQNCkBAIC01NTExLDcgKzU1MTEsMTEgQEANCiAgICAgbWVtc2V0
KCZjeV9zZXJpYWxfZHJpdmVyLCAwLCBzaXplb2Yoc3RydWN0IHR0eV9kcml2
ZXIpKTsNCiAgICAgY3lfc2VyaWFsX2RyaXZlci5tYWdpYyA9IFRUWV9EUklW
RVJfTUFHSUM7DQogICAgIGN5X3NlcmlhbF9kcml2ZXIuZHJpdmVyX25hbWUg
PSAiY3ljbGFkZXMiOw0KKyNpZiAoTElOVVhfVkVSU0lPTl9DT0RFID4gMHgy
MDMyRCAmJiBkZWZpbmVkKENPTkZJR19ERVZGU19GUykpDQorICAgIGN5X3Nl
cmlhbF9kcml2ZXIubmFtZSA9ICJ0dHlDLyVkIjsNCisjZWxzZQ0KICAgICBj
eV9zZXJpYWxfZHJpdmVyLm5hbWUgPSAidHR5QyI7DQorI2VuZGlmDQogICAg
IGN5X3NlcmlhbF9kcml2ZXIubWFqb3IgPSBDWUNMQURFU19NQUpPUjsNCiAg
ICAgY3lfc2VyaWFsX2RyaXZlci5taW5vcl9zdGFydCA9IDA7DQogICAgIGN5
X3NlcmlhbF9kcml2ZXIubnVtID0gTlJfUE9SVFM7DQpAQCAtNTU1MCw3ICs1
NTU0LDExIEBADQogICAgICAqIG1ham9yIG51bWJlciBhbmQgdGhlIHN1YnR5
cGUgY29kZS4NCiAgICAgICovDQogICAgIGN5X2NhbGxvdXRfZHJpdmVyID0g
Y3lfc2VyaWFsX2RyaXZlcjsNCisjaWYgKExJTlVYX1ZFUlNJT05fQ09ERSA+
IDB4MjAzMkQgJiYgZGVmaW5lZChDT05GSUdfREVWRlNfRlMpKQ0KKyAgICBj
eV9jYWxsb3V0X2RyaXZlci5uYW1lID0gImN1Yi8lZCI7DQorI2Vsc2UNCiAg
ICAgY3lfY2FsbG91dF9kcml2ZXIubmFtZSA9ICJjdWIiOw0KKyNlbmRpZg0K
ICAgICBjeV9jYWxsb3V0X2RyaXZlci5tYWpvciA9IENZQ0xBREVTQVVYX01B
Sk9SOw0KICAgICBjeV9jYWxsb3V0X2RyaXZlci5zdWJ0eXBlID0gU0VSSUFM
X1RZUEVfQ0FMTE9VVDsNCiAgICAgY3lfY2FsbG91dF9kcml2ZXIucmVhZF9w
cm9jID0gMDsNCg==

--666112-891836631-1086774659=:4570--

