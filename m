Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317373AbSFLXub>; Wed, 12 Jun 2002 19:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317374AbSFLXua>; Wed, 12 Jun 2002 19:50:30 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:5119 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S317373AbSFLXua>;
	Wed, 12 Jun 2002 19:50:30 -0400
Date: Wed, 12 Jun 2002 16:50:30 -0700
To: Greg KH <greg@kroah.com>
Cc: jt@hpl.hp.com, Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Re : ANN: Linux 2.2 driver compatibility toolkit
Message-ID: <20020612165030.A24311@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20020610174050.A21783@bougret.hpl.hp.com> <3D07D022.5030106@mandrakesoft.com> <20020612162714.A24255@bougret.hpl.hp.com> <20020612233955.GC17306@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2002 at 04:39:55PM -0700, Greg KH wrote:
> On Wed, Jun 12, 2002 at 04:27:14PM -0700, Jean Tourrilhes wrote:
> > 	For me, the problem between 2.5.X and 2.4.X is the USB API
> > which has significantely changed (urb_submit anyone ?). I end up
> > having two quite different version of irda-usb to maintain. But
> > probably USB in 2.5.X. is too much a moving target for you to include
> > in your package.
> 
> Heh, this is the first complaint I've had about this, which is quite
> surprising :)

	I guess you are the one doing most of the work in 2.5.X, and
most outside drivers are only targetting 2.4.X.

> I'll be putting most of the 2.5 USB api changes into 2.4 once
> 2.4.19-final comes out,

	Don't rush, I'm not sure if you are done with USB
changes. When the new HCD stuff will be in, I'm sure you will find
something else to tinker with.

> so then you can go back to having 1 version of
> your driver (if you like that kind of thing, personally I don't.)

	If my driver was static, I would not care. But because I need
to fix and update it, the patching and testing work is multiplied by
two.
	Bah, I'm not really complaining. I was just thinking that it
would be a nice feature, but I can live without it.

> thanks,
> 
> greg k-h

	Have fun...

	Jean
