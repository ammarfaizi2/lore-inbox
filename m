Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131060AbQKPQlm>; Thu, 16 Nov 2000 11:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130985AbQKPQlc>; Thu, 16 Nov 2000 11:41:32 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25094 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S131136AbQKPQlR>;
	Thu, 16 Nov 2000 11:41:17 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011161611.QAA02401@raistlin.arm.linux.org.uk>
Subject: Re: 2.4. continues after Aieee...
To: dennis@etinc.com (Dennis)
Date: Thu, 16 Nov 2000 16:11:06 +0000 (GMT)
Cc: R.E.Wolff@BitWizard.nl (Rogier Wolff), linux-kernel@vger.kernel.org
In-Reply-To: <5.0.0.25.0.20001116103133.02162c80@mail.etinc.com> from "Dennis" at Nov 16, 2000 10:34:30 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dennis writes:
> >Not every case causes a panic either.  This week, I had an instance of
> >an i686 box lock solid with a DFE-530TX net card.  Rebooting/power
> >cycling it didn't recover it (despite it working for the past month
> >without any problems).  It only started working again after I moved
> >it into a different PCI slot.
> >
> >I've seen a couple of instances now on totally different hardware where
> >it is possible to lock a PCI bus solid by improper connections on some
> >of the PCI bus lines, so a faulty PCI socket seem to be the most likely
> >cause.
> 
> 
> theres nothing that software can do with a pci bus lockup. You need a 
> hardware watchdog to reboot the system for this type of failure.

If you read on, you'll discover I did in fact say this.
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
