Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262008AbTCMCyJ>; Wed, 12 Mar 2003 21:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262053AbTCMCyJ>; Wed, 12 Mar 2003 21:54:09 -0500
Received: from bay1-f71.bay1.hotmail.com ([65.54.245.71]:54800 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id <S262008AbTCMCyI>;
	Wed, 12 Mar 2003 21:54:08 -0500
X-Originating-IP: [24.42.200.222]
From: "p b" <bustedkernel@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18-14 rebuild problems
Date: Thu, 13 Mar 2003 03:04:48 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY1-F71mdiR1P30H8F00036c26@hotmail.com>
X-OriginalArrivalTime: 13 Mar 2003 03:04:48.0679 (UTC) FILETIME=[4EDDA370:01C2E90D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been trying to compile the Linux kernel to no avail. I've been 
following the Linux kernel howto's fairly closely. Here's my scenario.

I need to set a few memory and semaphore parameters to accommodate an Oracle 
9i database installation and need to rebuild the kernel as a result.

I'm using RDH 8.0, and a stock kernel 2.4.18-14 on a HP LPR machine w a 
sym53c8xx scsi card. Nothing's special. Virtually all the steps complete 
successfully but for a small wrinkle.

The "make install" piece sez it can't find the sym53c8xx scsi modules. Sure 
enough, perusing the lib/modules/2.4.18.x library indicates no entries for 
…/kernel/drivers/scsi/sym53xx.

If I look at an earlier build, the pieces are there. I’ve tried fudging the 
install by copying them over to my new 
/lib/modules/2.4.18.x/kernel/drives/scsi. But then I get unresolved symbol 
errors upon a “make install” and of course “make modules_install” scrubs my 
fudged entries.

I successfully (?) compiled on one occasion, only to encounter a “scream” 
panic trap indicating I had a missing root, just at about the spot I would 
anticipate the kernel is engaging the sym53c8xx card.

I’ve also tried a 2.4.19 kernel and ran into the same problem.

I got about a week into this and am still hopeful…or perhaps totally 
misguided.

Clearly somebody’s (RDH) been able to compile this kernel, how can I?

Please cc me directly, if that's ok?

Thanks for your time.
PB




_________________________________________________________________
Help STOP SPAM with the new MSN 8 and get 2 months FREE*   
http://join.msn.com/?page=features/junkmail

