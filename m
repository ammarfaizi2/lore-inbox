Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261587AbSKLPTx>; Tue, 12 Nov 2002 10:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261590AbSKLPTw>; Tue, 12 Nov 2002 10:19:52 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:20228 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261587AbSKLPTw>; Tue, 12 Nov 2002 10:19:52 -0500
Date: Tue, 12 Nov 2002 10:25:09 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jens Axboe <axboe@suse.de>,
       Torben Mathiasen <torben.mathiasen@hp.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH-2.5.46] IDE BIOS timings
In-Reply-To: <20021112101546.A29909@ucw.cz>
Message-ID: <Pine.LNX.3.96.1021112102039.23968B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Nov 2002, Vojtech Pavlik wrote:

> On Mon, Nov 11, 2002 at 12:10:13PM -0500, Bill Davidsen wrote:

> > This is one of those things which we should allow at user risk. After all,
> > you can shoot yourself in the foot with hdparm as well, there are many
> > unwise things allowed.
> > 
> > Having seen all the warnings from bad setup of MPS and ACPI in dmesg, I
> > would say it's more likely that the BIOS get these settings right, since
> > they may be used by that other operating system.
> 
> I can tell you that many VIA (namely older) boards simply crash after
> the first DMA access when you don't fix the timings/fifo settings of the
> chip after what mess the BIOS left there.

Then those users shouldn't use the option. The standard behaviour would
remain the same, it only affects those who choose to use it. I don't doubt
it could cause problems on some boards, but there are many things which do
(like compiling for P4 on a 486 which someone local tried).

It should be marked experimental initially, and probably DANGEROUS
permanently.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

