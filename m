Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129759AbQLUUbF>; Thu, 21 Dec 2000 15:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130127AbQLUUay>; Thu, 21 Dec 2000 15:30:54 -0500
Received: from acct2.voicenet.com ([207.103.26.205]:32415 "HELO voicenet.com")
	by vger.kernel.org with SMTP id <S129759AbQLUUan>;
	Thu, 21 Dec 2000 15:30:43 -0500
Message-ID: <3A426150.1545FC96@voicenet.com>
Date: Thu, 21 Dec 2000 15:00:16 -0500
From: safemode <safemode@voicenet.com>
Organization: none
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10-pre3-scsi-ide i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Zdenek Kabelac <kabi@fi.muni.cz>
CC: xOr <xor@x-o-r.net>, linux-kernel@vger.kernel.org
Subject: Re: lockups from heavy IDE/CD-ROM usage
In-Reply-To: <Pine.LNX.4.31.0012210421450.284-100000@bitch.x-o-r.net> <3A41FFD8.531DF534@fi.muni.cz>
Content-Type: multipart/alternative;
 boundary="------------66AE11821577481D6704D491"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------66AE11821577481D6704D491
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Zdenek Kabelac wrote:

> > Problem: When i am using my harddrive and cdrom, my computer will freeze.
> > It freezes in two different ways.. sometimes just the harddrive access
> > will freeze (can still do things in X as long as they dont require the
> > harddrive), and then everything freezes within a few seconds. or else
> > everything just locks instntly. the problem is reproducable, all i need to
> > do is be using the harddrive extensively for a couple separate functions
> > (like compiling the kernel, and copying a large file) and ripping cd audio
> > (cd paranoia) and i can lock the system in as little as seconds, or a few
> > minutes sometimes.  This will happen more reliably, and much quicker and
>
> This is really very similar to my problem with BP6 I'm reporting for a
> long long time.
> But everyone says its faulty board.
>
> For BP6 somehow helps to set UDMA to mode 2.
> (I'm not getting these locks when I'm just using ATA33 controler)
> (hdparm -X66 /dev/hdX)
>
> Also could you look at what is being written to console ?
> (run those intesive programs and stay on console - BP6 lock with
> this message displayed:
>
> hdf: timeout waiting for DMA
> ide_dmaproc: chipset supported ide_dma_timeout: func only 14
>
> In this point it looks like timers are dead... :(
> And the situation is the same with SMP & NoSMP kernel with apic &
> noapic.
>

I get this on the 440LX with the same DMA timeout message.  Everyone says it's
the board's fault as well.  Funny.   Anyways this happens accross just about
any Dev kernel but more so in the -test12 and up versions. .   Test10 works
fine without locking.  Blaming the hardware reminds me of the help given by
some other company I can't seem to remember the name to.


--------------66AE11821577481D6704D491
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
Zdenek Kabelac wrote:
<blockquote TYPE=CITE>> Problem: When i am using my harddrive and cdrom,
my computer will freeze.
<br>> It freezes in two different ways.. sometimes just the harddrive access
<br>> will freeze (can still do things in X as long as they dont require
the
<br>> harddrive), and then everything freezes within a few seconds. or
else
<br>> everything just locks instntly. the problem is reproducable, all
i need to
<br>> do is be using the harddrive extensively for a couple separate functions
<br>> (like compiling the kernel, and copying a large file) and ripping
cd audio
<br>> (cd paranoia) and i can lock the system in as little as seconds,
or a few
<br>> minutes sometimes.&nbsp; This will happen more reliably, and much
quicker and
<p>This is really very similar to my problem with BP6 I'm reporting for
a
<br>long long time.
<br>But everyone says its faulty board.
<p>For BP6 somehow helps to set UDMA to mode 2.
<br>(I'm not getting these locks when I'm just using ATA33 controler)
<br>(hdparm -X66 /dev/hdX)
<p>Also could you look at what is being written to console ?
<br>(run those intesive programs and stay on console - BP6 lock with
<br>this message displayed:
<p>hdf: timeout waiting for DMA
<br>ide_dmaproc: chipset supported ide_dma_timeout: func only 14
<p>In this point it looks like timers are dead... :(
<br>And the situation is the same with SMP &amp; NoSMP kernel with apic
&amp;
<br>noapic.
<br><a href="http://www.tux.org/lkml/"></a>&nbsp;</blockquote>
I get this on the 440LX with the same DMA&nbsp;timeout message.&nbsp; Everyone
says it's the board's fault as well.&nbsp; Funny.&nbsp;&nbsp; Anyways this
happens accross just about any Dev kernel but more so in the -test12 and
up versions. .&nbsp;&nbsp; Test10 works fine without locking.&nbsp; Blaming
the hardware reminds me of the help given by some other company I can't
seem to remember the name to.
<br>&nbsp;</html>

--------------66AE11821577481D6704D491--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
