Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266924AbTADN6W>; Sat, 4 Jan 2003 08:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266927AbTADN6W>; Sat, 4 Jan 2003 08:58:22 -0500
Received: from 205-158-62-146.outblaze.com ([205.158.62.146]:35764 "HELO
	wspf1.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S266924AbTADN6V>; Sat, 4 Jan 2003 08:58:21 -0500
Message-ID: <20030104140643.19228.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: kasperd@daimi.au.dk, ciarrocchi@linuxmail.org
Cc: linux-kernel@vger.kernel.org
Date: Sat, 04 Jan 2003 22:06:43 +0800
Subject: Re: Linux v2.5.54
X-Originating-Ip: 62.10.40.78
X-Originating-Server: ws5-3.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kasper Dupont <kasperd@daimi.au.dk>
> Paolo Ciarrocchi wrote:
> > 
> > From: Kasper Dupont <kasperd@daimi.au.dk>
> > [...]
> > > > arch/i386/kernel/vm86.c:289: structure has no member named `saved_gs'
> > > > make[1]: *** [arch/i386/kernel/vm86.o] Error 1
> > > > make: *** [arch/i386/kernel] Error 2
> > >
> > > Doesn't happen to me. Maybe I can reproduce it if I get a copy of
> > > your .config file. And BTW, which gcc version are you using?
> > 
> > [root@frodo linux-2.5.53]# gcc -v
> > Reading specs from /usr/lib/gcc-lib/i586-mandrake-linux-gnu/3.2/specs
> > Configured with: ../configure --prefix=/usr --libdir=/usr/lib --with-slibdir=/lib --mandir=/usr/share/man --infodir=/usr/share/info --enable-shared --enable-threads=posix --disable-checking --enable-long-long --enable-__cxa_atexit --enable-languages=c,c++,ada,f77,objc,java --host=i586-mandrake-linux-gnu --with-system-zlib
> > Thread model: posix
> > gcc version 3.2 (Mandrake Linux 9.0 3.2-1mdk)
> 
> I'm using a different compiler version. That might be related to
> the problem:
> 
> [kasperd:pts/0:/mnt/misc/kasperd/test/linux-2.5.54] gcc -v
> Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
> gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)
> [kasperd:pts/0:/mnt/misc/kasperd/test/linux-2.5.54] 
> 
> > 
> > And here it goes my .config.
> 
> The FB_I810 option was missing, but if I just set that one to no
> I could compile without problems using your .config file.
> 
> How many versions do you have to go backwards to find a kernel
> you can compile?

Just one :-) 2.5.53 is happily running on my laptop.
I think I've compiled and booted all the kernel version 
since 2.5.3something.

Ciao,
       Paolo

-- 
______________________________________________
http://www.linuxmail.org/
Now with POP3/IMAP access for only US$19.95/yr

Powered by Outblaze
