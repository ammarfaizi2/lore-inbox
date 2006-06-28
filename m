Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423185AbWF1FXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423185AbWF1FXG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 01:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423175AbWF1FTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 01:19:21 -0400
Received: from terminus.zytor.com ([192.83.249.54]:3790 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1423168AbWF1FTB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 01:19:01 -0400
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Subject: [klibc 22/31] zlib for klibc
Date: Tue, 27 Jun 2006 22:17:22 -0700
Message-Id: <klibc.200606272217.22@tazenda.hos.anvin.org>
In-Reply-To: <klibc.200606272217.00@tazenda.hos.anvin.org>
References: <klibc.200606272217.00@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[klibc] zlib for klibc

Add zlib for klibc.  kinit needs this to decompress compressed
ramdisks.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit 8c5226a0f242be0fc40dad16236b511292115e1b
tree 22fe60571cc2d116c48305ab38a1b83c04d47c97
parent 24b7d25b39c484b6d39bc39003c1c1e315a04398
author H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:51:06 -0700
committer H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:51:06 -0700

 usr/include/zconf.h          |  332 ++++++++
 usr/include/zlib.h           | 1357 +++++++++++++++++++++++++++++++++
 usr/klibc/zlib/FAQ           |  339 ++++++++
 usr/klibc/zlib/INDEX         |   51 +
 usr/klibc/zlib/README        |  125 +++
 usr/klibc/zlib/adler32.c     |  149 ++++
 usr/klibc/zlib/algorithm.txt |  209 +++++
 usr/klibc/zlib/compress.c    |   79 ++
 usr/klibc/zlib/crc32.c       |  423 ++++++++++
 usr/klibc/zlib/crc32.h       |  441 +++++++++++
 usr/klibc/zlib/deflate.c     | 1736 ++++++++++++++++++++++++++++++++++++++++++
 usr/klibc/zlib/deflate.h     |  331 ++++++++
 usr/klibc/zlib/gzio.c        | 1029 +++++++++++++++++++++++++
 usr/klibc/zlib/infback.c     |  623 +++++++++++++++
 usr/klibc/zlib/inffast.c     |  318 ++++++++
 usr/klibc/zlib/inffast.h     |   11 
 usr/klibc/zlib/inffixed.h    |   94 ++
 usr/klibc/zlib/inflate.c     | 1368 +++++++++++++++++++++++++++++++++
 usr/klibc/zlib/inflate.h     |  115 +++
 usr/klibc/zlib/inftrees.c    |  329 ++++++++
 usr/klibc/zlib/inftrees.h    |   55 +
 usr/klibc/zlib/trees.c       | 1219 +++++++++++++++++++++++++++++
 usr/klibc/zlib/trees.h       |  127 +++
 usr/klibc/zlib/uncompr.c     |   61 +
 usr/klibc/zlib/zconf.in.h    |  332 ++++++++
 usr/klibc/zlib/zlib.3        |  159 ++++
 usr/klibc/zlib/zutil.c       |  318 ++++++++
 usr/klibc/zlib/zutil.h       |  269 +++++++
 28 files changed, 11999 insertions(+), 0 deletions(-)

Patch suppressed due to size (468 K), available at:
http://www.kernel.org/pub/linux/kernel/people/hpa/klibc-patchset/22-zlib-for-klibc.patch
