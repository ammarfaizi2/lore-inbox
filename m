Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317315AbSFCIoL>; Mon, 3 Jun 2002 04:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317316AbSFCIoK>; Mon, 3 Jun 2002 04:44:10 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:44930 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317315AbSFCIoJ>;
	Mon, 3 Jun 2002 04:44:09 -0400
Date: Mon, 3 Jun 2002 10:43:38 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Anthony Spinillo <tspinillo@linuxmail.org>,
        linux-kernel@vger.kernel.org
Subject: Re: INTEL 845G Chipset IDE Quandry
Message-ID: <20020603104338.A13158@ucw.cz>
In-Reply-To: <20020602101628.4230.qmail@linuxmail.org> <3CFA73C3.9010902@evision-ventures.com> <20020602233043.A11698@ucw.cz> <1023066825.3439.58.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2002 at 02:13:45AM +0100, Alan Cox wrote:
> On Sun, 2002-06-02 at 22:30, Vojtech Pavlik wrote:
> > On Sun, Jun 02, 2002 at 09:36:35PM +0200, Martin Dalecki wrote:
> > > Anthony Spinillo wrote:
> > > > Back to my original problem, will there be a fix before 2010? ;)
> > > 
> > > Well since you have already tyred yourself to poke at it.
> > > Well please just go ahead and atd an entry to the table
> > > at the end of piix.c which encompasses the device.
> > > Do it by copying over the next familiar one and I would
> > > be really geald if you could just test whatever this
> > > worked. If yes well please send me just the patch and
> > > I will include it.
> > 
> > Note it works with 2.5 already. We have the device there.
> 
> If you look at why it fails it fails not because it isnt in the table
> but because the PCI device has not been allocated resources properly by
> the BIOS

That's right. Well, maybe kernel 2.5 PCI code can fix that better? Maybe
not, and in that case a BIOS upgrade is probably the way to go.

-- 
Vojtech Pavlik
SuSE Labs
