Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317385AbSFMAgU>; Wed, 12 Jun 2002 20:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317386AbSFMAgT>; Wed, 12 Jun 2002 20:36:19 -0400
Received: from quattro-eth.sventech.com ([205.252.89.20]:21002 "EHLO
	quattro.sventech.com") by vger.kernel.org with ESMTP
	id <S317385AbSFMAgT>; Wed, 12 Jun 2002 20:36:19 -0400
Date: Wed, 12 Jun 2002 20:36:20 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Greg KH <greg@kroah.com>
Cc: jt@hpl.hp.com, Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: Re : ANN: Linux 2.2 driver compatibility toolkit
Message-ID: <20020612203620.K16859@sventech.com>
In-Reply-To: <20020610174050.A21783@bougret.hpl.hp.com> <3D07D022.5030106@mandrakesoft.com> <20020612162714.A24255@bougret.hpl.hp.com> <20020612233955.GC17306@kroah.com> <20020612165030.A24311@bougret.hpl.hp.com> <20020612235747.GD17306@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2002, Greg KH <greg@kroah.com> wrote:
> On Wed, Jun 12, 2002 at 04:50:30PM -0700, Jean Tourrilhes wrote:
> > 	Don't rush, I'm not sure if you are done with USB
> > changes. When the new HCD stuff will be in, I'm sure you will find
> > something else to tinker with.
> 
> Heh, I _know_ I'm not done with USB changes :)
> I'll just be backporting the ones that are now stable, and have been in
> the tree for a long time.  I'll not be backporting all of the new HCD
> drivers for one.
> 
> Here's what I think I'll change in 2.4.20 that is now in the 2.5 tree:
> 	- update the USB documentation
> 	- remove the horrible typedefs in usb.h
> 	- change usb_submit_urb and usb_alloc_urb apis

Do you think it's a good idea to change the API in a stable kernel
series?

> 	- add new drivers
> 	- backport the usb-serial api and locking changes
> 
> And that will probably be enough for 2.4.20.  In the meantime, the USB
> changes in 2.5 will continue on, giving us more fodder to backport in
> 2.4.21, not to mention 2.2.22 :)

The rest sound good to me.

JE

