Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129461AbRBOLOX>; Thu, 15 Feb 2001 06:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129501AbRBOLON>; Thu, 15 Feb 2001 06:14:13 -0500
Received: from jdi.jdimedia.nl ([212.204.192.51]:13576 "EHLO jdi.jdimedia.nl")
	by vger.kernel.org with ESMTP id <S129461AbRBOLOA>;
	Thu, 15 Feb 2001 06:14:00 -0500
Date: Thu, 15 Feb 2001 12:13:58 +0100 (CET)
From: Igmar Palsenberg <i.palsenberg@jdimedia.nl>
To: <linux-kernel@vger.kernel.org>
Subject: Netmos patch
Message-ID: <Pine.LNX.4.30.0102151212190.30446-200000@jdi.jdimedia.nl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-858508352-1990982705-982235638=:30446"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---858508352-1990982705-982235638=:30446
Content-Type: TEXT/PLAIN; charset=US-ASCII


Hi,

Wrong patch. Attached is the (hopefully) correct one. Or replace the
PCI_VENDOR_ID_NETMOS_9705 with PCI_DEVICE_ID_NETMOS_9705


	Regards,


		Igmar

-- 

--
Igmar Palsenberg
JDI Media Solutions

Jansplaats 11
6811 GB Arnhem
The Netherlands

mailto: i.palsenberg@jdimedia.nl
PGP/GPG key : http://www.jdimedia.nl/formulier/pgp/igmar

---858508352-1990982705-982235638=:30446
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="netmos_parport.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.30.0102151213580.30446@jdi.jdimedia.nl>
Content-Description: 
Content-Disposition: attachment; filename="netmos_parport.patch"

LS0tIGxpbnV4L2luY2x1ZGUvbGludXgvcGNpLmgub3JpZwlUaHUgRmViIDE1
IDExOjE4OjQzIDIwMDENCisrKyBsaW51eC9pbmNsdWRlL2xpbnV4L3BjaS5o
CVRodSBGZWIgMTUgMTE6NTI6MjcgMjAwMQ0KQEAgLTEyNjgsNiArMTI2OCw5
IEBADQogI2RlZmluZSBQQ0lfREVWSUNFX0lEX0lOVEVSUEhBU0VfNTUyNgkw
eDAwMDQNCiAjZGVmaW5lIFBDSV9ERVZJQ0VfSURfSU5URVJQSEFTRV81NXg2
CTB4MDAwNQ0KIA0KKyNkZWZpbmUgUENJX1ZFTkRPUl9JRF9ORVRNT1MJCTB4
OTcxMA0KKyNkZWZpbmUgUENJX0RFVklDRV9JRF9ORVRNT1NfOTcwNQkweDk3
MDUNCisNCiAvKg0KICAqIFRoZSBQQ0kgaW50ZXJmYWNlIHRyZWF0cyBtdWx0
aS1mdW5jdGlvbiBkZXZpY2VzIGFzIGluZGVwZW5kZW50DQogICogZGV2aWNl
cy4gIFRoZSBzbG90L2Z1bmN0aW9uIGFkZHJlc3Mgb2YgZWFjaCBkZXZpY2Ug
aXMgZW5jb2RlZA0KLS0tIGxpbnV4L2RyaXZlcnMvbWlzYy9wYXJwb3J0X3Bj
LmMub3JpZwlUaHUgRmViIDE1IDExOjQ5OjAwIDIwMDENCisrKyBsaW51eC9k
cml2ZXJzL21pc2MvcGFycG9ydF9wYy5jCVRodSBGZWIgMTUgMTE6NTM6MjEg
MjAwMQ0KQEAgLTkxMCw2ICs5MTAsOCBAQA0KIAkJICB7IHsgMCwgLTEgfSwg
fSB9LA0KIAkJeyBQQ0lfVkVORE9SX0lEX09YU0VNSSwgUENJX0RFVklDRV9J
RF9PWFNFTUlfMTJQQ0k4NDAsIDEsDQogCQkgIHsgeyAwLCAxIH0sIH0gfSwN
CisJCXsgUENJX1ZFTkRPUl9JRF9ORVRNT1MsIFBDSV9ERVZJQ0VfSURfTkVU
TU9TXzk3MDUsIDEsIA0KKwkJICB7IHsgMCwgLTEgfSwgfSB9LA0KIAkJeyAw
LCB9DQogCX07DQogDQotLS0gbGludXgvZHJpdmVycy9wY2kvb2xkcHJvYy5j
Lm9yaWcJVGh1IEZlYiAxNSAxMTozMDozNiAyMDAxDQorKysgbGludXgvZHJp
dmVycy9wY2kvb2xkcHJvYy5jCVRodSBGZWIgMTUgMTE6MzA6MDYgMjAwMQ0K
QEAgLTk0Nyw2ICs5NDcsNyBAQA0KIAkgICAgICBjYXNlIFBDSV9WRU5ET1Jf
SURfVElHRVJKRVQ6CXJldHVybiAiVGlnZXJKZXQiOw0KIAkgICAgICBjYXNl
IFBDSV9WRU5ET1JfSURfQVJLOgkJcmV0dXJuICJBUksgTG9naWMiOw0KIAkg
ICAgICBjYXNlIFBDSV9WRU5ET1JfSURfU1lTS09OTkVDVDoJcmV0dXJuICJT
eXNLb25uZWN0IjsNCisJICAgICAgY2FzZSBQQ0lfVkVORE9SX0lEX05FVE1P
UzoJcmV0dXJuICJOZXRtb3MiOw0KIAkgICAgICBkZWZhdWx0OgkJCQlyZXR1
cm4gIlVua25vd24gdmVuZG9yIjsNCiAJfQ0KIH0NCg==
---858508352-1990982705-982235638=:30446--
