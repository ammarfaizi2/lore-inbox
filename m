Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131305AbRDPMC1>; Mon, 16 Apr 2001 08:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131269AbRDPMCQ>; Mon, 16 Apr 2001 08:02:16 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:40709 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S131248AbRDPMCB>;
	Mon, 16 Apr 2001 08:02:01 -0400
Date: Fri, 13 Apr 2001 00:29:21 +0000
From: Pavel Machek <pavel@suse.cz>
To: Mike Castle <dalgoda@ix.netcom.com>, linux-kernel@vger.kernel.org
Subject: Re: Let init know user wants to shutdown
Message-ID: <20010413002920.C43@(none)>
In-Reply-To: <20010405000215.A599@bug.ucw.cz> <9b04food@ncc1701.cistron.net> <20010410164109.A1766@thune.mrc-home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010410164109.A1766@thune.mrc-home.com>; from dalgoda@ix.netcom.com on Tue, Apr 10, 2001 at 04:41:09PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >Init should get to know that user pressed power button (so it can do
> > >shutdown and poweroff). Plus, it is nice to let user know that we can
> > 
> > Not so hasty ;)
> > 
> > >+		printk ("acpi: Power button pressed!\n");
> > >+		kill_proc (1, SIGTERM, 1);
> 
> [reasons deleted]
> 
> Is using a signal the appropriate thing to do anyway?
> 
> Wouldn't there be better solutions?
> 
> Perhaps a mechanism a user space program can use to communicate to the kernel
> (ala arpd/kerneld message queues, or something like klogd).  Then a more
> general user space tool could be used that would do policy appropriate
> stuff, ending with init 0.

init _is_ the tool which is right for defining policy on such issues.

Take a look how UPS managment is handled.

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

