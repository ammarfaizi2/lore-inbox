Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317661AbSGaCtT>; Tue, 30 Jul 2002 22:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317660AbSGaCtT>; Tue, 30 Jul 2002 22:49:19 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:46349 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S317661AbSGaCtS>; Tue, 30 Jul 2002 22:49:18 -0400
Date: Tue, 30 Jul 2002 22:46:55 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Jakob Oestergaard <jakob@unthought.net>
cc: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: RAID problems
In-Reply-To: <20020730175505.GI11129@unthought.net>
Message-ID: <Pine.LNX.3.96.1020730223102.6974A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2002, Jakob Oestergaard wrote:

> On Tue, Jul 30, 2002 at 01:25:37PM -0400, Bill Davidsen wrote:

> > Why does no one seem surprised that one drive failed and the system marked
> > four bad instead of using the spare in the first place? That's a more
> > interesting question.
> 
> As stated in the above URL (no shit, really!), this can happen for
> example if some device hangs the SCSI bus.

I think you misread my comment, it was not "why doesn't the documentation
say this" but rather "why does software RAID have this problem?" I know
this can happen in theory, but it seems that the docs imply that this
isn't a surprise in practice. I've been running systems with SCSI RAID and
hardware controllers since 1989 (or maybe 1990), I've got EMC and HDS
boxes, aaraid and ipc controllers, Promise and CMC(??) on system boards,
and a number of systems running software RAID. And of all the drive
failures I've had, exactly one had more than one drive fail, and that was
in a power {something} issue which took out multiple drives and system
boards on many systems. 

I just surprised that the software RAID doesn't have better luck with
this, I don't see any magic other than maybe a bus reset the firmware
would be doing, and I'm wondering why this seems to be common with Linux.
Or am I misreading the frequency with which it happens?
 
> Did *anyone* read that section ?!?   ;)
> 
> If someone feels the explanation there could be better, please just send
> the better explanation to me and it will get in.  Really, this section
> is one of the few sections that I did *not* update in the HOWTO, because
> I really felt that it was still both adequate (since no-one has demanded
> elaboration) and correct.

Thye words are clear, I'm surprised at the behaviour. Yes, I know that's
not your thing.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

