Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964900AbVHOSz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbVHOSz4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 14:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbVHOSz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 14:55:56 -0400
Received: from mail.kroah.org ([69.55.234.183]:21381 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964900AbVHOSzz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 14:55:55 -0400
Date: Mon, 15 Aug 2005 11:55:38 -0700
From: Greg KH <greg@kroah.com>
To: Stephane Wirtel <stephane.wirtel@belgacom.net>
Cc: Nish Aravamudan <nish.aravamudan@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [USB-Storage : i386] Oops with an adaptor for laptop hard disk.
Message-ID: <20050815185538.GA15137@kroah.com>
References: <20050815102925.GA843@localhost.localdomain> <20050815110836.GA16201@mipter.zuzino.mipt.ru> <20050815112122.GB6451@localhost.localdomain> <20050815162437.GA10114@kroah.com> <20050815182947.GA6286@localhost.localdomain> <29495f1d05081511374d1f2fc7@mail.gmail.com> <20050815184306.GB6286@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050815184306.GB6286@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2005 at 08:43:06PM +0200, Stephane Wirtel wrote:
> Le Monday 15 August 2005 a 11:08, Nish Aravamudan ecrivait: 
> > On 8/15/05, Stephane Wirtel <stephane.wirtel@belgacom.net> wrote:
> > > Le Monday 15 August 2005 a 09:08, Greg KH ecrivait:
> > > > On Mon, Aug 15, 2005 at 01:21:22PM +0200, Stephane Wirtel wrote:
> > > > > Le Monday 15 August 2005 a 15:08, Alexey Dobriyan ecrivait:
> > > > > > On Mon, Aug 15, 2005 at 12:29:25PM +0200, Stephane Wirtel wrote:
> > > > > > > With a laptop hard disk adaptop to usb, I do a modprobe with the
> > > > > > > usb-storage module. If I disconnect my hard disk, I get an oops.
> > > > > >
> > > > > > > nvidia 3711688 14 - Live 0xe10f1000
> > > > > >
> > > > > > > EIP:    0060:[<c019710b>]    Tainted: P      VLI
> > > > > >
> > > > > > Is it reproducable without nvidia module loaded?
> > > > > Yes :(
> > > >
> > > > Can you do so with 2.6.13-rc6 and without the nvidia module?  If so,
> > > > please let us know.
> > > I try to patch a 2.6.12.4 with the 2.6.13-rc6 prepatch, but I get some
> > > Hunks
> > 
> > That's because 2.6.13-rc6 is based off of 2.6.12.
> I download the kernel-2.6.13-rc6's archive from ftp://ftp.kernel.org/.../testing/

No, Nish means to apply that patch to a clean 2.6.12 tree, not 2.6.12.4.

thanks,

greg k-h
