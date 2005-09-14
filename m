Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964997AbVINUlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964997AbVINUlo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 16:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965006AbVINUlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 16:41:44 -0400
Received: from NS6.Sony.CO.JP ([137.153.0.32]:30948 "EHLO ns6.sony.co.jp")
	by vger.kernel.org with ESMTP id S964997AbVINUln (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 16:41:43 -0400
Message-ID: <43288A84.2090107@sm.sony.co.jp>
Date: Thu, 15 Sep 2005 05:39:32 +0900
From: "Machida, Hiroyuki" <machida@sm.sony.co.jp>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: hirofumi@mail.parknet.co.jp
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2][FAT] miss-sync issues on sync mount (miss-sync on utime)
Content-Type: multipart/mixed;
 boundary="------------060005040904030809010903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060005040904030809010903
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

The 2nd patch fixes miss-sync issue on attribute operations,
like utime.

---
Hiroyuki Machida

--------------060005040904030809010903
Content-Type: text/plain;
 name="fat-sync-attr.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="fat-sync-attr.patch"

U2lnbmVkLW9mZi1ieTogSGlyb3l1a2kgTWFjaGlkYSA8bWFjaGRpYUBzbS5zb255LmNvLmpw
PgotLS0KIGZpbGUuYyB8ICAgIDQgKysrKwogMSBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlv
bnMoKykKCi0tLSBsaW51eC0yLjYuMTMvZnMvZmF0L2ZpbGUuYwkyMDA1LTA4LTI5IDA4OjQx
OjAxLjAwMDAwMDAwMCArMDkwMAorKysgbGludXgtMi42LjEzLm5ldy9mcy9mYXQvZmlsZS5j
CTIwMDUtMDktMTEgMTI6MjY6NTEuMDMxNzQzNzUwICswOTAwCkBAIC0yMDEsNiArMTgzLDEw
IEBAIGludCBmYXRfbm90aWZ5X2NoYW5nZShzdHJ1Y3QgZGVudHJ5ICpkZW4KIAllbHNlCiAJ
CW1hc2sgPSBzYmktPm9wdGlvbnMuZnNfZm1hc2s7CiAJaW5vZGUtPmlfbW9kZSAmPSBTX0lG
TVQgfCAoU19JUldYVUdPICYgfm1hc2spOworCisJaWYgKCAoIWVycm9yKSAmJiBJU19TWU5D
KGlub2RlKSkgeworCQllcnJvciA9IHdyaXRlX2lub2RlX25vdyhpbm9kZSwgMSk7CisJfQog
b3V0OgogCXVubG9ja19rZXJuZWwoKTsKIAlyZXR1cm4gZXJyb3I7Cg==
--------------060005040904030809010903--
