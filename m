Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267967AbTAMSkD>; Mon, 13 Jan 2003 13:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267985AbTAMSkD>; Mon, 13 Jan 2003 13:40:03 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:7095 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S267967AbTAMSkB>;
	Mon, 13 Jan 2003 13:40:01 -0500
Date: Mon, 13 Jan 2003 19:48:31 +0100
From: Jens Axboe <axboe@suse.de>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Terje Eggestad <terje.eggestad@scali.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
Message-ID: <20030113184831.GC14017@suse.de>
References: <20030113164305.GZ14017@suse.de> <Pine.LNX.4.44.0301131158510.13513-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301131158510.13513-100000@montezuma.mastecende.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13 2003, Zwane Mwaikambo wrote:
> On Mon, 13 Jan 2003, Jens Axboe wrote:
> 
> > On Mon, Jan 13 2003, Terje Eggestad wrote:
> > > > > I have the console on a serial port, and a terminal server. With kdb,
> > > > > you can enter the kernel i kdb even when deadlocked.
> > > > 
> > > > Even if spinning with interrupt disabled?
> > > 
> > > Haven't painted myself into that corner yet. Doubt it, very much.
> > 
> > These are the nasty hangs, total lockup and no info at all if it wasn't
> > for the nmi watchdog triggering. That alone is reason enough for me :-)
> 
> It uses NMI's to break into the debugger, so it would also work with 
> interrupts disabled and spinning on a lock, the same is also true for 
> kgdb.

But still requiring up-apic, or smp with apic, right?

-- 
Jens Axboe

