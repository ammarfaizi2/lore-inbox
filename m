Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264460AbTDPQ1T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 12:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264463AbTDPQ1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 12:27:19 -0400
Received: from h002.c000.snv.cp.net ([209.228.32.66]:5823 "HELO
	c000.snv.cp.net") by vger.kernel.org with SMTP id S264460AbTDPQ1Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 12:27:16 -0400
X-Sent: 16 Apr 2003 16:39:09 GMT
Message-ID: <003501c30436$b06b8f50$6901a8c0@athialsinp4oc1>
From: "Brien" <admin@brien.com>
To: <linux-kernel@vger.kernel.org>
References: <200304161511.h3GFBoe7000614@81-2-122-30.bradfords.org.uk> <003801c3042e$a6bcbea0$6901a8c0@athialsinp4oc1> <1050506129.28586.121.camel@dhcp22.swansea.linux.org.uk>
Subject: Re: my dual channel DDR 400 RAM won't work on any linux distro
Date: Wed, 16 Apr 2003 12:38:58 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The board supports up to 4 GB total (4 DIMM slots), DDR 400/333/266. I'm
normally using 2 * 512 MB DDR 400 on Single 128 bit mode. And the board's
been tested to support up to 4 of the modules that I have (
KVR400X64C25/512 ) shown at :
http://www.giga-byte.com/MotherBoard/Support/TechnologyGuide/TechnologyGuide
_63.htm

motherboard link:
http://www.giga-byte.com/MotherBoard/Products/Products_GA-SINXP1394(GA-8SQ80
0%20Ultra2).htm

I tested both modules seperately just minutes ago, AND GET NO ERRORS on
either one. The errors occur when I have both in.

I've tried running them different speeds (e.g. 333), and it made no
difference in what Linux did (black screened after kernel load).

----- Original Message -----
From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
To: "Brien" <admin@brien.com>
Cc: "John Bradford" <john@grabjohn.com>
Sent: Wednesday, April 16, 2003 11:15 AM
Subject: Re: my dual channel DDR 400 RAM won't work on any linux distro


> On Mer, 2003-04-16 at 16:41, Brien wrote:
> > I ran Memtest86, and there're 290 errors that showed up from test 7. But
the
> > thing that I don't understand is, if I use either of the RAM modules
alone,
> > Linux loads and runs perfectly for as long as I've tried; Could it
possibly
> > be a problem with something besides the RAM (e.g. motherboard, CPU)? And
I
> > still don't know if my RAM setup is even supported by Linux -- I'm
guessing
> > that it is though (?).
>
> Do your ram modules exceed the number of chips permitted by the board
> vendor ?
>
>
>



----- Original Message -----
From: "Craig Ruff" <cruff@ucar.edu>
To: "Brien" <admin@brien.com>
Sent: Wednesday, April 16, 2003 12:00 PM
Subject: Re: my dual channel DDR 400 RAM won't work on any linux distro


> I've seen similar problems on my Asus A7V board trying to use all three
DIMM
> slots at the top memory speed (PC133).  Any combination of two works fine,
but
> all three results in the system refusing to get past the BIOS power on
> test and configuration.  I don't know if it is just the type of DIMM
> or the size (three 512MB DIMMs maxes out the board).  However, running at
> PC100 speed causes the system to be able to use all three DIMMs.
>
> --
>
> Craig Ruff      NCAR cruff@ucar.edu
> (303) 497-1211  P.O. Box 3000
> Boulder, CO  80307
>
>


----- Original Message -----
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: "Brien" <admin@brien.com>
Cc: "John Bradford" <john@grabjohn.com>; <linux-kernel@vger.kernel.org>
Sent: Wednesday, April 16, 2003 11:47 AM
Subject: Re: my dual channel DDR 400 RAM won't work on any linux distro


> Hello Brian ,  Try this then run memtest86 against each mem stick
> seperately .  It sounds as if you tried both at the same time ?
> Hth ,  JimL

________________________________

Original Message:

(I posted this on some forums and they recommended that I try here)

Hi,

I have a Gigabyte SINXP1394 motherboard, and 2 Kingston 512 MB DDR 400 (CL
2.5) RAM modules installed. Whenever I try to install any Linux
distribution, I always get a black screen after the kernel loads, when I
have dual channel enabled; If I take out 1 of the RAM modules (either one),
everything works as it should -- it's not a bad module (works perfectly
under Windows by the way). I can't disable dual channel without taking out
half of my RAM, and I really do not want to run with only half of it. Does
anyone have any idea how I can fix this problem, or is it something that
needs to be updated in the kernel?

Thanks for any info.


