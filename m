Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137067AbRAHL7x>; Mon, 8 Jan 2001 06:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143493AbRAHL7n>; Mon, 8 Jan 2001 06:59:43 -0500
Received: from mspool.gts.cz ([212.47.0.11]:62734 "EHLO mspool.gts.cz")
	by vger.kernel.org with ESMTP id <S137067AbRAHL70>;
	Mon, 8 Jan 2001 06:59:26 -0500
Date: Mon, 8 Jan 2001 12:58:25 +0100
From: Martin Mares <mj@suse.cz>
To: Peter Denison <peterd@pnd-pc.demon.co.uk>
Cc: andre@linux-ide.org, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] Cleanup of PCI device reporting in IDE driver (2.4.0)
Message-ID: <20010108125825.A2126@albireo.ucw.cz>
In-Reply-To: <Pine.LNX.4.21.0101061820310.21275-100000@pnd-pc.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0101061820310.21275-100000@pnd-pc.demon.co.uk>; from peterd@pnd-pc.demon.co.uk on Sat, Jan 06, 2001 at 06:34:02PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Description:
> Cleans up the reporting of PCI device numbers when they are printed out by
> the PCI IDE driver. The dev->devfn value holds both the device number and
> the function number, so it's nicer if they are split out and displayed
> separately to the user.

Better use pci_dev->slot_name, so that the formatting of slot names will
be consistent with what the other drivers and the PCI subsystem itself use.

				Have a nice fortnight
-- 
Martin `MJ' Mares <mj@ucw.cz> <mj@suse.cz> http://atrey.karlin.mff.cuni.cz/~mj/
Linux hackers are funny people -- they count the time in patchlevels.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
