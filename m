Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129567AbRB0EjQ>; Mon, 26 Feb 2001 23:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129568AbRB0EjG>; Mon, 26 Feb 2001 23:39:06 -0500
Received: from mail09.voicenet.com ([207.103.0.35]:17116 "HELO
	mail09.voicenet.com") by vger.kernel.org with SMTP
	id <S129567AbRB0Ei7>; Mon, 26 Feb 2001 23:38:59 -0500
Message-ID: <3A9B2F54.79A7EE0D@voicenet.com>
Date: Mon, 26 Feb 2001 23:38:44 -0500
From: safemode <safemode@voicenet.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Everything working fine here. 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As a departure from just about every other post talking about something
wrong.  I just want to say 2.2.19pre14 is working perfectly.  I can't
say anything about latency because i haven't found much in the area of
timing patches for 2.2.19 yet, it is very responsive and fast and
handles quite well under load.  I haven't had one single kernel oops or
crash and no zombie processes.  I have not had X lock up the kernel or
needed to use sysreq.  I have not seen any corruption and the memory
management seems to be working well since loading netscape and the gimp
is almost instant.  X works with dri and my hdd's can work in DMA mode
without worrying about irq reset loops or dma timeouts with the cdrom.
 I even compiled the kernel and all the modules and user level apps for
those drivers with athlon gcc 0.0.2 and everything still runs perfect
with a little kick in responsiveness.  I must say i'm happy with this
kernel and for the first time in using all those devel kernels and
release 2.4.x's i can use the latest programs like X 4.x fully and not
have to worry about when they'll fix that nasty bug that causes the
kernel to crash or to let me use some other part of my system without
having it corrupt data .    Good job alan.


just to let you know what i'm using that works really well
    gcc version pgcc-2.95.3 19991024 (AthlonGCC-0.0.2)
    XFree86 Version 4.0.99.1 / X Window System
        (protocol Version 11, revision 0, vendor release 6510)
    libc 2.2.2
    Advanced Linux Sound Architecture Driver Version 0.5.10b
    bttv 0.7.57

    all running on an Abit KA7 Via KT133a motherboard with VIA686a ide
controller.
    with ATA66 hdd's.
    Voodoo3 agp
    SB live value
    3c509 isa 10baseT
    and Hauppauge wintv with stereo and fm tuner (with remote which
works in linux) Bt878 chipset

        Thanks again guys anyone who may be looking for a 100% (minus
the annoying power management part)  working new athlon system ...  here
it is.   And this is not to say that 2.4.x doesn't work good either but
in my experience cvs versions of X plus 2.4.x equaled a 100% certainty
of a lockup when using GL or xv in hardware accel ... and that just
hasn't happened with 2.2.19.

