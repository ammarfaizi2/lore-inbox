Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129359AbRCHRWz>; Thu, 8 Mar 2001 12:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129355AbRCHRWp>; Thu, 8 Mar 2001 12:22:45 -0500
Received: from CPE-61-9-149-253.vic.bigpond.net.au ([61.9.149.253]:20866 "EHLO
	elektra.higherplane.net") by vger.kernel.org with ESMTP
	id <S129306AbRCHRWa>; Thu, 8 Mar 2001 12:22:30 -0500
Date: Fri, 9 Mar 2001 04:23:08 +1100
From: john slee <indigoid@higherplane.net>
To: Jules Bean <jules@jellybean.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can't use high IRQs on ISA ethernet card
Message-ID: <20010309042308.B1533@higherplane.net>
In-Reply-To: <20010308145142.A7572@blueberry.jellybean.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010308145142.A7572@blueberry.jellybean.co.uk>; from jules@jellybean.co.uk on Thu, Mar 08, 2001 at 02:51:42PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2001 at 02:51:42PM +0000, Jules Bean wrote:
> So, in summary, what seems to me to be happening is that the high IRQs
> (9-13, say) appear to be unavailable for use by ISA cards on my
> machine, at the moment.  The kernel allows ISA cards to claim these
> IRQs (and the cards then show up in /proc/interrupts) but they don't
> actually seem to get the interrupts.  I don't know if the BIOS is
> stealing them, or the kernel, or what.

my beloved gravis ultrasound classic (ISA, non-pnp) works fine in 2.2.x
and 2.4.x, with io=0x260 irq=11 dma=7.  *hug gravis*

also my dec etherworks3 (different machine) seems to be working
perfectly well in 2.2.x with irq 10, haven't had sufficient spare time
to try it in 2.4 yet...

do you smell a hardware bug?

j.

-- 
all your base are belong to us!
