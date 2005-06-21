Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262107AbVFUJck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262107AbVFUJck (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 05:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbVFUIJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 04:09:54 -0400
Received: from butters.phys.uwm.edu ([129.89.61.125]:8605 "EHLO
	butters.phys.uwm.edu") by vger.kernel.org with ESMTP
	id S261968AbVFUGvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 02:51:31 -0400
Date: Tue, 21 Jun 2005 01:51:25 -0500 (CDT)
From: David Hammer <hammerd@gravity.phys.uwm.edu>
X-X-Sender: hammerd@butters.phys.uwm.edu
To: linux-kernel@vger.kernel.org
cc: Bruce Allen <ballen@gravity.phys.uwm.edu>
Subject: ksoftirqd 99% cpu
Message-ID: <Pine.LNX.4.44.0506210138190.21987-100000@butters.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I had a server crash while it was running rsync to an nfs mounted 
directory.  At the time of the crash ksoftirqd was using 99% of the cpu.  
The last message in the syslog was:

kernel: 3w9xxx: scsi0: WARNING: Character ioctl timed out, resetting card.

I suspect that this was not what cause the crash but only a symptom.

I tried to "magic sysrq" (I do have it enabled) but was not able to get 
any information.

I have seen that many people have had problems with ksoftirqd taking up 
all the cpu and crashing the system but I could not find what was causing 
the problem or the proper fix.

My system:

- 2.6.10-1.760_FC3smp (stock Fedora Core 3 upgrade) 
- e1000 network cards
- acpi is enabled

Thanks,
David Hammer

