Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129718AbRAaXQM>; Wed, 31 Jan 2001 18:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129715AbRAaXQE>; Wed, 31 Jan 2001 18:16:04 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:45767 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129695AbRAaXP5>; Wed, 31 Jan 2001 18:15:57 -0500
Date: Wed, 31 Jan 2001 23:15:56 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: Bernd Eckenfels <ecki@lina.inka.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: reiserfs min size (was: [2.4.1] mkreiserfs on loopdevice freezes
 kernel)
In-Reply-To: <20010131232757.A23675@lina.inka.de>
Message-ID: <Pine.SOL.4.21.0101312315040.24868-100000@orange.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001, Bernd Eckenfels wrote:

> On Wed, Jan 31, 2001 at 09:24:39AM +0000, James Sutherland wrote:
> > 32 megaBLOCK?? How big is it in Mbytes?
> 
> Blocksize is 4k, mkreiserfs in my version is telling me it can not generate
> partitions smaller than 32M but it is not true, i have to do
> 
> dd if=/dev/zero of=/var/loop.img count=32768 size=4096

That just creates a 128Mb file of zeros... This sounds a bit small. Why
"size=4096"??

> > You do know reiserfs defaults to
> > building a 32 Mbyte journal on the device, I take it?
> 
> Yes, I wonder if it is a Error in mkreiserfs to require 128MB.

Have you tried using a smaller blocksize to mkreiserfs?


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
