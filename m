Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269531AbTCDUmv>; Tue, 4 Mar 2003 15:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269532AbTCDUmv>; Tue, 4 Mar 2003 15:42:51 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:49937 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S269531AbTCDUmu>; Tue, 4 Mar 2003 15:42:50 -0500
Date: Tue, 4 Mar 2003 15:48:49 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Tomas Szepe <szepe@pinerecords.com>
cc: Christoph Hellwig <hch@infradead.org>, Andrew Walrond <andrew@walrond.org>,
       linux-kernel@vger.kernel.org
Subject: re: 2.5-bk menuconfig format problem
In-Reply-To: <20030303192245.GH6946@louise.pinerecords.com>
Message-ID: <Pine.LNX.3.96.1030304154406.14509B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Mar 2003, Tomas Szepe wrote:

> > [sam@ravnborg.org]
> > 
> > On Mon, Mar 03, 2003 at 06:53:37PM +0000, Christoph Hellwig wrote:
> > > Ah, okay :)  I newer use either menuconfig nor xconfig so I can't comment
> > > on it's placements.  If people who actually do use if feel that it's placed
> > > wrongly feel free to submit a patch to fix it.
> > 
> > The following patch moves it to the menu "Processor type & features"
> > Right before HIMEM.
> 
> Please don't do this.  While HIMEM could still be perceived as a processor
> (architecture) feature, SWAP certainly doesn't qualify.  We already have
> enough misplaced options.

I would think that SWAP would belong with PREEMPT, since they are both
global characteristics of the o/s. Those who care can argue where that
should be.

I could believe that SMP would belong in the same place, since it's a
global option not specific to a single architecture. Any of these could be
greyed out or undisplayed for the few architechtures which don't support
them.

There are arguably others.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

