Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267525AbRGMSWk>; Fri, 13 Jul 2001 14:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267524AbRGMSWa>; Fri, 13 Jul 2001 14:22:30 -0400
Received: from smtp01.fields.gol.com ([203.216.5.131]:57618 "EHLO
	smtp01.fields.gol.com") by vger.kernel.org with ESMTP
	id <S267522AbRGMSWS>; Fri, 13 Jul 2001 14:22:18 -0400
Date: Sat, 14 Jul 2001 03:21:46 +0900
From: Masaru Kawashima <masaruk@gol.com>
To: moffe@amagerkollegiet.dk
Cc: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Re: [MINOR PROBLEM] RTL8139C: transmit timed out
In-Reply-To: <Pine.LNX.4.33.0107122043350.1097-100000@grignard.amagerkollegiet.dk>
In-Reply-To: <Pine.LNX.4.33.0107122043350.1097-100000@grignard.amagerkollegiet.dk>
X-Mailer: Sylpheed version 0.5.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Sat__14_Jul_2001_03:21:46_+0900_094006c8"
Message-Id: <E15L7Zp-0006k9-00@smtp01.fields.gol.com>
X-Abuse-Complaints: abuse@gol.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Sat__14_Jul_2001_03:21:46_+0900_094006c8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

> Jul 12 20:36:43 wiibroe kernel: NETDEV WATCHDOG: eth0: transmit timed out

I had the same problem with linux-2.4.6-ac2, and I found a bug
in the function rtl8139_start_xmit() of 8139too.c.

Attached patch will fix this bug.

Enjoy!
--
Masaru Kawashima <masaruk@gol.com>

--Multipart_Sat__14_Jul_2001_03:21:46_+0900_094006c8
Content-Type: text/plain;
 name="8139too.patch"
Content-Disposition: attachment;
 filename="8139too.patch"
Content-Transfer-Encoding: base64

LS0tIGRyaXZlcnMvbmV0LzgxMzl0b28uYy5vcmlnCVdlZCBKdWwgIDQgMTQ6MzQ6MjcgMjAwMQor
KysgZHJpdmVycy9uZXQvODEzOXRvby5jCVNhdCBKdWwgMTQgMDI6MzQ6NTAgMjAwMQpAQCAtMTcz
Miw3ICsxNzMyLDYgQEAKIAlSVExfVzMyX0YgKFR4QWRkcjAgKyAoZW50cnkgKiA0KSwgZG1hX2Fk
ZHIpOwogCVJUTF9XMzJfRiAoVHhTdGF0dXMwICsgKGVudHJ5ICogc2l6ZW9mICh1MzIpKSwKIAkJ
ICAgdHAtPnR4X2ZsYWcgfCAoc2tiLT5sZW4gPj0gRVRIX1pMRU4gPyBza2ItPmxlbiA6IEVUSF9a
TEVOKSk7Ci0Jc3Bpbl91bmxvY2tfaXJxKCZ0cC0+bG9jayk7CiAKIAlkZXYtPnRyYW5zX3N0YXJ0
ID0gamlmZmllczsKIApAQCAtMTc0MCw2ICsxNzM5LDcgQEAKIAltYigpOwogCWlmICgodHAtPmN1
cl90eCAtIE5VTV9UWF9ERVNDKSA9PSB0cC0+ZGlydHlfdHgpCiAJCW5ldGlmX3N0b3BfcXVldWUg
KGRldik7CisJc3Bpbl91bmxvY2tfaXJxKCZ0cC0+bG9jayk7CiAKIAlEUFJJTlRLICgiJXM6IFF1
ZXVlZCBUeCBwYWNrZXQgYXQgJXAgc2l6ZSAldSB0byBzbG90ICVkLlxuIiwKIAkJIGRldi0+bmFt
ZSwgc2tiLT5kYXRhLCBza2ItPmxlbiwgZW50cnkpOwo=

--Multipart_Sat__14_Jul_2001_03:21:46_+0900_094006c8--
