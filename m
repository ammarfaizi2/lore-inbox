Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263971AbUFSPB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263971AbUFSPB0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 11:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbUFSPB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 11:01:26 -0400
Received: from smtp.loomes.de ([212.40.161.2]:17598 "EHLO falcon.loomes.de")
	by vger.kernel.org with ESMTP id S263971AbUFSPBS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 11:01:18 -0400
From: Sebastian Slota <sebastian@sslota.de>
To: linux-kernel@vger.kernel.org
Subject: Raid issues on Sil 3114 (MB: Abit MAX3, i875 )
Date: Sat, 19 Jun 2004 17:01:24 +0200
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406191701.24787.sebastian@sslota.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

My Problem:

I'm trying to get my RAID0 created with BIOS to run with Linux ( 2.6.6 
kernel ). AS I'm having a partition for WinXP (for games only) and Liked to 
hahe it on RAID0 for more performance...

Problems:

#1 - Linux sees the HD's but dont recognises the partitions
	I learned that 2.4 kernel was having some 'medley' extension in ataraid that 
allowed to see the partitions... its missing in 2.6 and should be replaced 
with udev (?)

#2 - I deleted the array and created under winxp LVA's for drive 1 and 2, 
created there a software raid0 for windows (?) - dont know how to explain it, 
its M$ sh....
Linux sees that as a device but is unable to do anything with it! (NTFS 
Partiton)

Am I wrong or is it impossible for linux to use this M$ LVAs? I've found a 
howto for linux lva but I dont think windows will run with it!

#3 - And here I'm open for all suggestions:
I'd like to have:
	- WinXP ( Games partition ) best as Raid0 - no need for security...
	- Linux1 ( Root as Raid0, Home as Raid5, maybe or normal... dont know yet )
	- Linux2 ( test system )
	- Fat32 partiton for sharing stuff between Win and Linux ( as I'm having a 
	   server I'm not bound to it! )
My HD's are 4 x 160GB SATA on Silicon Image 3114 onboard, 3GHz P4 HT, 1GB CL2 
Ram.
I'm havind my important stuff on a RAID1 server, so the desktop pc is meant 
for performance only! no need for raid1!

My destined Linux is Yoper, cause I'm currently on mandrake and its so slow 
you can get a coffee while starting anything!

Thanks in advance,

Sebastian
