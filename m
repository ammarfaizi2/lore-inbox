Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266204AbSKFWxI>; Wed, 6 Nov 2002 17:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266205AbSKFWxH>; Wed, 6 Nov 2002 17:53:07 -0500
Received: from pasky.ji.cz ([62.44.12.54]:14078 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S266204AbSKFWxD>;
	Wed, 6 Nov 2002 17:53:03 -0500
Date: Wed, 6 Nov 2002 23:59:40 +0100
From: Petr Baudis <pasky@ucw.cz>
To: "Sartorelli, Kevin" <Kevin.Sartorelli@openpolytechnic.ac.nz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: setup.S unterminated #ifndef and gcc 3.3
Message-ID: <20021106225940.GG5219@pasky.ji.cz>
Mail-Followup-To: "Sartorelli, Kevin" <Kevin.Sartorelli@openpolytechnic.ac.nz>,
	linux-kernel@vger.kernel.org
References: <4B2093FFC31B7A45862B62A376EA717601DDF7D2@mickey.topnz.ac.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B2093FFC31B7A45862B62A376EA717601DDF7D2@mickey.topnz.ac.nz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Wed, Nov 06, 2002 at 10:43:12PM CET, I got a letter,
where "Sartorelli, Kevin" <Kevin.Sartorelli@openpolytechnic.ac.nz> told me, that...
> Is anyone else trying to use gcc 3.3 to compile the later kernels?  I'm using gcc 3.3 to try to compile 2.5.46 and get:
> 
> 	arch/i386/boot/setup.S:298 unterminated #ifndef
> 	make[1]: *** [arch/i386/boot/setup.o] Error 1
> 	make: *** [bzImage] Error 2
> 
> I haven't seen anything on the list about this so am assuming that I'm either alone in trying this, or there is something not quite right with my configuration.
> 
> Any thoughts anyone (I know the one about using gcc 2.95.3 ;- ) )

Looks as a bug in gcc 3.3 preprocessor to me, or I have hallucinations when
staring at the #endif at line 391.

-- 
 
				Petr "Pasky" Baudis
.
This host is a black hole at HTTP wavelengths. GETs go in, and nothing
comes out, not even Hawking radiation.
                -- Graaagh the Mighty on rec.games.roguelike.angband
.
Public PGP key && geekcode && homepage: http://pasky.ji.cz/~pasky/
