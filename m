Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261449AbTCYFk1>; Tue, 25 Mar 2003 00:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261455AbTCYFk1>; Tue, 25 Mar 2003 00:40:27 -0500
Received: from hera.cwi.nl ([192.16.191.8]:34713 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S261449AbTCYFk0>;
	Tue, 25 Mar 2003 00:40:26 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 25 Mar 2003 06:51:33 +0100 (MET)
Message-Id: <UTC200303250551.h2P5pXU11604.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: Linux 2.5.66
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good! But I don't see my compilation fixes. Will resend.
Below a new one.

Andries

diff -u --recursive --new-file -X /linux/dontdiff a/fs/partitions/msdos.c b/fs/partitions/msdos.c
--- a/fs/partitions/msdos.c	Mon Feb 24 23:02:56 2003
+++ b/fs/partitions/msdos.c	Tue Mar 25 06:22:31 2003
@@ -219,7 +219,7 @@
  * Create devices for BSD partitions listed in a disklabel, under a
  * dos-like partition. See parse_extended() for more information.
  */
-static void
+void
 parse_bsd(struct parsed_partitions *state, struct block_device *bdev,
 		u32 offset, u32 size, int origin, char *flavour,
 		int max_partitions)
