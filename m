Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263308AbREWWz3>; Wed, 23 May 2001 18:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263306AbREWWzK>; Wed, 23 May 2001 18:55:10 -0400
Received: from echo.sound.net ([205.242.192.21]:39652 "HELO echo.sound.net")
	by vger.kernel.org with SMTP id <S263307AbREWWy6>;
	Wed, 23 May 2001 18:54:58 -0400
Date: Wed, 23 May 2001 17:53:15 -0500 (CDT)
From: Hal Duston <hald@sound.net>
To: linux-kernel@vger.kernel.org
cc: alan@lxorguk.ukuu.org.uk
Subject: PS/2 Esdi patch #5
Message-ID: <Pine.GSO.4.10.10105231703010.10252-200000@sound.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-851401618-990655855=:10252"
Content-ID: <Pine.GSO.4.10.10105231750220.23376@sound.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-851401618-990655855=:10252
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.GSO.4.10.10105231750221.23376@sound.net>

All,

Here is another patch for ps2esdi.

Get rid of pausing inb and outb.

What documentatino I have seems to indicate it isn't necessary,
and it works on my Thinkpad.

The patch is also available at the following address incase my emailer
mangles it.

http://www.sound.net/~hald/projects/ps2esdi/ps2esdi-2.4.4-patch1

Hal Duston
hald@sound.net

---559023410-851401618-990655855=:10252
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="ps2esdi-2.4.4-patch1"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.10.10105231710550.10252@sound.net>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="ps2esdi-2.4.4-patch1"

R2V0IHJpZCBvZiBwYXVzaW5nIGluYiBhbmQgb3V0Yi4NCg0KV2hhdCBkb2N1
bWVudGF0aW9uIEkgaGF2ZSBzZWVtcyB0byBpbmRpY2F0ZSBpdCBpc24ndCBu
ZWNlc3NhcnksDQphbmQgaXQgd29ya3Mgb24gbXkgVGhpbmtwYWQuDQoNCi0t
LSBsaW51eC0yLjQuNS1wcmU0L2RyaXZlcnMvYmxvY2svcHMyZXNkaS5jCVN1
biBNYXkgMjAgMjI6NDU6MzUgMjAwMQ0KKysrIGxpbnV4LTIuNC41LXByZTQv
ZHJpdmVycy9ibG9jay9wczJlc2RpLmMuMQlTdW4gTWF5IDIwIDIzOjUzOjUz
IDIwMDENCkBAIC01MzAsMjMgKzUzMCwyMyBAQA0KIAlzdGF0dXMgPSBpbmIo
RVNESV9JTlRSUFQpOw0KIAlvdXRiKChzdGF0dXMgJiAweGUwKSB8IEFUVF9F
T0ksIEVTRElfQVRUTik7CS8qIHRvIGJlIHN1cmUgd2UgZG9uJ3QgaGF2ZQ0K
IAkJCQkJCQkgICBhbnkgaW50ZXJydXB0IHBlbmRpbmcuLi4gKi8NCi0Jb3V0
Yl9wKENUUkxfRU5BQkxFX0lOVFIsIEVTRElfQ09OVFJPTCk7DQorCW91dGIo
Q1RSTF9FTkFCTEVfSU5UUiwgRVNESV9DT05UUk9MKTsNCiANCiAJLyogcmVh
ZCB0aGUgRVNESSBzdGF0dXMgcG9ydCAtIGlmIHRoZSBjb250cm9sbGVyIGlz
IG5vdCBidXN5LA0KIAkgICBzaW1wbHkgZG8gYSBzb2Z0IHJlc2V0IChmYXN0
KSAtIG90aGVyd2lzZSB3ZSdsbCBoYXZlIHRvIGRvIGENCiAJICAgaGFyZCAo
c2xvdykgcmVzZXQuICAqLw0KLQlpZiAoIShpbmJfcChFU0RJX1NUQVRVUykg
JiBTVEFUVVNfQlVTWSkpIHsNCisJaWYgKCEoaW5iKEVTRElfU1RBVFVTKSAm
IFNUQVRVU19CVVNZKSkgew0KIAkJLypCQSAqLyBwcmludGsoIiVzOiBzb2Z0
IHJlc2V0Li4uXG4iLCBERVZJQ0VfTkFNRSk7DQotCQlvdXRiX3AoQ1RSTF9T
T0ZUX1JFU0VULCBFU0RJX0FUVE4pOw0KKwkJb3V0YihDVFJMX1NPRlRfUkVT
RVQsIEVTRElfQVRUTik7DQogCX0NCiAJLyogc29mdCByZXNldCAqLyANCiAJ
ZWxzZSB7DQogCQkvKkJBICovDQogCQlwcmludGsoIiVzOiBoYXJkIHJlc2V0
Li4uXG4iLCBERVZJQ0VfTkFNRSk7DQotCQlvdXRiX3AoQ1RSTF9IQVJEX1JF
U0VULCBFU0RJX0NPTlRST0wpOw0KKwkJb3V0YihDVFJMX0hBUkRfUkVTRVQs
IEVTRElfQ09OVFJPTCk7DQogCQlleHBpcmUgPSBqaWZmaWVzICsgMipIWjsN
CiAJCXdoaWxlICh0aW1lX2JlZm9yZShqaWZmaWVzLCBleHBpcmUpKTsNCi0J
CW91dGJfcCgxLCBFU0RJX0NPTlRST0wpOw0KKwkJb3V0YigxLCBFU0RJX0NP
TlRST0wpOw0KIAl9CQkJLyogaGFyZCByZXNldCAqLw0KIA0KIA0K
---559023410-851401618-990655855=:10252--
