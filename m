Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268002AbRGVRWW>; Sun, 22 Jul 2001 13:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268005AbRGVRWM>; Sun, 22 Jul 2001 13:22:12 -0400
Received: from femail21.sdc1.sfba.home.com ([24.0.95.146]:18572 "EHLO
	femail21.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S268002AbRGVRWG>; Sun, 22 Jul 2001 13:22:06 -0400
Message-ID: <3B5B088A.8C48D55D@home.com>
Date: Sun, 22 Jul 2001 12:08:26 -0500
From: Steven Lass <stevenlass1@home.com>
X-Mailer: Mozilla 4.77 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Rob Turk <r.turk@chello.nl>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.[<=6] kernel has Cyrix 'coma' bug?
In-Reply-To: <032701c112bb$170c2220$0101a8c0@aster>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Rob,

My CPU is a bit different than yours (sorry for not posting this with
the original message).

[root /root]# cat /proc/cpuinfo
processor       : 0
vendor_id       : CyrixInstead
cpu family      : 4
model           : 1
model name      : MediaGX 3x Core/Bus Clock
stepping        : 2
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : -1
wp              : yes
flags           :
bogomips        : 59.59

I posted my .config file if anyone is interested.  MTRR is not set.
http://members.home.net/stevenlass1/.config.txt

-steve

> ----- Original Message -----
> From: "Rob Turk" <r.turk@chello.nl>
> Newsgroups: lists.linux.kernel
> Sent: Sunday, July 22, 2001 4:23 PM
> Subject: Re: 2.4.[<=6] kernel has Cyrix 'coma' bug?
> 
> > "Steven Lass" <stevenlass1@home.com> wrote in message
> > news:cistron.3B5AD0DF.8DDC5D1E@home.com...
> > >
> > > dev-list,
> > >
> > > Every 2.4 kernel that I've tried freezes my Cyrix MediaGX system at boot
> > > up.
> > >
> >
> > For what it's worth, I use the Slackware 8.0 distribution, and have no
> > trouble running 2.4.[5-7] on my Cyrix MediaGX 233 MHz. Make sure MTTR is
> off
> > in your configuration, this has bit me in the *ss once...
> >
> > Rob
> >
> > ======
> > CPU: Before vendor init, caps: 00808131 01818131 00000000, vendor = 1
> > Working around Cyrix MediaGX virtual DMA bugs.
> > CPU: After vendor init, caps: 00808121 00818131 00000000 00000001
> > CPU:     After generic, caps: 00808121 00818131 00000000 00000001
> > CPU:             Common caps: 00808121 00818131 00000000 00000001
> > CPU: Cyrix MediaGXtm MMXtm Enhanced stepping 02
> > Checking 'hlt' instruction... OK.
> > POSIX conformance testing by UNIFIX
> > =======
> > robtu@pi8nos:/proc$ cat cpuinfo
> > processor       : 0
> > vendor_id       : CyrixInstead
> > cpu family      : 5
> > model           : 7
> > model name      : Cyrix MediaGXtm MMXtm Enhanced
> > stepping        : 2
> > cache size      : 16 KB
> > fdiv_bug        : no
> > hlt_bug         : no
> > f00f_bug        : no
> > coma_bug        : no
> > fpu             : yes
> > fpu_exception   : yes
> > cpuid level     : 2
> > wp              : yes
> > flags           : fpu msr cx8 cmov mmx cxmmx
> > bogomips        : 76.80
> >

