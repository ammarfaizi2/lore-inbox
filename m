Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310577AbSCXROh>; Sun, 24 Mar 2002 12:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310560AbSCXROa>; Sun, 24 Mar 2002 12:14:30 -0500
Received: from bazooka.saturnus.vein.hu ([193.6.40.86]:41857 "EHLO
	bazooka.saturnus.vein.hu") by vger.kernel.org with ESMTP
	id <S310577AbSCXROT>; Sun, 24 Mar 2002 12:14:19 -0500
Date: Sun, 24 Mar 2002 18:14:15 +0100
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: bazooka@enclavenet.hu, linux-kernel@vger.kernel.org
Subject: Re: io-apic not working on i850mv(p4)
Message-ID: <20020324181415.A389@bazooka.saturnus.vein.hu>
In-Reply-To: <200203241442.PAA10726@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
From: Banai Zoltan <bazooka@enclavenet.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2002 at 03:42:01PM +0100, Mikael Pettersson wrote:
> >So it seems to me that the problem is with kernel-bios communication.
> >Maybe the kernel needs the bios to supply the SMP layout?
> >Or ther is need to relocate the DMI scan to early boot stage?
> 
> My ASUS P4T-E is supposed to have an IO-APIC in its 850 chipset,
> and the BIOS setup does allow me to specify apic delivery mode,
> but I've never been able to get the kernel (SMP or UP_IOAPIC)
> to detect the IO-APIC.
> 
> My guess is that Linux only finds the IO-APIC if it's listed in
> the MP-table. Perhaps newer boxes publish the info via ACPI?

I have ACPI configured in, but it does not publish it for me:(
I woud be courious if there is some development, so that linux
finds IO-APIC without supplied MP table.

Regards, Banai
