Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292380AbSBBU2V>; Sat, 2 Feb 2002 15:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292381AbSBBU2M>; Sat, 2 Feb 2002 15:28:12 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:41384
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S292380AbSBBU2G>; Sat, 2 Feb 2002 15:28:06 -0500
Date: Sat, 2 Feb 2002 15:37:42 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pierre Rousselet <pierre.rousselet@wanadoo.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.16 with es1370 pci
Message-ID: <20020202153742.A3701@animx.eu.org>
In-Reply-To: <20020101104611.A30843@animx.eu.org> <E16LSVd-0000pj-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <E16LSVd-0000pj-00@the-village.bc.nu>; from Alan Cox on Tue, Jan 01, 2002 at 05:15:28PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > used the 2nd dsp on this card since this boot, but I know it works since I
> > used it the last boot.  When the first quits, they both are gone.  But
> > seeing how no interrupts are being delivered, makes sense (see below)
> 
> Boot withg the "noapic" option. Quite how your system has managed to
> lose an interrupt in the APIC hardware I don't know, but the APIC's
> certainly have bugs. It could also be an edge/level trigger but if the BIOS
> confused it because IRQ15 was for some kind of IDE device, but I see no
> evidence of that.
> 
> If it happens with APIC disabled ("noapic")  then the second option might
> be worth investigating.

It's been a while since I've added more to this.

so far, alan, noapic has kept my es1370 card working w/o problems.  Any clue
why it doesn't work when apic is used?  It will usually stop working during
play and will not work again until a reboot.  (I don't even need to
hardreset the system)

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
