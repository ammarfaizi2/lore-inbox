Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129424AbRAaXbm>; Wed, 31 Jan 2001 18:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129353AbRAaXbc>; Wed, 31 Jan 2001 18:31:32 -0500
Received: from quechua.inka.de ([212.227.14.2]:16242 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S129347AbRAaXbO>;
	Wed, 31 Jan 2001 18:31:14 -0500
Date: Thu, 1 Feb 2001 00:31:13 +0100
To: James Sutherland <jas88@cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reiserfs min size (was: [2.4.1] mkreiserfs on loopdevice freezes kernel)
Message-ID: <20010201003113.A29077@lina.inka.de>
In-Reply-To: <20010131232757.A23675@lina.inka.de> <Pine.SOL.4.21.0101312315040.24868-100000@orange.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.SOL.4.21.0101312315040.24868-100000@orange.csi.cam.ac.uk>; from jas88@cam.ac.uk on Wed, Jan 31, 2001 at 11:15:56PM +0000
From: Bernd Eckenfels <ecki@lina.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2001 at 11:15:56PM +0000, James Sutherland wrote:
> > dd if=/dev/zero of=/var/loop.img count=32768 size=4096
> 
> That just creates a 128Mb file of zeros... This sounds a bit small. Why
> "size=4096"??

because i am too tired to calculate. mkreiserfs wants 32768 (32*1024) blocks
with a size of 4k. I created the smallest possible image to test reiserfs.

> > Yes, I wonder if it is a Error in mkreiserfs to require 128MB.
> 
> Have you tried using a smaller blocksize to mkreiserfs?

Sure I have.

Greetings
Bernd
-- 
  (OO)      -- Bernd_Eckenfels@Wendelinusstrasse39.76646Bruchsal.de --
 ( .. )  ecki@{inka.de,linux.de,debian.org} http://home.pages.de/~eckes/
  o--o     *plush*  2048/93600EFD  eckes@irc  +497257930613  BE5-RIPE
(O____O)  When cryptography is outlawed, bayl bhgynjf jvyy unir cevinpl!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
