Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbWAECMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbWAECMO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 21:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWAECMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 21:12:14 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:12965 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751183AbWAECMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 21:12:13 -0500
Subject: [Announce] RT patch updates while Ingo is busy
From: Steven Rostedt <rostedt@goodmis.org>
To: Daniel Walker <dwalker@mvista.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>, john stultz <johnstul@us.ibm.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Mark Knecht <markknecht@gmail.com>, Mike Galbraith <efault@gmx.de>,
       "K.R. Foley" <kr@cybsft.com>, Lee Revell <rlrevell@joe-job.com>,
       Serge Noiraud <serge.noiraud@bull.net>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1136412737.12468.92.camel@localhost.localdomain>
References: <200601041832.39089.Serge.Noiraud@bull.net>
	 <Pine.LNX.4.64.0601041234130.22025@dhcp153.mvista.com>
	 <1136412737.12468.92.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 04 Jan 2006 21:11:50 -0500
Message-Id: <1136427110.12468.112.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-04 at 17:12 -0500, Steven Rostedt wrote:
> Ingo has been really busy with getting the mutex stuff into mainline, so
> he hasn't had time to update RT or even work on it very much.  Maybe,
> I'll start up a patch website to hold patches to Ingo's -rt code until
> he has time to work on it again.

While Ingo is busy working 48 hours a day on the new mutex
info-structure, the -rt patch set has been a little slow at getting
patch releases.  So I've started up a little patch fix repository for
the -rt patch set until Ingo has time to get back to this again.

If you have a problem with the -rt patch set, please CC Ingo and myself,
and I'll try to fix the problem and post a patch here.

My updates will be named -sr, so the current release is at
2.6.15-rt1-sr1.  Note, this is more like the stable branch, I'm only
updating bug fixes here.  Although this is not as strict as the stable
branch, my adding a patch will be based mainly on how critical it is.

This release contains:

- latest rtc fix (Steven Rostedt)

- ipv6 mcast rwlock initialization fix (Daniel Walker)

Download from:
http://home.stny.rr.com/rostedt/patches/

Patch order is:

http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.15.tar.bz2
http://redhat.com/~mingo/realtime-preempt/patch-2.6.15-rt1
http://home.stny.rr.com/rostedt/patches/patch-2.6.15-rt1-sr1

-- Steve



