Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261217AbRFFUWA>; Wed, 6 Jun 2001 16:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264140AbRFFUVt>; Wed, 6 Jun 2001 16:21:49 -0400
Received: from www.transvirtual.com ([206.14.214.140]:59659 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S264138AbRFFUVh>; Wed, 6 Jun 2001 16:21:37 -0400
Date: Wed, 6 Jun 2001 13:20:53 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: Vojtech Pavlik <vojtech@suse.cz>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        linux-kernel@vger.kernel.org, tytso@mit.edu
Subject: Re: [driver] New life for Serial mice
In-Reply-To: <20010606182221.B30546@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10106061317180.12135-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > hmmm.  I just looked over this, and drivers/char/joystick/ser*.[ch].
> > > 
> > > Bad trend.
> > > 
> > > Serial needs to be treated just like parport: the basic hardware code,
> > > then on top of that, a selection of drivers, all peers:  dumb serial
> > > port, serial mouse, joystick, etc.
> > 
> > Agreed. Completely.
> 
> I suggest that if someone is thinking about this that they look at
> serial_core.c in the ARM patch hunk.
>    (ftp.arm.linux.org.uk/pub/armlinux/source/kernel-patches/v2.4/)
> 
> Note that you shouldn't apply the whole patch - it probably won't compile
> for anything but ARM atm.

Never noticed it until now. Very nice patch :-) I have to agree as well.
It would be nice if we had 

1) A seperate serial directory under drivers.

2) A nice structure that input devices and the tty layer can use. It is
   just a waste to go threw the tty layer for input devices. It would also
   make serial driver writing easier if the api is designed right :-) 


