Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313592AbSD3O4Y>; Tue, 30 Apr 2002 10:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313596AbSD3O4X>; Tue, 30 Apr 2002 10:56:23 -0400
Received: from rose.man.poznan.pl ([150.254.173.3]:63727 "EHLO
	rose.man.poznan.pl") by vger.kernel.org with ESMTP
	id <S313592AbSD3O4X>; Tue, 30 Apr 2002 10:56:23 -0400
Date: Tue, 30 Apr 2002 16:56:21 +0200 (MET DST)
From: Michal Schulz <mschulz@rose.man.poznan.pl>
To: linux-kernel@vger.kernel.org
Subject: romfx XIP patch
Message-ID: <Pine.GSO.4.20.0204301648450.11086-101000@rose.man.poznan.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1804928587-1020178581=:11086"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1804928587-1020178581=:11086
Content-Type: TEXT/PLAIN; charset=US-ASCII


Welcome!

I would like to introduce myself firstly. I study chemistry and
information technology, working on linux for many years. I specialise in
low-level programming.

For few months I am responsible for preparing linux distribution to an
386EX machine with 2.5MB of RAM and few megabytes (8 or 12) of
Flash-ROM. Because the machine doesn't have too much memory, I have fixed
2.2.18 kernel, so that it keeps all unwritable sections if ROM and that's
the place where they're executed for. Thanks to that I have spared about
500KB of memory.

My next aim was to provice XIP - execute in place. In order to do that, I
have choosen romfs filesystem, which is small and fast. I have patched it
to add XIP feature. You may look at the patch - it is attached to this
mail. The one is designed for 2.2.18 (and probably whole 2.2 line).

Could You please check whether it is 100% proper? If so, maybe one day it
could be included into the kernel?

with best regards,

-- 
Michal Schulz


---559023410-1804928587-1020178581=:11086
Content-Type: APPLICATION/octet-stream; name="romfs-xip-patch.bz2"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.20.0204301656210.11086@rose.man.poznan.pl>
Content-Description: 
Content-Disposition: attachment; filename="romfs-xip-patch.bz2"

QlpoOTFBWSZTWTPEqTIAAqJfgHgwff//+3+n3/q/79/qUAR+1mXcqlO7AA3D
RCmyp+p6pvVNonpmqeoZD1A2pkZAAAABp6mmGpppMmU2mgk9JtTRoaPU0AAA
aANAAGglNJKfpTQAHqNGhoB6jQNPSDJkAA0B6gOMjTJiaDJkwmmQMhoDQGmT
QwAmgMJEhAmUxppT01NkT1Mp5E02oBptQxDQ09EYTTSoBa8RVixQyBhMXo7W
4KGw9L6X6Yj5RS+v1HlGGW9538j+WaCTabxPVEso8+NwmeKT9bVFDMn08ZRK
srUIQzbajTbfcAt6DEcACz3iORiN75yrGsm3z+3+TgL9uSXf+chebZcZzNqy
NiiqCWkvEMak5NwrAplx2eptAMcXDbKeFco4QXQOWsLownaBlo36Aj+S8MFY
hSDYHhRe1Sp8EjdbUwkqRjOSRLltK/AaFZVlH4ITG9s5LwPy5Fm3baYODDcx
rBKdMSVHbZZuwusiJxKPCkpqlkU9xJ3IqIpUFTeo/YYgxEjBoOAsPWH3LSVS
DSZNNAQkSoFKQ0y2kkK8Z0mUAqIuLG51DT2qZ68J8PAtNbSWI4kJwEA4maZh
BqGhjULxxWz1CzkjvXZ8nM83nD6b+Axl5hJclqzCkswTvfVVJo8pIOs50L7/
yNeaQGYMm2MTBQZgmorJpYNQnIVppyRoxa1GQJK736jksR8GUz3NlLap0VRS
kWXG5rcMp64v/XsNK3cnQfAxXW1kIuDO2u274EGpEHeJkmsBl8ZTG/7gzh1H
y47Ohev2gvaC+ArsD7hWCwEpAwXiFrPd4feJe8FgLstP4ZigehBpJf65CKGN
S4lKmQpmqk1JvsnfIHJrHpAIMEUOHZbKH8+QSdHRuBBC5nHLqHYn6XnfnKgn
b5qiGfuOosBft0k+5Qnm+JHEYUFbcW6NpF58sZAfp7FrbRrvppMkdsdozZBB
qiA+Ow6LQjQAukWgsjG+FuUU92ABJlUIBVUWOtJ5kYUtZEaGBFtBBIJIWAiK
f6y6gY6MUZ6gJlOyxkVKReeHGcsSzEqrzFhYNXHulTryFpVc0+NdxchiQeDe
3xnNSgTVZwegGvX1xxoaVkQGsPIDAYNHErDgwd4MgZV9EyWrhQ3KGjp48Y+M
yfdwDQdRQ7pfF+82Q+YkWhvGIOIuVe9xy0r4tuOHot3bvZvDXQrOYL9E13An
Bjtgyz6LpHdMdXVuBVsVB2OJTpXyzCtr3fJJcCTEzCjqhAQGQTvGNt4w23Bg
VSkn0UkTCYqEUkggmQyf4aQncguKF3k2XasLmgMqgtzHgi4ytDS7ad98SC0H
BYOowbOWUmNFA2I8ZXZOhkW1ml120CshEY9PQ5FgWKNNYHKDqfOYYBeXIhrb
x6B5oqv1SmgWbdUrprPlVaai0O9OiU+EsnV2QixLDdoedw64iNoeLTYSMbi0
gBoaXfkKlVkqliy6QS1wFqLx1WqfP4SmCPAYWTQxLkTPU5oRYmm3cNJIRAYx
pAJEzkUWA5QSoU0bRIEISif/F3JFOFCQM8SpMg==
---559023410-1804928587-1020178581=:11086--
