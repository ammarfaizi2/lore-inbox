Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264468AbRFISod>; Sat, 9 Jun 2001 14:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264473AbRFISoX>; Sat, 9 Jun 2001 14:44:23 -0400
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:950 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S264468AbRFISoS>; Sat, 9 Jun 2001 14:44:18 -0400
Date: Sat, 9 Jun 2001 20:44:34 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] usb.c: USB device not accepting new address=4 (error=-110)
Message-ID: <20010609204434.Z11815@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20010609064123.V11815@nightmaster.csn.tu-chemnitz.de> <0ab501c0f0ac$10532720$cc07aace@brownell.org> <20010609091919.W11815@nightmaster.csn.tu-chemnitz.de> <0ae201c0f0e6$1b59fb00$cc07aace@brownell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <0ae201c0f0e6$1b59fb00$cc07aace@brownell.org>; from david-b@pacbell.net on Sat, Jun 09, 2001 at 06:14:24AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 09, 2001 at 06:14:24AM -0700, David Brownell wrote:
> Then whatever sets up your ServerWorks ServerSet III LE chipset
> needs its PCI IRQ setup fixed ...

Right. "noapic" helps, which is a sure sign of such bugs.

> I'm not sure how to do this.

Neither me. I boot with "noapic" now, but this sucks on SMP, as
we all know :-(

> Perhaps someone who's familiar with arch/i386/kernel/pci-*.c
> irq setup can suggest the right patch for this problem.  I think
> the "dmesg" output in your original post probably had the info
> needed to figure that out.

Maybe some of the people with good contacts to ServerWorks Inc.
can help me (and all the ServerWorks customers) out...


Thanks and Regards

Ingo oeser
-- 
To the systems programmer,
users and applications serve only to provide a test load.
