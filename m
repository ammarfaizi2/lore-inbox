Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266918AbSKOXGQ>; Fri, 15 Nov 2002 18:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266927AbSKOXGP>; Fri, 15 Nov 2002 18:06:15 -0500
Received: from 213-152-55-49.dsl.eclipse.net.uk ([213.152.55.49]:48868 "EHLO
	monkey.daikokuya.co.uk") by vger.kernel.org with ESMTP
	id <S266918AbSKOXGP>; Fri, 15 Nov 2002 18:06:15 -0500
Date: Fri, 15 Nov 2002 23:12:58 +0000
From: Neil Booth <neil@daikokuya.co.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Sartorelli, Kevin" <Kevin.Sartorelli@openpolytechnic.ac.nz>,
       linux-kernel@vger.kernel.org
Subject: Re: setup.S unterminated #ifndef and gcc 3.3
Message-ID: <20021115231258.GA27217@daikokuya.co.uk>
References: <4B2093FFC31B7A45862B62A376EA717601DDF7D2@mickey.topnz.ac.nz> <20021112194400.GB861@zaurus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021112194400.GB861@zaurus>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:-

> 
> > Is anyone else trying to use gcc 3.3 to compile the later kernels?  I'm using gcc 3.3 to try to compile 2.5.46 and get:
> > 
> > 	arch/i386/boot/setup.S:298 unterminated #ifndef
> > 	make[1]: *** [arch/i386/boot/setup.o] Error 1
> > 	make: *** [bzImage] Error 2
> > 
> > I haven't seen anything on the list about this so am assuming that I'm either alone in trying this, or there is something not quite right with my configuration.
> 
> I've seen it on x86-64, and worked around it
> (done preprocessing by hand :-)

Fixed in recent CVS.

Neil.
