Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130198AbRCESgW>; Mon, 5 Mar 2001 13:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130200AbRCESgM>; Mon, 5 Mar 2001 13:36:12 -0500
Received: from chaos.analogic.com ([204.178.40.224]:2176 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S130198AbRCESgE>; Mon, 5 Mar 2001 13:36:04 -0500
Date: Mon, 5 Mar 2001 13:35:32 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Mike Galbraith <mikeg@wen-online.de>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Loop stuck in -D state
In-Reply-To: <Pine.LNX.4.33.0103051901580.558-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.3.95.1010305133108.884B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Mar 2001, Mike Galbraith wrote:

> On Mon, 5 Mar 2001, Mike Galbraith wrote:
> 
> > On Mon, 5 Mar 2001, Richard B. Johnson wrote:
> >
> > > I tried Linux 2.4.2
> > > Now I'm in a load of trouble. I can't make a boot-disk to get back
> > > to 2.4.1 because I use initrd for my hard disk modules and the loop
> > > device is broken.
> >
> > What's wrong with 2.4.2 that makes you want to go back?  Anyway, if
> > you grab Jens' patch, all will be peachy (at least for that kind of
> > basic usage).
> 
> P.S.
> Are you saying that the initrd is broken again as well?  (having
> trouble understanding the problem.. don't see why you need the
> loop device or rather how its being busted is connected to your
> [interpolation] difficulty in creating a new initrd)
> 
> 	-EAGAIN ;-)
> 

The initial RAM disk image is created using the loop device. You
can create a RAM disk image for initrd by using the ram device.
However, that doesn't work once the system has been booted off
it (try it, be ready for a complete hang).

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


