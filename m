Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755890AbWKQUk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755890AbWKQUk7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 15:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755893AbWKQUk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 15:40:58 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1541 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1755886AbWKQUki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 15:40:38 -0500
Date: Fri, 17 Nov 2006 21:40:36 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@timesys.com>,
       Alan Stern <stern@rowland.harvard.edu>, Ingo Molnar <mingo@elte.hu>,
       davej@codemonkey.org.uk, cpufreq@lists.linux.org.uk,
       Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>,
       Mattia Dongili <malattia@linux.it>, Andre Noll <maan@systemlinux.org>,
       Andi Kleen <ak@suse.de>, discuss@x86-64.org,
       Prakash Punnoor <prakash@punnoor.de>, phil.el@wanadoo.fr,
       oprofile-list@lists.sourceforge.net, Ray Lee <ray-lk@madrabbit.org>,
       Michael Buesch <mb@bu3sch.de>, Larry Finger <Larry.Finger@lwfinger.net>,
       st3@riseup.net, linville@tuxdriver.com, netdev@vger.kernel.org,
       David Brownell <david-b@pacbell.net>, Len Brown <len.brown@intel.com>,
       linux-acpi@vger.kernel.org, Ernst Herzberg <earny@net4u.de>
Subject: 2.6.19-rc6: known regressions (v2)
Message-ID: <20061117204036.GK31879@stusta.de>
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


Subject    : cpufreq notification broken
References : http://lkml.org/lkml/2006/11/16/177
Submitter  : Thomas Gleixner <tglx@timesys.com>
Caused-By  : Alan Stern <stern@rowland.harvard.edu>
             commit b4dfdbb3c707474a2254c5b4d7e62be31a4b7da9
Handled-By : Ingo Molnar <mingo@elte.hu>
             Linus Torvalds <torvalds@osdl.org>
Status     : patches are being discussed


Subject    : CPU_FREQ_GOV_ONDEMAND=y compile error
References : http://lkml.org/lkml/2006/11/17/198
Submitter  : alex1000@comcast.net
Caused-By  : Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
             commit 05ca0350e8caa91a5ec9961c585c98005b6934ea
Handled-By : Mattia Dongili <malattia@linux.it>
Patch      : http://lkml.org/lkml/2006/11/17/236
Status     : patch available


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

