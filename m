Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263395AbRFGGw7>; Thu, 7 Jun 2001 02:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263990AbRFGGwt>; Thu, 7 Jun 2001 02:52:49 -0400
Received: from olsinka.site.cas.cz ([147.231.11.16]:54400 "EHLO
	twilight.suse.cz") by vger.kernel.org with ESMTP id <S263395AbRFGGw3>;
	Thu, 7 Jun 2001 02:52:29 -0400
Date: Thu, 7 Jun 2001 08:25:41 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Russell King <rmk@arm.linux.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tytso@mit.edu,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [driver] New life for Serial mice
Message-ID: <20010607082541.A166@suse.cz>
In-Reply-To: <20010606220832.A31009@flint.arm.linux.org.uk> <Pine.LNX.4.10.10106061527580.12135-100000@transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10106061527580.12135-100000@transvirtual.com>; from jsimmons@transvirtual.com on Wed, Jun 06, 2001 at 03:39:04PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2001 at 03:39:04PM -0700, James Simmons wrote:

> > > It would be nice if we had 
> > > 
> > > 1) A seperate serial directory under drivers.
> > > 
> > > 2) A nice structure that input devices and the tty layer can use. It is
> > >    just a waste to go threw the tty layer for input devices. It would also
> > >    make serial driver writing easier if the api is designed right :-) 
> > 
> > I am planning some day (don't know when yet though) to convert the 16x50
> > driver over to the serial_core stuff.
> 
> I ported it over to my tree. I will have to figure out how to incorporate
> the input serial stuff without breaking all the input drivers we have. In
> CVS we have alot of them. This will make life so much easier since all I
> will have to do is change one file for changes I make to the tty layer. I
> have improved andrew mortons console patch to work with multiple consoles
> and for different types of console devices. Instead of altering all the 
> console drivers I'm planning on intergrating the locking into the tty
> layer. That patch is needed for serial devices as well as video terminals.
> Your work might help speed up devleopement.

Sounds cute. Where do I find the result of your work?

> > NB, Ted Tytso mentioned something at the 2.5 conference about integrating
> > some of the serial layer with the tty layer.
> 
> What does he have in mind? I like to keep my VT changes in sync with what
> he has in mind.

-- 
Vojtech Pavlik
SuSE Labs
