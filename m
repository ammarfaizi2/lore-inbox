Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269796AbRHTXJG>; Mon, 20 Aug 2001 19:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269804AbRHTXI4>; Mon, 20 Aug 2001 19:08:56 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:57473
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S269796AbRHTXIo>; Mon, 20 Aug 2001 19:08:44 -0400
Date: Mon, 20 Aug 2001 16:08:31 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Mike Castle <dalgoda@ix.netcom.com>, linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
Message-ID: <20010820160831.B2562@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <482526995.998263790@[169.254.45.213]> <20010819192634.H30309@thune.mrc-home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010819192634.H30309@thune.mrc-home.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 19, 2001 at 07:26:34PM -0700, Mike Castle wrote:
> On Sun, Aug 19, 2001 at 11:29:51PM +0100, Alex Bligh - linux-kernel wrote:
> > The machine was bought and tested in one config. A hardware
> > random number generator is something else to go wrong, and
> > additional expense.
> 
> And making a change to the kernel is not a different config?

In the very strict QA'ing sense, yes.  Any sort of change whatsoever is a
different config and throws out all of the other testing results.  Which
still leaves the cost argument in this case.  But, there are degrees of
how dangerous a change can be.  From my quick skimming of this code, it
looks like the only changes are to mark network irq bits as possible entropy.
Nothing more.  I could be totally wrong of course. :)
Therefore, it's quite probable anyhow that this config won't have any more
problems that the other config had.  Of course the only way to prove this
is much QA'ing.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
