Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261449AbRE3PlI>; Wed, 30 May 2001 11:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261459AbRE3Pk6>; Wed, 30 May 2001 11:40:58 -0400
Received: from pc40.e18.physik.tu-muenchen.de ([129.187.154.153]:58886 "EHLO
	pc40.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S261449AbRE3Pkw>; Wed, 30 May 2001 11:40:52 -0400
Date: Wed, 30 May 2001 17:40:45 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: <linux-kernel@vger.kernel.org>
Subject: Oopses with 2.4.4
Message-ID: <Pine.LNX.4.31.0105301732020.4168-200000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1149134438-1772058380-991237245=:4168"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1149134438-1772058380-991237245=:4168
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi folks!

All of a sudden I experienced at least two Oopses looking like the
attached one, which is from process X (the other was bash, but the message
had nearly scrolled away). Since I can't find this exact code sequence in
arch/i386/entry.S (it appeared exactly the same in the bash Oops) I am
asking myself whether it is a hardware failure... How else can code be
changed?

I am running 2.4.4 with the reiserfs-knfsd-patch on a dual PII
450/440BX/512MB machine.

TIA,
					Roland

---1149134438-1772058380-991237245=:4168
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="Oops.ksyms"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.31.0105301740450.4168@pc40.e18.physik.tu-muenchen.de>
Content-Description: 
Content-Disposition: attachment; filename="Oops.ksyms"

a3N5bW9vcHMgMi40LjAgb24gaTY4NiAyLjQuNC4gIE9wdGlvbnMgdXNlZA0K
ICAgICAtViAoZGVmYXVsdCkNCiAgICAgLWsgL3Byb2Mva3N5bXMgKGRlZmF1
bHQpDQogICAgIC1sIC9wcm9jL21vZHVsZXMgKGRlZmF1bHQpDQogICAgIC1v
IC9saWIvbW9kdWxlcy8yLjQuNC8gKGRlZmF1bHQpDQogICAgIC1tIC9ib290
L1N5c3RlbS5tYXAtMi40LjQta25mc2RwYXRjaCAoc3BlY2lmaWVkKQ0KDQpX
YXJuaW5nIChjb21wYXJlX21hcHMpOiBrc3ltc19iYXNlIHN5bWJvbCBfX1ZF
UlNJT05FRF9TWU1CT0woc2htZW1fZmlsZV9zZXR1cCkgbm90IGZvdW5kIGlu
IFN5c3RlbS5tYXAuICBJZ25vcmluZyBrc3ltc19iYXNlIGVudHJ5DQpPb3Bz
OiAwMDAyDQpDUFU6ICAwDQpFSVA6ICAwMDEwOls8YzAxMDZlZTY+XQ0KVXNp
bmcgZGVmYXVsdHMgZnJvbSBrc3ltb29wcyAtdCBlbGYzMi1pMzg2IC1hIGkz
ODYNCkVGTEFHUzogMDAwMTAyNTYNCmVheDogMDAwMDAwMDAgIGVieDogZGNk
NWMwMDAgIGVjeDogZGZmZmM1ZDAgIGVkeDogMDAwMDAwZWYNCmVzaTogMDAw
MDAwMDAgIGVkaTogMDAwMDAwMDAgIGVicDogYmZmZmY4ODggIGVzcDogZGNk
NWRmYzQNCmRzOiAwMDE4ICBlczogMDAxOCAgc3M6IDAwMTgNClN0YWNrOiAw
MDAwMDEwMCAwODFkNzZjMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCBi
ZmZmZjg4OCAwMDAwMDAwMSAwMDAwMDAyYg0KICAgICAgIDAwMDAwMDJiIDAw
MDAwMDhlIDQwMTQ3OTBlIDAwMDAwMDIzIDAwMDAwMjkyIGJmZmZmNWUwIDAw
MDAwMDJiDQpDb2RlOiAwMCAwMCAwNSAyMCBkZiAyZSBjMCA4NSAwMCAwMCAy
NCBkZiAyZSBjMCAwZiA4NSAwMCAwMCAwMCAwMA0KDQo+PkVJUDsgYzAxMDZl
ZTYgPHJldF9mcm9tX3N5c19jYWxsKzYvMWE+ICAgPD09PT09DQpDb2RlOyAg
YzAxMDZlZTYgPHJldF9mcm9tX3N5c19jYWxsKzYvMWE+DQowMDAwMDAwMCA8
X0VJUD46DQpDb2RlOyAgYzAxMDZlZTYgPHJldF9mcm9tX3N5c19jYWxsKzYv
MWE+ICAgPD09PT09DQogICAwOiAgIDAwIDAwICAgICAgICAgICAgICAgICAg
ICAgYWRkICAgICVhbCwoJWVheCkgICA8PT09PT0NCkNvZGU7ICBjMDEwNmVl
OCA8cmV0X2Zyb21fc3lzX2NhbGwrOC8xYT4NCiAgIDI6ICAgMDUgMjAgZGYg
MmUgYzAgICAgICAgICAgICBhZGQgICAgJDB4YzAyZWRmMjAsJWVheA0KQ29k
ZTsgIGMwMTA2ZWVkIDxyZXRfZnJvbV9zeXNfY2FsbCtkLzFhPg0KICAgNzog
ICA4NSAwMCAgICAgICAgICAgICAgICAgICAgIHRlc3QgICAlZWF4LCglZWF4
KQ0KQ29kZTsgIGMwMTA2ZWVmIDxyZXRfZnJvbV9zeXNfY2FsbCtmLzFhPg0K
ICAgOTogICAwMCAyNCBkZiAgICAgICAgICAgICAgICAgIGFkZCAgICAlYWgs
KCVlZGksJWVieCw4KQ0KQ29kZTsgIGMwMTA2ZWYyIDxyZXRfZnJvbV9zeXNf
Y2FsbCsxMi8xYT4NCiAgIGM6ICAgMmUgYzAgMGYgODUgICAgICAgICAgICAg
ICByb3JiICAgJDB4ODUsJWNzOiglZWRpKQ0KDQoNCjEgd2FybmluZyBpc3N1
ZWQuICBSZXN1bHRzIG1heSBub3QgYmUgcmVsaWFibGUuDQo=
---1149134438-1772058380-991237245=:4168--
