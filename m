Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263225AbREWTNg>; Wed, 23 May 2001 15:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263224AbREWTN1>; Wed, 23 May 2001 15:13:27 -0400
Received: from cr845378-a.rchrd1.on.wave.home.com ([24.157.76.7]:18440 "EHLO
	mielke.cc") by vger.kernel.org with ESMTP id <S263223AbREWTNN>;
	Wed, 23 May 2001 15:13:13 -0400
Date: Wed, 23 May 2001 15:11:41 -0400 (EDT)
From: Dave Mielke <dave@mielke.cc>
To: "Linux Kernel (mailing list)" <linux-kernel@vger.kernel.org>
Subject: nfs mount by label not working.
Message-ID: <Pine.LNX.4.30.0105231505330.995-100000@dave.private.mielke.cc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using kernel 2.2.17-14 as supplied by RedHat, and using mount from
mount-2.9u-4, mounting by label using the -L option does not work.

    mount -L backup1 /a
    mount: no such partition found

The mount man page says that "/proc/partitions" must exist.

    ls -l /proc/partitions
    -r--r--r--   1 root     root            0 May 23 15:10 /proc/partitions

Does something need to be enabled to make this work? What else might I be doing
wrong?

-- 
Dave Mielke           | 2213 Fox Crescent | I believe that the Bible is the
Phone: 1-613-726-0014 | Ottawa, Ontario   | Word of God. Please contact me
EMail: dave@mielke.cc | Canada  K2A 1H7   | if you're concerned about Hell.

