Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbRBHIeg>; Thu, 8 Feb 2001 03:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129033AbRBHIe1>; Thu, 8 Feb 2001 03:34:27 -0500
Received: from mspool.gts.cz ([212.47.0.11]:8466 "EHLO mspool.gts.cz")
	by vger.kernel.org with ESMTP id <S129032AbRBHIeS>;
	Thu, 8 Feb 2001 03:34:18 -0500
Date: Thu, 8 Feb 2001 09:34:01 +0100
From: Martin Mares <mj@suse.cz>
To: Tim Hockin <thockin@isunix.it.ilstu.edu>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Adam Lackorzynski <al10@inf.tu-dresden.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI-Devices and ServerWorks chipset
Message-ID: <20010208093401.A119@albireo.ucw.cz>
In-Reply-To: <Pine.GSO.3.96.1010117122300.22695B-100000@delta.ds2.pg.gda.pl> <200101230301.VAA13439@isunix.it.ilstu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200101230301.VAA13439@isunix.it.ilstu.edu>; from thockin@isunix.it.ilstu.edu on Mon, Jan 22, 2001 at 09:01:36PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> 0x44 is the primary bus number of the host bridge, and 0x45 is the
> subordinate bus number for the bridge.  Just like a PCI-PCI bridge, but
> different :)  Since there are two CNB30 functions, each has unique values
> for this.  The primary bus of the second bridge must be the subordinate bus
> of the first bridge + 1.  PRIMARY(1) = SUBORDINATE(0) + 1;

Yes, this holds for the registers, but not for the actual bus numbers
in the dump sent by Adam -- it shows primary busses 00 and 02, registers
of function 0 say 00--00, of function 1 it's 01--06.

				Have a nice fortnight
-- 
Martin `MJ' Mares <mj@ucw.cz> <mj@suse.cz> http://atrey.karlin.mff.cuni.cz/~mj/
New PC concept: "plug and pray"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
