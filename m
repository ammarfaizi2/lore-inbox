Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAFDEM>; Fri, 5 Jan 2001 22:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129406AbRAFDED>; Fri, 5 Jan 2001 22:04:03 -0500
Received: from ferret.phonewave.net ([208.138.51.183]:38671 "EHLO
	tarot.mentasm.org") by vger.kernel.org with ESMTP
	id <S129324AbRAFDDv>; Fri, 5 Jan 2001 22:03:51 -0500
Date: Fri, 5 Jan 2001 19:03:48 -0800
To: linux-kernel@vger.kernel.org
Subject: Re: usb + smp + apollo pro 133a + 2.4.0 = still broken
Message-ID: <20010105190348.A14712@ferret.phonewave.net>
In-Reply-To: <20010105125006.B1569@tesla.admin.cto.netsol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010105125006.B1569@tesla.admin.cto.netsol.com>; from pete@research.netsol.com on Fri, Jan 05, 2001 at 12:50:07PM -0500
From: idalton@ferret.phonewave.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2001 at 12:50:07PM -0500, Pete Toscano wrote:
> just a heads up that usb in smp-enabled 2.4.0 kernels running on
> machines with the via apollo pro 133a chipset is still broken.  the last
> word i heard was that it's a pci irq routing problem.  smp and usb will
> play together pretty nicely if you disable apic (ie. "noapic" to lilo).
> 
> i'm more than willing to help test patches and provide any more info to
> people working on this, but i lack the low-level knowledge to actually
> fix it.

I have a Triton II SMP board (two P200 MMX) that has the same
problem. I'm also willing to test still.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
