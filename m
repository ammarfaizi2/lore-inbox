Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBGTHx>; Wed, 7 Feb 2001 14:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129047AbRBGTHY>; Wed, 7 Feb 2001 14:07:24 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:44292 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130026AbRBGTHF>; Wed, 7 Feb 2001 14:07:05 -0500
Date: Wed, 7 Feb 2001 13:02:16 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI-SCI Drivers v1.1-7 released
Message-ID: <20010207130216.B27700@vger.timpanogas.org>
In-Reply-To: <20010207111345.D27089@vger.timpanogas.org> <E14QZrI-00012X-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E14QZrI-00012X-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Feb 07, 2001 at 07:02:26PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Wed, Feb 07, 2001 at 07:02:26PM +0000, Alan Cox wrote:
> > Hummm.  Where are the patches for 2.4 to correct this?  They are not posted
> > with the 7.1 release.  They need to be.  The compiler not supporting 
> 
> They don't need to be because the thing is just a warning. The kernel has
> plenty of warnings and this one is 100% harmless.
> 
> > #ident for CVS is a show stopper, and needs correcting ASAP.  How can 
> > someone use CVS properly with this, Alan?
> 
> Im using CVS all the time. Im not sure what the #ident thing would be. But
> then like everyone else I know I use $ident in comments. JJ will probably
> be glad to work on that one


I sent him the code and he is running it down.  It works great on 
gcc 2.91.  

Jeff

> 
> Right now I'm down to one known problem with 2.96 and 2.4.x kernels - which
> is that CVS gcc and 2.96 accidentally changed the ABI and broke the bitfield
> assumptions in DAC960.c/h. JJ I believe just committed patches for that one
> 

:-)

Jeff

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
