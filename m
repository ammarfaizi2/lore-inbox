Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262878AbSJVXgL>; Tue, 22 Oct 2002 19:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262881AbSJVXgL>; Tue, 22 Oct 2002 19:36:11 -0400
Received: from cibs9.sns.it ([192.167.206.29]:24585 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S262878AbSJVXgK>;
	Tue, 22 Oct 2002 19:36:10 -0400
Date: Wed, 23 Oct 2002 01:42:18 +0200 (CEST)
From: venom@sns.it
To: linux-kernel@vger.kernel.org
Subject: 2.5.44: /proc/stat not reporting all disks statistics
Message-ID: <Pine.LNX.4.43.0210230137380.25356-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


HI,

I was modifying xosview to support I/O statistics (one graph for each
disk?) with new
/proc/stat, but then I saw that on my IDE system this file
was not reporting statistics from all disks.

I have on this system two disks, primary master and secondary master,
hda and hdc.

In /proc/stat
i see just:

disk_io: (3,0):(24382,16849,158610,7533,382512)

so, I see 22,0 disk (hdc) is somehow missing.

If needed I can check on a scsi system with three disks.

bests

Luigi


