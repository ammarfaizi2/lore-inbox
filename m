Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261975AbTCQHWD>; Mon, 17 Mar 2003 02:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262038AbTCQHWD>; Mon, 17 Mar 2003 02:22:03 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:31783
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261975AbTCQHWC>; Mon, 17 Mar 2003 02:22:02 -0500
Date: Mon, 17 Mar 2003 02:28:26 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>, Mark Haverkamp <markh@osdl.org>
Subject: Re: [Lse-tech] [PATCH][ANNOUNCE] 32way/8quad NUMAQ booting with 16
 IOAPICs, 223 IRQs
In-Reply-To: <20030317062838.GN5891@holomorphy.com>
Message-ID: <Pine.LNX.4.50.0303170226180.2229-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303071148150.18716-100000@montezuma.mastecende.com>
 <20030317055415.GM5891@holomorphy.com> <Pine.LNX.4.50.0303170107560.2229-100000@montezuma.mastecende.com>
 <20030317062838.GN5891@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Mar 2003, William Lee Irwin III wrote:

> On Sun, 16 Mar 2003, William Lee Irwin III wrote:
> >> Running out of IRQ's? Simply jacking up NR_IRQS and HARDIRQ_BITS should
> >> suffice if this is what I think it is.
> 
> On Mon, Mar 17, 2003 at 01:11:44AM -0500, Zwane Mwaikambo wrote:
> > I'll have to see what repurcussions that will bring about, but i'll add 
> > that to the TODO list.
> 
> Well, I tried it in my prior attempt and didn't have problems in that
> area. AFAICT it "just works" if you jack up the numbers.

Cool i'm trying to get hold of some more SCSI HBAs and disks to put on 
other nodes (plenty of FC but no drivers), i'll let you know how it goes.

> Also, NUMA-Q's max at 640 routeable RTE's with 16 quads so you'll only
> need to add 1 to HARDIRQ_BITS.
>
> The cpu count issue I've fixed in a separate patch.

I'd have to rob a couple more poor souls to get 16 quads ;)

	Zwane
-- 
function.linuxpower.ca
