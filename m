Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262052AbRE0OpU>; Sun, 27 May 2001 10:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262087AbRE0OpK>; Sun, 27 May 2001 10:45:10 -0400
Received: from jcwren-1.dsl.speakeasy.net ([216.254.53.52]:5878 "EHLO
	jcwren.com") by vger.kernel.org with ESMTP id <S262052AbRE0Oo5>;
	Sun, 27 May 2001 10:44:57 -0400
Reply-To: <jcwren@jcwren.com>
From: "John Chris Wren" <jcwren@jcwren.com>
To: <linux-kernel@vger.kernel.org>
Subject: Problems with ac12 kernels and up
Date: Sun, 27 May 2001 10:44:49 -0400
Message-ID: <NDBBKBJHGFJMEMHPOPEGAEEACHAA.jcwren@jcwren.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been running 2.4.4-ac11 for a few weeks, and decided to upgrade to
2.4.4-ac18. I applied the patches, compiled, and installed (all per usual),
and when booting, get a kernel panic at the point VFS is trying to mount the
root file system. I started working backwards to find the last kernel that
would boot. I got down to ac13, and the panics stopped, but I get the
following message:

Checking root filesystem. /dev/hde13 is mounted.
Cannot continue, aboorting.
*** An error occurred during the file system check.
*** Dropping you to a shell; the system will reboot
*** when you leave the shell.

Same for ac12. I used the same config file I used for ac11 and previous ac
kernels. I then decided to try the 2.4.5 kernel, which worked fine. I then
applied the 2.4.5-ac1 patches, and got the above message, again.

The system is an Abit KT7A-RAID w/ a 1Ghz Athlon. The dmesg output link
below describes the drive configuration.  The BIOS is configured to boot
from the HPT-370.

As part of the test, I completely reinstalled the 2.4.4 kernel source,
applied the ac11 patch, and my config file, rebuilt and reinstalled. All
worked fine. Any thoughts on why this might be occurring?

I can provide any additional information as necessary. Here are the various
files:

http://jcwren.com/linux/config.txt - config file
http://jcwren.com/linux/dmesg.txt - ac11 dmesg log
http://jcwren.com/linux/lilo.txt - lilo.conf

I'm not smart enough to know how to capture the output for a kernel that
panics and halts. If I can provide any additional information for resolving
the problem, I would be happy to. Oh, and as best as I can tell before it
all scrolls by, the kernel reporting looks to be the same between all
kernels, with only the version being different.

--John

