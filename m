Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267063AbRGJSZQ>; Tue, 10 Jul 2001 14:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267061AbRGJSZG>; Tue, 10 Jul 2001 14:25:06 -0400
Received: from altair.alt.iph.ras.ru ([194.67.87.171]:4868 "EHLO
	altair.office.altlinux.ru") by vger.kernel.org with ESMTP
	id <S267052AbRGJSYz>; Tue, 10 Jul 2001 14:24:55 -0400
Date: Tue, 10 Jul 2001 22:24:17 +0400
From: Konstantin Volckov <goldhead@altlinux.ru>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Edward Peng." <edward_peng@dlink.com.tw>
Subject: PATCH for dl2k driver
Message-Id: <20010710222417.26dedb99.goldhead@altlinux.ru>
Organization: ALT Linux
X-Mailer: Sylpheed version 0.4.99 (GTK+ 1.2.10; i586-alt-linux)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Tue__10_Jul_2001_22:24:17_+0400_081a1e38"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Tue__10_Jul_2001_22:24:17_+0400_081a1e38
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

There is a mistake in dl2k.c network driver added in 2.4.6-ac2.

Without this patch gcc-2.95.3 produces a broken symbol __ucmpdi2, while
gcc-2.96 works ok.

-- 
Good luck,
Konstantin

--Multipart_Tue__10_Jul_2001_22:24:17_+0400_081a1e38
Content-Type: application/octet-stream;
 name="linux-2.4.6-ac2-dl2k.patch"
Content-Disposition: attachment;
 filename="linux-2.4.6-ac2-dl2k.patch"
Content-Transfer-Encoding: base64

LS0tIGxpbnV4L2RyaXZlcnMvbmV0L2RsMmsuY19vbGQJVHVlIEp1bCAxMCAxOTowNTozMyAyMDAx
CisrKyBsaW51eC9kcml2ZXJzL25ldC9kbDJrLmMJVHVlIEp1bCAxMCAyMjoxMToyMSAyMDAxCkBA
IC01NTksNyArNTU5LDcgQEAKIAkJCX0KIAkJfQogCQkvKiBGcmVlIHVzZWQgdHggc2tidWZmcyAq
LwotCQlmb3IgKDsgbnAtPmN1cl90eCAtIG5wLT5vbGRfdHggPiAwOyBucC0+b2xkX3R4KyspIHsK
KwkJZm9yICg7IG5wLT5jdXJfdHggPiBucC0+b2xkX3R4OyBucC0+b2xkX3R4KyspIHsKIAkJCWlu
dCBlbnRyeSA9IG5wLT5vbGRfdHggJSBUWF9SSU5HX1NJWkU7CiAJCQlpZiAoIShucC0+dHhfcmlu
Z1tlbnRyeV0uc3RhdHVzICYgVEZERG9uZSkpCiAJCQkJYnJlYWs7CkBAIC03MTAsNyArNzEwLDcg
QEAKIAl9CiAKIAkvKiBSZS1hbGxvY2F0ZSBza2J1ZmZzIHRvIGZpbGwgdGhlIGRlc2NyaXB0b3Ig
cmluZyAqLwotCWZvciAoOyBucC0+Y3VyX3J4IC0gbnAtPm9sZF9yeCA+IDA7IG5wLT5vbGRfcngr
KykgeworCWZvciAoOyBucC0+Y3VyX3J4ID4gbnAtPm9sZF9yeDsgbnAtPm9sZF9yeCsrKSB7CiAJ
CXN0cnVjdCBza19idWZmICpza2I7CiAJCWVudHJ5ID0gbnAtPm9sZF9yeCAlIFJYX1JJTkdfU0la
RTsKIAkJLyogRHJvcHBlZCBwYWNrZXRzIGRvbid0IG5lZWQgdG8gcmUtYWxsb2NhdGUgKi8K

--Multipart_Tue__10_Jul_2001_22:24:17_+0400_081a1e38--
