Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129874AbRAQWk0>; Wed, 17 Jan 2001 17:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130391AbRAQWkP>; Wed, 17 Jan 2001 17:40:15 -0500
Received: from h201.s254.netsol.com ([216.168.254.201]:21925 "EHLO
	tesla.admin.cto.netsol.com") by vger.kernel.org with ESMTP
	id <S129874AbRAQWkM>; Wed, 17 Jan 2001 17:40:12 -0500
Date: Wed, 17 Jan 2001 17:40:06 -0500
From: Pete Toscano <pete@research.netsol.com>
To: linux-kernel@vger.kernel.org
Subject: Re: VIA chipset discussion
Message-ID: <20010117174006.E1503@tesla.admin.cto.netsol.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0101171358020.1171-100000@ns-01.hislinuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0101171358020.1171-100000@ns-01.hislinuxbox.com>; from pgpkeys@hislinuxbox.com on Wed, Jan 17, 2001 at 02:02:17PM -0800
X-Uptime: 5:16pm  up 7 days, 23:25,  6 users,  load average: 0.02, 0.06, 0.08
X-Married: 430 days, 21 hours, 31 minutes, and 49 seconds
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

well, i know there's a problem with the via apollo pro 133a chipset,
smp, apic, and usb.  it looks like the usb driver (usb-uhci) doesn't
receive any interrupts if apic is enabled.  if you disable apic from the
lilo prompt with "noapic", then it'll all work (of course, without
apic).  

according to the linux-usb maintainers, it's a pci irq routing problem.
i've asked jeff garzik and martin mares if they'll look into it, but
they're pretty busy and i haven't heard anything back from them (not
that'd i'd expect to for quite a while, considering their load).  i've
asked on the list too, but i've only heard back from people with the
same problem, not anyone who can fix the problem.

i've pretty much got the same system as you, except for the ultra66
promise card.

pete


On Wed, 17 Jan 2001, David D.W. Downey wrote:

> 
> Could those that were involved in the VIA chipset discussion email me
> privately at pgpkeys@hislinuxbox.com?
> 
> I'm truly interested in solving this issue. I personally think it's more
> than just the chipset causing the problems.
> 
> 
> I'm looking for members of the list that are using the kernel support for
> the following
> 
> 
> VIA chipset
> Promise controller (PDC2026# with specifics on the PDC20265 (ATA100))
> SMP support
> IDE + SCSI mix in the system.
> 
> 
> I'm trying to track a number of POSSIBLE bugs (can't say they are for
> sure) and any input from folks with this mix of drivers would be
> exponentially useful, even if for nothing more than discounting some of my
> thoughts.
> 
> 
> Also, can anyone summurize the already known and specific problems with
> combinations of the above requirements? I would truly appreciate that. 
> 
> David D.W. Downey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
