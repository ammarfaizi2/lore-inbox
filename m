Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129449AbQLDI4w>; Mon, 4 Dec 2000 03:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129464AbQLDI4m>; Mon, 4 Dec 2000 03:56:42 -0500
Received: from 4dyn165.delft.casema.net ([195.96.105.165]:36111 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S129449AbQLDI4X>; Mon, 4 Dec 2000 03:56:23 -0500
Message-Id: <200012040825.JAA08264@cave.bitwizard.nl>
Subject: Re: IDE_TAPE problem wiht ONSTREAM DI30
In-Reply-To: <Pine.LNX.4.10.10012032315100.13699-100000@master.linux-ide.org>
 from Andre Hedrick at "Dec 3, 2000 11:16:37 pm"
To: Andre Hedrick <andre@linux-ide.org>
Date: Mon, 4 Dec 2000 09:25:33 +0100 (MET)
CC: e.ckhard@u-code.de, marcel@mesa.nl, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> On Sun, 3 Dec 2000, Eckhard Jokisch wrote:
> 
> > Am Don, 30 Nov 2000 schrieben Sie:
> > > On Thu, Nov 30, 2000 at 04:26:09PM +0000, Eckhard Jokisch wrote:
> > > > 
> > > > I tried the ide-tape driver for several weeks now. And after some time during
> > > > writing or reading tar stops because of errors.
> > > > 
> > > > Error messages are:
> > > > Nov 30 15:32:20  kernel: ide-tape: ht0: I/O error, pc =  8, key =  0,
> > > > asc =  0, ascq =  2 Nov 30 15:32:25 eckhard last message repeated 1000 times
> > > > Nov 30 15:32:25  kernel: ide-tape: ht0: unrecovered read error on logical block number 461706, skipping
> 
> You have to love the new ARD media...
> 
> > ....
> > 
> > > I ran into such problems since februari or so and have been in contact with
> > > the ide-tape developers and Onstream about it. 

Stay away from onstream is my advice nowadays. 

We've been trying to get the stupid thing to work since july 8th, and
onstream technical support has been very helpful by telling us what to
do and such. Like downgrading to a kernel version that has known
remote attacks. However doing that does not solve the problems we
report. After much ado, they promise to "escalate" the problem to 
people in the states, and then this does not lead to results in 
the month we've given them. 

In short: in the simplest case, just writing a stream of bytes to the
drive, it works. But the drive then doesn't nearly have the "raw error
rate" that they claim.

If you start using a backup program that needs to seek back and forth
a few times, the drive loses track where it is, and doesn't recover
from this situation.

I've returned mine to my vendor, and I hope that Onstream gets the
message in the end: They do NOT support Linux. 

			Roger.

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
