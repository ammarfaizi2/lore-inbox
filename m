Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269586AbUJFWuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269586AbUJFWuO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 18:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269581AbUJFWqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 18:46:07 -0400
Received: from fmr03.intel.com ([143.183.121.5]:27274 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S269549AbUJFWpE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 18:45:04 -0400
Message-ID: <4164756E.4010408@intel.com>
Date: Wed, 06 Oct 2004 15:45:02 -0700
From: Arun Sharma <arun.sharma@intel.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Kill a sparse warning in binfmt_elf.c
Content-Type: multipart/mixed;
 boundary="------------040608080305060705080504"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040608080305060705080504
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


The attached patch kills a sparse warning in binfmt_elf.c:dump_write() by adding a __user annotation.

	-Arun


--------------040608080305060705080504
Content-Type: text/plain;
 name="sparse-binfmt.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="sparse-binfmt.patch"

S2lsbCBhIHNwYXJzZSB3YXJuaW5nIGluIDIuNi45LXJjMy4KClNpZ25lZC1vZmYtYnk6IEFy
dW4gU2hhcm1hIDxhcnVuLnNoYXJtYUBpbnRlbC5jb20+Cgo9PT09PSBmcy9iaW5mbXRfZWxm
LmMgMS44OCB2cyBlZGl0ZWQgPT09PT0KLS0tIDEuODgvZnMvYmluZm10X2VsZi5jCVdlZCBT
ZXAgMjIgMTM6MzQ6MDUgMjAwNAorKysgZWRpdGVkL2ZzL2JpbmZtdF9lbGYuYwlXZWQgT2N0
ICA2IDEzOjE2OjM3IDIwMDQKQEAgLTEwMzIsNyArMTAzMiw3IEBACiAgKi8KIHN0YXRpYyBp
bnQgZHVtcF93cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwgY29uc3Qgdm9pZCAqYWRkciwgaW50
IG5yKQogewotCXJldHVybiBmaWxlLT5mX29wLT53cml0ZShmaWxlLCBhZGRyLCBuciwgJmZp
bGUtPmZfcG9zKSA9PSBucjsKKwlyZXR1cm4gZmlsZS0+Zl9vcC0+d3JpdGUoZmlsZSwgKGNv
bnN0IGNoYXIgX191c2VyICopIGFkZHIsIG5yLCAmZmlsZS0+Zl9wb3MpID09IG5yOwogfQog
CiBzdGF0aWMgaW50IGR1bXBfc2VlayhzdHJ1Y3QgZmlsZSAqZmlsZSwgb2ZmX3Qgb2ZmKQo=
--------------040608080305060705080504--
