Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132520AbRDKILw>; Wed, 11 Apr 2001 04:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132521AbRDKILl>; Wed, 11 Apr 2001 04:11:41 -0400
Received: from [194.8.76.131] ([194.8.76.131]:19983 "HELO imap.camline.com")
	by vger.kernel.org with SMTP id <S132520AbRDKILb>;
	Wed, 11 Apr 2001 04:11:31 -0400
Date: Wed, 11 Apr 2001 10:13:12 +0200 (CEST)
From: Matthias Hanisch <matze@camline.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] a new __init function in random.c
Message-ID: <Pine.LNX.4.10.10104111009590.21412-200000@homer.camline.com>
Organization: camLine Datensysteme fuer die Mikroelektronik
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463781119-443612326-986976792=:21412"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463781119-443612326-986976792=:21412
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi!

The attached patch puts the following function into the .text.init
section.

batch_entropy_init
        called by rand_initialize (initfunc)

Patch is against 2.4.4pre1, to be included in the ac-series and in the
standard kernel.

Regards,
	Matze

-- 
Matthias Hanisch    mailto:matze@camline.com    phone: +49 8137 935-219

---1463781119-443612326-986976792=:21412
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=init-random
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.10.10104111013120.21412@homer.camline.com>
Content-Description: 
Content-Disposition: attachment; filename=init-random

ZGlmZiAtcnUgbGludXgtdmFuaWxsYS9kcml2ZXJzL2NoYXIvcmFuZG9tLmMg
bGludXgvZHJpdmVycy9jaGFyL3JhbmRvbS5jDQotLS0gbGludXgtdmFuaWxs
YS9kcml2ZXJzL2NoYXIvcmFuZG9tLmMJU3VuIE1hciAyNSAxMToyMTo1NyAy
MDAxDQorKysgbGludXgvZHJpdmVycy9jaGFyL3JhbmRvbS5jCU1vbiBBcHIg
IDkgMjI6MjI6MjAgMjAwMQ0KQEAgLTYxMCw3ICs2MTAsNyBAQA0KIHN0YXRp
YyB2b2lkIGJhdGNoX2VudHJvcHlfcHJvY2Vzcyh2b2lkICpwcml2YXRlXyk7
DQogDQogLyogbm90ZTogdGhlIHNpemUgbXVzdCBiZSBhIHBvd2VyIG9mIDIg
Ki8NCi1zdGF0aWMgaW50IGJhdGNoX2VudHJvcHlfaW5pdChpbnQgc2l6ZSwg
c3RydWN0IGVudHJvcHlfc3RvcmUgKnIpDQorc3RhdGljIGludCBfX2luaXQg
YmF0Y2hfZW50cm9weV9pbml0KGludCBzaXplLCBzdHJ1Y3QgZW50cm9weV9z
dG9yZSAqcikNCiB7DQogCWJhdGNoX2VudHJvcHlfcG9vbCA9IGttYWxsb2Mo
MipzaXplKnNpemVvZihfX3UzMiksIEdGUF9LRVJORUwpOw0KIAlpZiAoIWJh
dGNoX2VudHJvcHlfcG9vbCkNCg==
---1463781119-443612326-986976792=:21412--
