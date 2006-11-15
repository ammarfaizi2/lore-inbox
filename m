Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754451AbWKOKVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754451AbWKOKVS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 05:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966739AbWKOKVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 05:21:18 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:22030 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752367AbWKOKVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 05:21:17 -0500
Date: Wed, 15 Nov 2006 11:21:22 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Stephen Hemminger <shemminger@osdl.org>, gregkh@suse.de,
       linux-pci@atrey.karlin.mff.cuni.cz, Komuro <komurojun-mbn@nifty.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@redhat.com>, Ernst Herzberg <earny@net4u.de>,
       Len Brown <len.brown@intel.com>, Andre Noll <maan@systemlinux.org>,
       Andi Kleen <ak@suse.de>, discuss@x86-64.org,
       Prakash Punnoor <prakash@punnoor.de>, phil.el@wanadoo.fr,
       oprofile-list@lists.sourceforge.net,
       Alex Romosan <romosan@sycorax.lbl.gov>,
       Jens Axboe <jens.axboe@oracle.com>,
       Andrey Borzenkov <arvidjaar@mail.ru>,
       Alan Stern <stern@rowland.harvard.edu>,
       linux-usb-devel@lists.sourceforge.net
Subject: 2.6.19-rc5: known regressions (v3)
Message-ID: <20061115102122.GQ22565@stusta.de>
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This email lists some known regressions in 2.6.19-rc5 compared to 2.6.18
that are not yet fixed in Linus' tree.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way possibly
involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : PCI MSI setting corrupted during resume
References : http://bugzilla.kernel.org/show_bug.cgi?id=7479
Submitter  : Stephen Hemminger <shemminger@osdl.org>
Status     : unknown


Subject    : SMP kernel can not generate ISA irq properly
References : http://lkml.org/lkml/2006/10/22/15
             http://lkml.org/lkml/2006/11/10/142
Submitter  : Komuro <komurojun-mbn@nifty.com>
Handled-By : "Eric W. Biederman" <ebiederm@xmission.com>
             Ingo Molnar <mingo@redhat.com>
Status     : problem is being debugged


Subject    : ThinkPad R50p: boot fail with (lapic && on_battery)
References : http://lkml.org/lkml/2006/10/31/333
Submitter  : Ernst Herzberg <earny@net4u.de>
Handled-By : Len Brown <len.brown@intel.com>
Status     : problem is being debugged


Subject    : x86_64: Bad page state in process 'swapper'
References : http://lkml.org/lkml/2006/11/10/135
             http://lkml.org/lkml/2006/11/10/208
Submitter  : Andre Noll <maan@systemlinux.org>
Handled-By : Andi Kleen <ak@suse.de>
Status     : Andi is investigating


Subject    : x86_64: oprofile doesn't work
References : http://lkml.org/lkml/2006/10/27/3
Submitter  : Prakash Punnoor <prakash@punnoor.de>
Status     : unknown


Subject    : unable to rip cd
References : http://lkml.org/lkml/2006/10/13/100
             http://lkml.org/lkml/2006/11/8/42
Submitter  : Alex Romosan <romosan@sycorax.lbl.gov>
Handled-By : Jens Axboe <jens.axboe@oracle.com>
Status     : Jens is investigating


Subject    : can't disable OHCI wakeup via sysfs
References : http://lkml.org/lkml/2006/11/11/33
Submitter  : Andrey Borzenkov <arvidjaar@mail.ru>
Handled-By : Alan Stern <stern@rowland.harvard.edu>
Patch      : http://lkml.org/lkml/2006/11/13/261
Status     : patch available


