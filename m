Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317236AbSFCAI5>; Sun, 2 Jun 2002 20:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317238AbSFCAI5>; Sun, 2 Jun 2002 20:08:57 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:52733 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317236AbSFCAI4>; Sun, 2 Jun 2002 20:08:56 -0400
Subject: Re: INTEL 845G Chipset IDE Quandry
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Anthony Spinillo <tspinillo@linuxmail.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020602233043.A11698@ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 03 Jun 2002 02:13:45 +0100
Message-Id: <1023066825.3439.58.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-06-02 at 22:30, Vojtech Pavlik wrote:
> On Sun, Jun 02, 2002 at 09:36:35PM +0200, Martin Dalecki wrote:
> > Anthony Spinillo wrote:
> > > Back to my original problem, will there be a fix before 2010? ;)
> > 
> > Well since you have already tyred yourself to poke at it.
> > Well please just go ahead and atd an entry to the table
> > at the end of piix.c which encompasses the device.
> > Do it by copying over the next familiar one and I would
> > be really geald if you could just test whatever this
> > worked. If yes well please send me just the patch and
> > I will include it.
> 
> Note it works with 2.5 already. We have the device there.

If you look at why it fails it fails not because it isnt in the table
but because the PCI device has not been allocated resources properly by
the BIOS

