Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264380AbRFNBXT>; Wed, 13 Jun 2001 21:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264377AbRFNBXI>; Wed, 13 Jun 2001 21:23:08 -0400
Received: from adsl-64-175-255-50.dsl.sntc01.pacbell.net ([64.175.255.50]:29570
	"HELO kobayashi.soze.net") by vger.kernel.org with SMTP
	id <S264383AbRFNBXB>; Wed, 13 Jun 2001 21:23:01 -0400
Date: Wed, 13 Jun 2001 18:23:58 -0700 (PDT)
From: Justin Guyett <justin@soze.net>
X-X-Sender: <tyme@gw.soze.net>
To: Daniel <ddickman@nyc.rr.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: obsolete code must die
In-Reply-To: <01a401c0f46b$20b932e0$480e6c42@almlba4sy7xn6x>
Message-ID: <Pine.LNX.4.33.0106131805390.19397-100000@gw.soze.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2001, Daniel wrote:

> math-emu
> If support for i386 and i486 is going away, then so should math emulation.
> Every intel processor since the 486DX has an FPU unit built in. In fact
> shouldn't FPU support be a userspace responsibility anyway?

hmm... what about processors like cris?  The big brother of the processor
in the cute net-enabled-webcam by axis?  AFAIK it doesn't have an fpu, and
people put a lot of work into getting support for it into 2.4.

> ISA, MCA, EISA device drivers
> If support for the buses is gone, there's no point in supporting devices for
> these buses.

Fine, but can you leave in support for my PAS16?

> all code marked as CONFIG_OBSOLETE
> Since we're cleaning house we may as well get rid of this stuff.

No real problem there...

> parallel/serial/game ports
> More controversial to remove this, since they are *still* in pretty wide
> use -- but USB and IEEE 1394 are the way to go. No ifs ands or buts.

Wow, thanks for leaving me with no way to console into my netra.
Incidentally, (As if anyone appropriate is actually READING this thread),
can people who make distributions PLEASE not assume there are 3 or 4
serial ports?  I tried installing debian-sparc on my netra and init
warnings about being unable to open the 3rd serial port make menus
unreadable.

> I really think doing a clean up is worthwhile. Maybe while looking for stuff
> to clean up we'll even be able to better comment the existing code. Any
> other features people would like to get rid of? Any comments or suggestions?
> I'd love to start a good discussion about this going so please send me your
> 2 cents.

Yeah, can we please get rid of ext2?  I mean, everyone's using reiserfs
now, right?  And what about making SMP mandatory?  I mean, who only has
*ONE* processor in a machine in 2001?  And ide and scsi support... ram is
so cheap now who needs disk?  get rid of everything except ramdisk.  tape
drives?  cd burners?  obsolete.  Plus the RIAA doesn't want cd burners
anyway.  Maybe you can get funding for 2.6 kernel development from them
with this plan!


Justin

