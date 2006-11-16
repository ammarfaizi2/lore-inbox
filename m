Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424662AbWKPVhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424662AbWKPVhY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 16:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424666AbWKPVhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 16:37:23 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:40710 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1424662AbWKPVhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 16:37:21 -0500
Date: Thu, 16 Nov 2006 22:37:18 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ray Lee <ray-lk@madrabbit.org>, Michael Buesch <mb@bu3sch.de>,
       Larry Finger <Larry.Finger@lwfinger.net>, st3@riseup.net,
       linville@tuxdriver.com, netdev@vger.kernel.org,
       David Brownell <david-b@pacbell.net>, Len Brown <len.brown@intel.com>,
       Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>,
       linux-acpi@vger.kernel.org, Ernst Herzberg <earny@net4u.de>,
       Ingo Molnar <mingo@elte.hu>, Andre Noll <maan@systemlinux.org>,
       Andi Kleen <ak@suse.de>, discuss@x86-64.org,
       Prakash Punnoor <prakash@punnoor.de>, phil.el@wanadoo.fr,
       oprofile-list@lists.sourceforge.net,
       Dennis Stosberg <dennis@stosberg.net>,
       Greg Kroah-Hartman <gregkh@suse.de>, ecashin@coraid.com,
       Andrey Borzenkov <arvidjaar@mail.ru>,
       Alan Stern <stern@rowland.harvard.edu>,
       linux-usb-devel@lists.sourceforge.net
Subject: 2.6.19-rc6: known regressions
Message-ID: <20061116213717.GJ31879@stusta.de>
References: <Pine.LNX.4.64.0611152008450.3349@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611152008450.3349@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This email lists some known regressions in 2.6.19-rc6 compared to 2.6.18
that are not yet fixed in Linus' tree.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way possibly
involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : bcm43xx: serious problems
References : http://lkml.org/lkml/2006/11/15/296
Submitter  : Ray Lee <ray-lk@madrabbit.org>
Handled-By : Michael Buesch <mb@bu3sch.de>
             Larry Finger <Larry.Finger@lwfinger.net>
Status     : problem is being debugged


Subject    : nasty ACPI regression, AE_TIME errors
References : http://lkml.org/lkml/2006/11/15/12
Submitter  : David Brownell <david-b@pacbell.net>
Handled-By : Len Brown <len.brown@intel.com>
             Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
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
             http://lkml.org/lkml/2006/11/15/92
Submitter  : Prakash Punnoor <prakash@punnoor.de>
Status     : problem is being discussed


Subject    : x86_64 UP compile error
References : http://lkml.org/lkml/2006/11/16/29
Submitter  : Ingo Molnar <mingo@elte.hu>
Caused-By  : Andi Kleen <ak@suse.de>
             commit 8c131af1db510793f87dc43edbc8950a35370df3
Handled-By : Andi Kleen <ak@suse.de>
             Ingo Molnar <mingo@elte.hu>
Patch      : http://lkml.org/lkml/2006/11/16/36
Status     : patch available


Subject    : aoe: Add forgotten NULL at end of attribute list in aoeblk.c
References : http://lkml.org/lkml/2006/11/13/26
Submitter  : Dennis Stosberg <dennis@stosberg.net>
Caused-By  : Greg Kroah-Hartman <gregkh@suse.de>
             commit 4ca5224f3ea4779054d96e885ca9b3980801ce13
Handled-By : Dennis Stosberg <dennis@stosberg.net>
Patch      : http://lkml.org/lkml/2006/11/13/26
Status     : patch available


Subject    : can't disable OHCI wakeup via sysfs
References : http://lkml.org/lkml/2006/11/11/33
Submitter  : Andrey Borzenkov <arvidjaar@mail.ru>
Handled-By : Alan Stern <stern@rowland.harvard.edu>
Patch      : http://lkml.org/lkml/2006/11/13/261
Status     : patch available

