Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbUGREeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbUGREeU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 00:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbUGREeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 00:34:20 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:18333 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S262138AbUGREeS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 00:34:18 -0400
Date: Sat, 17 Jul 2004 21:32:24 -0700
To: linux-kernel@vger.kernel.org
Subject: FileSystem Corruption 1,493,339 and counting
Message-ID: <20040718043224.GA11925@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-No-Archive: yes
X-Noarchive: yes
User-Agent: Mutt/1.5.6i
From: Brian Litzinger <brian@worldcontrol.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The other day a machine of mine froze for reasons unknown after about
30 days of uptime.  No response to anything.

Upon reboot it got an unrecoverable file system error during
fsck.

So I dropped into a shell and issued the command fsck -y -C /dev/md1.

Around 73% it starting reporting

Unattached inode 250083
Connect to /lost+found? yes

Inode 250083 ref count is 2, should be 1. Fix? yes

This has been going on for 24 hours now, and fsck is
at

Unattached inode 1494419
Connect to /lost+found? yes

Inode 1494419 ref count is 2, should be 1. Fix? yes

Do you suppose this will ever end?  Has fsck gotten into
an infinite loop?  Shall I scrap the filesystem or let
it keep going?

How many days might it take?

I'm running linux 2.4.25 untainted with an ext2 filesystem
on an Athlon XP 2000+.

-- 
Brian Litzinger
