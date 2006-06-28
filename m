Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423187AbWF1FWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423187AbWF1FWV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 01:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423157AbWF1FVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 01:21:53 -0400
Received: from terminus.zytor.com ([192.83.249.54]:6862 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1423168AbWF1FTZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 01:19:25 -0400
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Subject: [klibc 25/31] Miscellaneous utilities for klibc
Date: Tue, 27 Jun 2006 22:17:25 -0700
Message-Id: <klibc.200606272217.25@tazenda.hos.anvin.org>
In-Reply-To: <klibc.200606272217.00@tazenda.hos.anvin.org>
References: <klibc.200606272217.00@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[klibc] Miscellaneous utilities for klibc

A collection of minor utilities for klibc.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit 99753ec67ac082f5f4fdb07e7b985bba84cf4b4c
tree 758bb62c89686ff8a71f6022c15be6f02723a9d4
parent 412867937f3298c6ab1b4a3d6fc8050214a1b7c0
author H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:51:10 -0700
committer H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:51:10 -0700

 usr/Kbuild             |    2 
 usr/utils/Kbuild       |   62 ++++++
 usr/utils/cat.c        |  329 ++++++++++++++++++++++++++++++
 usr/utils/chroot.c     |   25 ++
 usr/utils/dd.c         |  533 ++++++++++++++++++++++++++++++++++++++++++++++++
 usr/utils/false.c      |    4 
 usr/utils/file_mode.c  |  143 +++++++++++++
 usr/utils/file_mode.h  |    1 
 usr/utils/halt.c       |   55 +++++
 usr/utils/insmod.c     |  140 +++++++++++++
 usr/utils/ln.c         |   77 +++++++
 usr/utils/minips.c     |  508 ++++++++++++++++++++++++++++++++++++++++++++++
 usr/utils/mkdir.c      |  150 ++++++++++++++
 usr/utils/mkfifo.c     |   71 ++++++
 usr/utils/mknod.c      |   58 +++++
 usr/utils/mount_main.c |  105 +++++++++
 usr/utils/mount_opts.c |   94 ++++++++
 usr/utils/mount_opts.h |   21 ++
 usr/utils/nuke.c       |  134 ++++++++++++
 usr/utils/pivot_root.c |   19 ++
 usr/utils/sleep.c      |   25 ++
 usr/utils/true.c       |    4 
 usr/utils/umount.c     |   45 ++++
 usr/utils/uname.c      |  154 ++++++++++++++
 24 files changed, 2758 insertions(+), 1 deletions(-)

Patch suppressed due to size (65 K), available at:
http://www.kernel.org/pub/linux/kernel/people/hpa/klibc-patchset/25-miscellaneous-utilities-for-klibc.patch
