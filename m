Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129392AbRBAKHr>; Thu, 1 Feb 2001 05:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130035AbRBAKHi>; Thu, 1 Feb 2001 05:07:38 -0500
Received: from cnxt10005.conexant.com ([198.62.10.5]:13831 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S129392AbRBAKHZ>; Thu, 1 Feb 2001 05:07:25 -0500
Date: Thu, 1 Feb 2001 11:06:44 +0100 (CET)
From: <rui.sousa@conexant.com>
To: "Timothy A. DeWees" <whtdrgn@mail.cannet.com>
cc: Lukasz Gogolewski <lucas@supremedesigns.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: problems with sblive as well as 3com 3c905
In-Reply-To: <003701c08bcc$19b8bae0$7930000a@hcd.net>
Message-ID: <Pine.LNX.4.30.0102011105560.1707-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001, Timothy A. DeWees wrote:

How about just upgrading modutils?!

> You need to create a symlink
>
> ln -s /lib/modules/2.4.1/kernel/drivers/net /lib/modules/2.4.1/net
>
> That will fix the nic, I am not sure about sound.  You may need to
> create a misc link like
>
> ln -s /lib/modules/2.4.1/kernel/drivers/misc /lib/modules/2.4.1/misc
>
>
> ----- Original Message -----
> From: "Lukasz Gogolewski" <lucas@supremedesigns.com>
> To: <linux-kernel@vger.kernel.org>
> Sent: Wednesday, January 31, 2001 4:03 PM
> Subject: problems with sblive as well as 3com 3c905
>
>
> > After I compiled kernel 2.4.1 on rh 6.2 I enabled module support for 2
> > of those devices.
> >
> > However when I rebooted my machine both of those devices are not
> > working.
> >
> > I don't know what's wrong since I did make moudle and make
> > module_install.
> >
> > When I try to configure mdoule for the sound card, I get a message
> > saying that module wasn't found.
> >
> > For the network card I get Delaying initialization
> >
> > any suggestions on how to fix it?
> >
> > - Lucas
> >

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
