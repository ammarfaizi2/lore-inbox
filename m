Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965144AbWFZBCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965144AbWFZBCp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 21:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbWFZBCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 21:02:13 -0400
Received: from terminus.zytor.com ([192.83.249.54]:26511 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965119AbWFZA7h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 20:59:37 -0400
Date: Sun, 25 Jun 2006 17:58:10 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: [klibc 43/43] A port of gzip to klibc
Message-Id: <klibc.200606251757.43@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[klibc] A port of gzip to klibc

A port of the gzip utility to klibc.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit a9e53d55c81fdcc612635e7f92e07312abeda156
tree 058c04f42848e5bb9e28652315da569c6b9f219b
parent c61927fa211e3c54be7e868f41a4a1b99768111f
author H. Peter Anvin <hpa@zytor.com> Sun, 25 Jun 2006 16:59:06 -0700
committer H. Peter Anvin <hpa@zytor.com> Sun, 25 Jun 2006 16:59:06 -0700

 usr/gzip/COPYING    |  339 ++++++++++++++
 usr/gzip/Kbuild     |   25 +
 usr/gzip/README     |  144 ++++++
 usr/gzip/bits.c     |  200 ++++++++
 usr/gzip/deflate.c  |  759 ++++++++++++++++++++++++++++++++
 usr/gzip/gzip.c     | 1214 +++++++++++++++++++++++++++++++++++++++++++++++++++
 usr/gzip/gzip.h     |  298 +++++++++++++
 usr/gzip/inflate.c  |  950 ++++++++++++++++++++++++++++++++++++++++
 usr/gzip/revision.h |   11 
 usr/gzip/tailor.h   |   50 ++
 usr/gzip/trees.c    | 1075 +++++++++++++++++++++++++++++++++++++++++++++
 usr/gzip/unzip.c    |   77 +++
 usr/gzip/util.c     |  372 ++++++++++++++++
 usr/gzip/zip.c      |  110 +++++
 14 files changed, 5624 insertions(+), 0 deletions(-)

Patch suppressed due to size (202 K), available at:
http://www.kernel.org/pub/linux/kernel/people/hpa/klibc-patchset/43-a-port-of-gzip-to-klibc.patch
