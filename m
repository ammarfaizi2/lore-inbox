Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423168AbWF1FWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423168AbWF1FWW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 01:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423185AbWF1FVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 01:21:48 -0400
Received: from terminus.zytor.com ([192.83.249.54]:8142 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1423181AbWF1FTa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 01:19:30 -0400
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Subject: [klibc 27/31] A port of gzip to klibc
Date: Tue, 27 Jun 2006 22:17:27 -0700
Message-Id: <klibc.200606272217.27@tazenda.hos.anvin.org>
In-Reply-To: <klibc.200606272217.00@tazenda.hos.anvin.org>
References: <klibc.200606272217.00@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[klibc] A port of gzip to klibc

A port of the gzip utility to klibc.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit 973116495f231a6775ef098df4481a34a38bfff7
tree 90eee8941bc6fbffcfb0ca49cbe924b85641a70a
parent a359e7a5083122cf32f9b4dabd63af25a60646d9
author H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:51:13 -0700
committer H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:51:13 -0700

 usr/Kbuild          |    2 
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
 15 files changed, 5625 insertions(+), 1 deletions(-)

Patch suppressed due to size (203 K), available at:
http://www.kernel.org/pub/linux/kernel/people/hpa/klibc-patchset/27-a-port-of-gzip-to-klibc.patch
