Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267675AbTAMQue>; Mon, 13 Jan 2003 11:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267827AbTAMQue>; Mon, 13 Jan 2003 11:50:34 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:10324
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267675AbTAMQud>; Mon, 13 Jan 2003 11:50:33 -0500
Date: Mon, 13 Jan 2003 12:00:10 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Jens Axboe <axboe@suse.de>
cc: Terje Eggestad <terje.eggestad@scali.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
In-Reply-To: <20030113164305.GZ14017@suse.de>
Message-ID: <Pine.LNX.4.44.0301131158510.13513-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2003, Jens Axboe wrote:

> On Mon, Jan 13 2003, Terje Eggestad wrote:
> > > > I have the console on a serial port, and a terminal server. With kdb,
> > > > you can enter the kernel i kdb even when deadlocked.
> > > 
> > > Even if spinning with interrupt disabled?
> > 
> > Haven't painted myself into that corner yet. Doubt it, very much.
> 
> These are the nasty hangs, total lockup and no info at all if it wasn't
> for the nmi watchdog triggering. That alone is reason enough for me :-)

It uses NMI's to break into the debugger, so it would also work with 
interrupts disabled and spinning on a lock, the same is also true for 
kgdb.

	Zwane
-- 
function.linuxpower.ca

