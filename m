Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266128AbSKOL3b>; Fri, 15 Nov 2002 06:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266153AbSKOL3b>; Fri, 15 Nov 2002 06:29:31 -0500
Received: from [195.39.17.254] ([195.39.17.254]:8964 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S266128AbSKOL33>;
	Fri, 15 Nov 2002 06:29:29 -0500
Date: Tue, 12 Nov 2002 20:44:11 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Sartorelli, Kevin" <Kevin.Sartorelli@openpolytechnic.ac.nz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: setup.S unterminated #ifndef and gcc 3.3
Message-ID: <20021112194400.GB861@zaurus>
References: <4B2093FFC31B7A45862B62A376EA717601DDF7D2@mickey.topnz.ac.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B2093FFC31B7A45862B62A376EA717601DDF7D2@mickey.topnz.ac.nz>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Is anyone else trying to use gcc 3.3 to compile the later kernels?  I'm using gcc 3.3 to try to compile 2.5.46 and get:
> 
> 	arch/i386/boot/setup.S:298 unterminated #ifndef
> 	make[1]: *** [arch/i386/boot/setup.o] Error 1
> 	make: *** [bzImage] Error 2
> 
> I haven't seen anything on the list about this so am assuming that I'm either alone in trying this, or there is something not quite right with my configuration.

I've seen it on x86-64, and worked around it
(done preprocessing by hand :-)
				Pavel
-- 
				Pavel
My velo broke, so I got Zaurus. If you have Philips Velo 1 you don't need...
