Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264501AbUEMUGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264501AbUEMUGY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 16:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUEMTwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 15:52:21 -0400
Received: from out010pub.verizon.net ([206.46.170.133]:32216 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S264820AbUEMTpF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 15:45:05 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: 2.6.6-mm2 foibles
Date: Thu, 13 May 2004 15:44:59 -0400
User-Agent: KMail/1.6
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <200405131442.27573.gene.heskett@verizon.net> <1084475560.1793.0.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1084475560.1793.0.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405131544.59441.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [151.205.53.135] at Thu, 13 May 2004 14:45:02 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 May 2004 15:12, Felipe Alfaro Solana wrote:
>On Thu, 2004-05-13 at 20:42, Gene Heskett wrote:
>> Greetings;
>>
>> I just booted to a 2.6.6-mm2 kernel, and discoverd I had no sound.
>>  So I logged back out of x, and found I had no keyboard!  ssh'd in
>> from the firewall and rebooted it.
>>
>> Both sound, and the backswitch from x were working perfectly up to
>> and including 2.6.6.
>
>I'm also having problems with 2.6.6-mm2 and losing my keyboard.
> After logging into X, after a while, the keyboard stops responding.
> However, my USB mouse still works.

Let me include some of the warnings from the latest build, from 'make 
bzImage':

fs/smbfs/inode.c: In function `smb_fill_super':
fs/smbfs/inode.c:562: warning: comparison is always false due to 
limited range of data type
fs/smbfs/inode.c:563: warning: comparison is always false due to 
limited range of data type
[...]
  DEVLIST drivers/pci/devlist.h
Line 2335: Device name too long. Name truncated.
Adaptec AAR-1210SA SATA HostRAID Controller
Line 2353: Device name too long. Name truncated.
Silicon Image SiI 3114 SATARaid Controller
Line 5158: Device name too long. Name truncated.
IT/ITE8212 Dual channel ATA RAID controller (PCI version seems to be 
IT8212, embedded seems to be ITE8212)
Line 6101: Device name too long. Name truncated.
Cisco Aironet 340 802.11b Wireless LAN Adapter/Aironet PC4800
Line 6824: Device name too long. Name truncated.
SMC2602W EZConnect / Addtron AWA-100 / Eumitcom PCI WL11000
[...]
drivers/video/fbmem.c: In function `fb_cursor':
drivers/video/fbmem.c:922: warning: passing arg 1 of `copy_from_user' 
discards qualifiers from pointer target type
[...]
No warnings during the 'make modules'

I can attach the .config if someone wants to see it.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
