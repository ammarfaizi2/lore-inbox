Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129170AbQKHPdj>; Wed, 8 Nov 2000 10:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129209AbQKHPd3>; Wed, 8 Nov 2000 10:33:29 -0500
Received: from carbon.btinternet.com ([194.73.73.92]:52188 "EHLO
	carbon.btinternet.com") by vger.kernel.org with ESMTP
	id <S129170AbQKHPdS>; Wed, 8 Nov 2000 10:33:18 -0500
From: davej@suse.de
Date: Wed, 8 Nov 2000 15:10:17 +0000 (GMT)
To: Bruce_Holzrichter@infinium.com
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Installing kernel 2.4
In-Reply-To: <OFE1DF3190.2EF12079-ON85256991.004BD0EB@infinium.com>
Message-ID: <Pine.LNX.4.21.0011081508580.10475-100000@neo.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2000 Bruce_Holzrichter@infinium.com wrote:

> > On Wed, Nov 08, 2000 at 03:25:56AM +0000, davej@suse.de wrote:
> > > On Tue, 7 Nov 2000, Jeff V. Merkey wrote:
> > > > If the compiler always aligned all functions and data on 16 byte
> > > > boundries (NetWare)  for all i386 code, it would run a lot faster.
> > >
> > > Except on architectures where 16 byte alignment isn't optimal.
> > >
> > > > Cache line alignment could be an option in the loader .... after all,
> > > > it's hte loader that locates data in memory.  If Linux were PE based,
> > > > relocation logic would be a snap with this model (like NT).
> > >
> > > Are you suggesting multiple files of differing alignments packed into
> > > a single kernel image, and have the loader select the correct one at
> > > runtime ? I really hope I've misinterpreted your intention.
> >
> > Or more practically, a smart loader than could select a kernel image
> > based on arch and auto-detect to load the correct image. I don't really
> > think it matters much what mechanism is used.
> >
> > What makes more sense is to pack multiple segments for different
> > processor architecures into a single executable package, and have the
> > loader pick the right one (the NT model).  It could be used for
> > SMP and non-SMP images, though, as well as i386, i586, i686, etc.

> And this would fit on my 1.4bm floppy so I can boot my hard driveless
> firewalling system, correct?

Your mailer is misattributing people. I didn't say that, my comments were
the ones you've attributed to Jeff.

regards,

davej.

-- 
| Dave Jones <davej@suse.de>  http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
