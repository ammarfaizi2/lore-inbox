Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317330AbSFCJXD>; Mon, 3 Jun 2002 05:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317331AbSFCJXC>; Mon, 3 Jun 2002 05:23:02 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:48259 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317330AbSFCJW7>;
	Mon, 3 Jun 2002 05:22:59 -0400
Date: Mon, 3 Jun 2002 11:22:31 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Anthony Spinillo <tspinillo@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: INTEL 845G Chipset IDE Quandry
Message-ID: <20020603112231.B13204@ucw.cz>
In-Reply-To: <20020603010412.26640.qmail@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2002 at 09:04:12AM +0800, Anthony Spinillo wrote:

> I fired up 2519 as a test, same resource collision problem.

In that case, probably only a BIOS upgrade (if there is one available)
can help.

> 
> Tony
> 
> ----- Original Message -----
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Date: 	03 Jun 2002 02:13:45 +0100
> To: Vojtech Pavlik <vojtech@suse.cz>
> Subject: Re: INTEL 845G Chipset IDE Quandry
> 
> 
> > On Sun, 2002-06-02 at 22:30, Vojtech Pavlik wrote:
> > > On Sun, Jun 02, 2002 at 09:36:35PM +0200, Martin Dalecki wrote:
> > > > Anthony Spinillo wrote:
> > > > > Back to my original problem, will there be a fix before 2010? ;)
> > > > 
> > > > Well since you have already tyred yourself to poke at it.
> > > > Well please just go ahead and atd an entry to the table
> > > > at the end of piix.c which encompasses the device.
> > > > Do it by copying over the next familiar one and I would
> > > > be really geald if you could just test whatever this
> > > > worked. If yes well please send me just the patch and
> > > > I will include it.
> > > 
> > > Note it works with 2.5 already. We have the device there.
> > 
> > If you look at why it fails it fails not because it isnt in the table
> > but because the PCI device has not been allocated resources properly by
> > the BIOS
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> > 
> 
> -- 
> Get your free email from www.linuxmail.org 
> 
> 
> Powered by Outblaze
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs
