Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267385AbSKPWXv>; Sat, 16 Nov 2002 17:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267386AbSKPWXv>; Sat, 16 Nov 2002 17:23:51 -0500
Received: from hera.cwi.nl ([192.16.191.8]:8924 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S267385AbSKPWXu>;
	Sat, 16 Nov 2002 17:23:50 -0500
From: Andries.Brouwer@cwi.nl
Date: Sat, 16 Nov 2002 23:30:45 +0100 (MET)
Message-Id: <UTC200211162230.gAGMUji20171.aeb@smtp.cwi.nl>
To: jgarzik@pobox.com, mzyngier@freesurf.fr
Subject: Re: [PATCH] sysfs stuff for eisa bus [1/3]
Cc: Andries.Brouwer@cwi.nl, aebr@win.tue.nl, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, willy@debian.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Jeff Garzik <jgarzik@pobox.com>

    > AB> Yes, lists are fine, but not in the kernel source.

    Unfortunately, I respectfully disagree with Andries.

:-)

    Until drivers/pci/pci.ids list is removed from the kernel source,
    I think we are best served by modelling EISA on PCI as much as
    is reasonable.

That I do not have a strong opinion about, not having much
experience with collecting PCI IDs. (I send them to Vojtech :-))
But really, Jeff, these EISA IDs are a pile of junk.
So many with the same ID describe different hardware.

I like a certain level of quality in the kernel source.
When the kernel prints something it should not be random junk.
"Never mind what the Linux kernel says - that is all just nonsense".

A user space utility with a long list is fine: 70% chance that
it is right, 30% that it is wrong. A user space utility can
print: "with that ID we have seen the following five hardware
descriptions".

Since the kernel does not use these values - they are for
informational purposes only - I would prefer to avoid the
misinformation.

Andries


[In the eisa list we see that ISAAB01 is a "HAYES Smartmodem 1200B".
My ISAAB01 however is a "Hayes Smartmodem 2400B". What do you print?]


