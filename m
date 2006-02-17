Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751691AbWBQXOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbWBQXOq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 18:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751599AbWBQXOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 18:14:46 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:17931 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751478AbWBQXOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 18:14:45 -0500
Date: Sat, 18 Feb 2006 00:14:44 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>, paulus@samba.org,
       linuxppc-dev@ozlabs.org, gregkh@suse.de,
       Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>, len.brown@intel.com,
       linux-acpi@vger.kernel.org, Meelis Roos <mroos@linux.ee>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       linux-input@atrey.karlin.mff.cuni.cz
Subject: 2.6.16-rc4: known regressions
Message-ID: <20060217231444.GM4422@stusta.de>
References: <Pine.LNX.4.64.0602171438050.916@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602171438050.916@g5.osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This email lists some known regressions in 2.6.16-rc4 compared to 2.6.15.

If you find your name in the Cc header, you are either submitter of one 
of the bugs, maintainer of an affectected subsystem or driver, a patch 
of you was declared guilty for a breakage or I'm considering you in any 
other way possibly involved with one or more of these issues.


Subject    : gnome-volume-manager broken on powerpc since 2.6.16-rc1
References : http://bugzilla.kernel.org/show_bug.cgi?id=6021
Submitter  : John Stultz <johnstul@us.ibm.com>
Status     : still present in -git two days ago


Subject    : S3 sleep hangs the second time - 600X
References : http://bugzilla.kernel.org/show_bug.cgi?id=5989
Submitter  : Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Status     : problematic commit identified,
             further discussion is in the bug

Subject    : psmouse starts losing sync in 2.6.16-rc2
References : http://lkml.org/lkml/2006/2/5/50
Submitter  : Meelis Roos <mroos@linux.ee>
Handled-By : Dmitry Torokhov <dmitry.torokhov@gmail.com>
Status     : Dmitry: Working on various manifestations of this one.
                     At worst we will have to disable resync by default
                     before 2.6.16 final is out and continue in 2.6.17 cycle.



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

