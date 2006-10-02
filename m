Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965227AbWJBSQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965227AbWJBSQv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 14:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965233AbWJBSQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 14:16:51 -0400
Received: from ns2.g-housing.de ([81.169.133.75]:15518 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S965227AbWJBSQu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 14:16:50 -0400
Date: Mon, 2 Oct 2006 19:16:45 +0100 (BST)
From: Christian Kujau <evil@g-house.de>
X-X-Sender: evil@sheep.housecafe.de
To: linux-kernel@vger.kernel.org
cc: christopher.leech@intel.com
Subject: CONFIG_DMA_ENGINE helptext
Message-ID: <Pine.LNX.4.64.0610021903260.8599@sheep.housecafe.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463809526-190321547-1159813005=:8599"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463809526-190321547-1159813005=:8599
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

Hello,

I was wondering what CONFIG_DMA_ENGINE is about and the only hint I 
found was this: http://lkml.org/lkml/2006/9/25/285

That's why I was about to send the attached patch. However, from looking 
at the comments in drivers/dma/dmaengine.c, it seems to be about 
non-HW-specific DMA support:

"This code implements the DMA subsystem. It provides a HW-neutral
  interface for other kernel code to use asynchronous memory copy
  capabilities"

Because I don't know anything about the innards of DMA, can someone 
please enlighten me what this knob is for and why one should enable it?

Thanks,
Christian.
-- 
BOFH excuse #94:

Internet outage
---1463809526-190321547-1159813005=:8599
Content-Type: TEXT/plain; charset=US-ASCII; name=Kconfig-DMA_ENGINE-2.6.18.diff
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0610021916450.8599@sheep.housecafe.de>
Content-Description: 
Content-Disposition: attachment; filename=Kconfig-DMA_ENGINE-2.6.18.diff

LS0tIGxpbnV4LTIuNi9kcml2ZXJzL2RtYS9LY29uZmlnCTIwMDYtMDktMjIg
MDY6MjA6MTYuMDAwMDAwMDAwICswMTAwDQorKysgbGludXgtMi42L2RyaXZl
cnMvZG1hL0tjb25maWcuZWRpdGVkCTIwMDYtMTAtMDIgMTk6MDQ6MjUuMDAw
MDAwMDAwICswMTAwDQpAQCAtOCw3ICs4LDExIEBAIGNvbmZpZyBETUFfRU5H
SU5FDQogCWJvb2wgIlN1cHBvcnQgZm9yIERNQSBlbmdpbmVzIg0KIAktLS1o
ZWxwLS0tDQogCSAgRE1BIGVuZ2luZXMgb2ZmbG9hZCBjb3B5IG9wZXJhdGlv
bnMgZnJvbSB0aGUgQ1BVIHRvIGRlZGljYXRlZA0KLQkgIGhhcmR3YXJlLCBh
bGxvd2luZyB0aGUgY29waWVzIHRvIGhhcHBlbiBhc3luY2hyb25vdXNseS4N
CisJICBoYXJkd2FyZSwgYWxsb3dpbmcgdGhlIGNvcGllcyB0byBoYXBwZW4g
YXN5bmNocm9ub3VzbHkuIFNwZWNpYWwNCisJICBoYXJkd2FyZSBpcyByZXF1
aXJlZCBmb3IgdGhpcywgY3VycmVudGx5IG9ubHkgdGhlIEludGVsIEU1MDAw
IA0KKwkgIGNoaXBzZXQgaXMgc3VwcG9ydGVkLCBjZXJ0YWluIFJBSUQgY29u
dHJvbGxlcnMgbWlnaHQgc3VwcG9ydA0KKwkgIHRoaXMgdG9vLiBOb3RlIHRo
YXQgdGhpcyBoYXMgbm90aGluZyB0byBkbyB3aXRoIFBDSS1ETUEgaW4NCisJ
ICB0aGUgZmlyc3QgcGxhY2UuDQogDQogY29tbWVudCAiRE1BIENsaWVudHMi
DQogDQo=

---1463809526-190321547-1159813005=:8599--
