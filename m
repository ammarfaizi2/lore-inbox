Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131224AbRCRPI7>; Sun, 18 Mar 2001 10:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131233AbRCRPIt>; Sun, 18 Mar 2001 10:08:49 -0500
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:23570 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id <S131224AbRCRPIo>; Sun, 18 Mar 2001 10:08:44 -0500
From: Martin Radford <martin@zamenhof.demon.co.uk>
Message-Id: <200103181508.PAA20046@zamenhof.demon.co.uk>
Subject: Upgrading to 2.2.19pre to fix do_try_to_free_pages bug
To: linux-kernel@vger.kernel.org
Date: Sun, 18 Mar 2001 15:07:59 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've been running into the do_try_to_free_pages problem on a server
running 2.2.18 and I just wish I'd looked at the list earlier to see
if it was a known bug.  (And I'm relieved that it is a known bug, I'm
just surprised that I hadn't hit it earlier!)

Now that I know there's a fix in 2.2.19pre*, I need to upgrade.  Since
I have limited opportunities to reboot (this is a Samba server for
student labs, and the coming week is the last week of term with
everyone working on their assignments), I need to be reasonably sure
that 2.2.19pre17 doesn't have any known showstopper bugs.

So, does anyone have any comments on whether or not 2.2.19pre17 is a
good move, or should I be looking at an earlier 2.2.19pre?

This is a dual PIII/600E, with a Mylex RAID controller, one 3c905B NIC,
an on-board Intel EEPro 100 interface, ext2 filesystems and disk quotas. 

Thanks in advance for comments.

Martin
-- 
Martin Radford              |   "Only wimps use tape backup: _real_ 
martin@zamenhof.demon.co.uk | men just upload their important stuff  -o)
Registered Linux user #9257 |  on ftp and let the rest of the world  /\\
- see http://counter.li.org |       mirror it ;)"  - Linus Torvalds _\_V
