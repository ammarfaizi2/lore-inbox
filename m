Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbVBYTpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVBYTpZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 14:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVBYTpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 14:45:24 -0500
Received: from bay10-f59.bay10.hotmail.com ([64.4.37.59]:15147 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261196AbVBYTpQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 14:45:16 -0500
Message-ID: <BAY10-F5997532B33F688F40D0298D6650@phx.gbl>
X-Originating-IP: [61.247.244.188]
X-Originating-Email: [agovinda04@hotmail.com]
From: "govind raj" <agovinda04@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Init program not starting
Date: Sat, 26 Feb 2005 01:14:24 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 25 Feb 2005 19:45:15.0370 (UTC) FILETIME=[86EB0CA0:01C51B72]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are trying to build a customized kernel from Fedora Core 1
(Linux kernel version 2.4.29). After building and mounting the
root filesystem, it seems to be not proceeding further and at
the same time there is no kernel panic message that is coming
out as well. With additional kernel debugging, it looks like
/sbin/init is getting passed as the init program to be execed.
The permissions of /sbin/init in the root filesystem are proper
and matches the permissions of the init executable in a running
system.

The kernel that is being built out of this version is a mini-kernel
to be used for booting a board. We had taken the pebble distribution
configuration as a base for building the kernel (with the relevant
support for serial and console terminals).

We faced the same problem with using both LILO and GRUB. The last
few lines of the output before the boot-up process seems to go into
an inactive state are as follows(At this time, the terminal still
responds to keystrokes hinting that it has not gone into a complete
limbo or paniced state)

----------------------------------------------
NET4: UNIX domain sockets 1.0/SMP for Linux NET4.0.
hda:hda1
hda:hda1
VFS: Mounted root (ext2 filesystem readonly)
Freeing unused kerned memory: 76k freed

<No more messages but still responds to key strokes>

-----------------------------------------------

We are struck on this for a couple of days now and have been trying
to debug this real hard. Any pointers or clues that you can give us
to resolve this problem would be much appreciated...

Thanks in advance,

Govind

_________________________________________________________________
Start you business on Baazee today! 
http://adfarm.mediaplex.com/ad/ck/4686-26272-10936-31?ck=RegSell Register 
for Free!

