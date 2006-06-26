Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965061AbWFZBFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965061AbWFZBFE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 21:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965115AbWFZBEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 21:04:33 -0400
Received: from terminus.zytor.com ([192.83.249.54]:24463 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965015AbWFZA72
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 20:59:28 -0400
Date: Sun, 25 Jun 2006 17:58:09 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: [klibc 39/43] zlib for klibc
Message-Id: <klibc.200606251757.39@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[klibc] zlib for klibc

Add zlib for klibc.  kinit needs this to decompress compressed
ramdisks.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit 331e12895f91848ae0eff9acdbd5058b3c1056af
tree f27c096bf53a0be72586f562900008145a6c81a8
parent b64a5142ab2aa6c030b2a254eb94384161f93f0c
author H. Peter Anvin <hpa@zytor.com> Sun, 25 Jun 2006 16:58:57 -0700
committer H. Peter Anvin <hpa@zytor.com> Sun, 25 Jun 2006 16:58:57 -0700

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
http://www.kernel.org/pub/linux/kernel/people/hpa/klibc-patchset/39-zlib-for-klibc.patch
