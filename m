Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273054AbRIIVJg>; Sun, 9 Sep 2001 17:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273053AbRIIVJ3>; Sun, 9 Sep 2001 17:09:29 -0400
Received: from as2-1-8.va.g.bonet.se ([194.236.117.122]:42246 "EHLO
	boris.prodako.se") by vger.kernel.org with ESMTP id <S273052AbRIIVJX>;
	Sun, 9 Sep 2001 17:09:23 -0400
Date: Sun, 9 Sep 2001 23:09:27 +0200 (CEST)
From: Tobias Ringstrom <tori@ringstrom.mine.nu>
X-X-Sender: <tori@boris.prodako.se>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Handle tulip errata (again) in 2.4.9
Message-ID: <Pine.LNX.4.33.0109092257380.12498-200000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811717-88427515-1000069767=:12498"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811717-88427515-1000069767=:12498
Content-Type: TEXT/PLAIN; charset=US-ASCII

Linus,

Please apply this tiny patch which is a workaround for a DC21143 erratum
(or application note or whatever the latest name is).  The old workaround
was accidently hidden behind an experimental CONFIG in the latest driver
update.

Without this patch I get a 98% packet loss...  :-)

/Tobias

---1463811717-88427515-1000069767=:12498
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="linux-2.4.9-tulip1.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0109092309270.12498@boris.prodako.se>
Content-Description: 
Content-Disposition: attachment; filename="linux-2.4.9-tulip1.patch"

ZGlmZiAtcnUgbGludXgtMi40Ljkub3JpZy9kcml2ZXJzL25ldC90dWxpcC90
dWxpcF9jb3JlLmMgbGludXgtMi40LjkvZHJpdmVycy9uZXQvdHVsaXAvdHVs
aXBfY29yZS5jDQotLS0gbGludXgtMi40Ljkub3JpZy9kcml2ZXJzL25ldC90
dWxpcC90dWxpcF9jb3JlLmMJV2VkIEF1ZyAxNSAwODo1ODoyNyAyMDAxDQor
KysgbGludXgtMi40LjkvZHJpdmVycy9uZXQvdHVsaXAvdHVsaXBfY29yZS5j
CVN1biBTZXAgIDkgMjI6MzI6NTUgMjAwMQ0KQEAgLTE1MDMsNiArMTUwMywx
MCBAQA0KICNpZmRlZiBDT05GSUdfVFVMSVBfTVdJDQogCWlmICghZm9yY2Vf
Y3NyMCAmJiAodHAtPmZsYWdzICYgSEFTX1BDSV9NV0kpKQ0KIAkJdHVsaXBf
bXdpX2NvbmZpZyAocGRldiwgZGV2KTsNCisjZWxzZQ0KKwkvKiBNV0kgaXMg
YnJva2VuIGZvciBEQzIxMTQzIHJldiA2NS4uLiAqLw0KKwlpZiAoY2hpcF9p
ZHggPT0gREMyMTE0MyAmJiBjaGlwX3JldiA9PSA2NSkNCisJCXRwLT5jc3Iw
ICY9IH5NV0k7DQogI2VuZGlmDQogDQogCS8qIFN0b3AgdGhlIGNoaXAncyBU
eCBhbmQgUnggcHJvY2Vzc2VzLiAqLw0K
---1463811717-88427515-1000069767=:12498--
