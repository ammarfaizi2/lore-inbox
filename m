Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129715AbQKHSUW>; Wed, 8 Nov 2000 13:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129718AbQKHSUM>; Wed, 8 Nov 2000 13:20:12 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:23561 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129715AbQKHSUA>; Wed, 8 Nov 2000 13:20:00 -0500
Date: Wed, 8 Nov 2000 12:16:20 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Bruce_Holzrichter@infinium.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Installing kernel 2.4
Message-ID: <20001108121620.B11377@vger.timpanogas.org>
In-Reply-To: <OFE1DF3190.2EF12079-ON85256991.004BD0EB@infinium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <OFE1DF3190.2EF12079-ON85256991.004BD0EB@infinium.com>; from Bruce_Holzrichter@infinium.com on Wed, Nov 08, 2000 at 08:49:15AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2000 at 08:49:15AM -0500, Bruce_Holzrichter@infinium.com wrote:
> 
> >
> > On Wed, Nov 08, 2000 at 03:25:56AM +0000, davej@suse.de wrote:
> > > On Tue, 7 Nov 2000, Jeff V. Merkey wrote:
> > >
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
> 
> 
> And this would fit on my 1.4bm floppy so I can boot my hard driveless
> firewalling system, correct?

Hard disks (20GB) are about $100.00 these days.  CD-ROM drives are even 
cheaper.  A smart loader will certainly fit on a floppy.

Jeff

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
