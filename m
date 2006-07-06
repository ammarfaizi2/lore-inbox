Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030184AbWGFGD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030184AbWGFGD4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 02:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030195AbWGFGDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 02:03:54 -0400
Received: from rwcrmhc15.comcast.net ([204.127.192.85]:41709 "EHLO
	rwcrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S1030184AbWGFGDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 02:03:53 -0400
Date: Thu, 6 Jul 2006 02:04:34 -0400 (EDT)
From: Parag Warudkar <kernel-stuff@comcast.net>
X-X-Sender: paragw@gentoo.warudkars.net
To: linux-kernel@vger.kernel.org
cc: torvalds@osdl.org
Subject: [PATCH] intelfbhw.c: intelfbhw_get_p1p2 defined but not used
Message-ID: <Pine.LNX.4.64.0607060154130.2027@gentoo.warudkars.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811583-2104750481-1152165874=:2027"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811583-2104750481-1152165874=:2027
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed


intelfbhw_get_p1p2 is used only if REGDUMP is defined - compile it in only 
if REGDUMP is defined - one less compiler warning.

Patch against 2.6.18-rc1.

Parag


---1463811583-2104750481-1152165874=:2027
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0607060204340.2027@gentoo.warudkars.net>
Content-Description: intelfbhw.c.patch
Content-Disposition: attachment; filename=patch

LS0tIGxpbnV4LTIuNi4xNy9kcml2ZXJzL3ZpZGVvL2ludGVsZmIvaW50ZWxm
Ymh3LmMub3JpZwkyMDA2LTA3LTA2IDAxOjQ4OjU1LjAwMDAwMDAwMCAtMDQw
MA0KKysrIGxpbnV4LTIuNi4xNy9kcml2ZXJzL3ZpZGVvL2ludGVsZmIvaW50
ZWxmYmh3LmMJMjAwNi0wNy0wNiAwMTo0OTo0NS4wMDAwMDAwMDAgLTA0MDAN
CkBAIC02MTQsNiArNjE0LDcgQEAgc3RhdGljIGludCBjYWxjX3ZjbG9jayhp
bnQgaW5kZXgsIGludCBtMQ0KIAlyZXR1cm4gdmNvIC8gcDsNCiB9DQogDQor
I2lmIFJFR0RVTVANCiBzdGF0aWMgdm9pZA0KIGludGVsZmJod19nZXRfcDFw
MihzdHJ1Y3QgaW50ZWxmYl9pbmZvICpkaW5mbywgaW50IGRwbGwsIGludCAq
b19wMSwgaW50ICpvX3AyKQ0KIHsNCkBAIC02MzksNyArNjQwLDcgQEAgaW50
ZWxmYmh3X2dldF9wMXAyKHN0cnVjdCBpbnRlbGZiX2luZm8gKg0KIAkqb19w
MSA9IHAxOw0KIAkqb19wMiA9IHAyOw0KIH0NCi0NCisjZW5kaWYNCiANCiB2
b2lkDQogaW50ZWxmYmh3X3ByaW50X2h3X3N0YXRlKHN0cnVjdCBpbnRlbGZi
X2luZm8gKmRpbmZvLCBzdHJ1Y3QgaW50ZWxmYl9od3N0YXRlICpodykNCg==

---1463811583-2104750481-1152165874=:2027--
