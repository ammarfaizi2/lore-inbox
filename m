Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129678AbQK3VMU>; Thu, 30 Nov 2000 16:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129815AbQK3VMK>; Thu, 30 Nov 2000 16:12:10 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:50722 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129678AbQK3VMD>; Thu, 30 Nov 2000 16:12:03 -0500
Subject: Re: Pls add this driver to the kernel tree !!
To: hahn@coffee.psychology.mcmaster.ca (Mark Hahn)
Date: Thu, 30 Nov 2000 20:41:19 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10011301414520.18688-100000@coffee.psychology.mcmaster.ca> from "Mark Hahn" at Nov 30, 2000 02:16:16 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E141aW8-0007mU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Actually, there is some benefit in leaving the LINUX_VERSION_CODE checks
> > there...  If someone wants to back-port the driver to 2.2, this makes it
> > much easier.  Also, some people like to maintain a single driver for all
> > of the kernel versions, so they don't have to bugfix each driver version.
> 
> backports hurt forward progress.

beware of content free dogma


Or in longer terms: Backporting is actually often very useful. It has helped
in many cases to say definitively 'this must be the driver' or 'its stable on
2.2 are we sure the pci code is right' type things. Think of debugging as
solving a large set of simultaneous equations. The more equations you have
the easier it is


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
