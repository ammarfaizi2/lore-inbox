Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132255AbQLQJkP>; Sun, 17 Dec 2000 04:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132358AbQLQJkF>; Sun, 17 Dec 2000 04:40:05 -0500
Received: from [195.163.91.180] ([195.163.91.180]:55822 "EHLO frontpartner.com")
	by vger.kernel.org with ESMTP id <S132255AbQLQJj7>;
	Sun, 17 Dec 2000 04:39:59 -0500
Message-ID: <3A3C828D.E84FA89C@linux.se>
Date: Sun, 17 Dec 2000 10:08:29 +0100
From: Mathias Wiklander <eastbay@linux.se>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: stewart@neuron.com
CC: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx
In-Reply-To: <Pine.LNX.4.10.10012170237090.757-100000@localhost>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That's not the case for me. When I build it in to the kernel, the kernel
comes tho the init of thje board then these lines repeats  forever.

SCSI host 0 abort (pid 0) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
SCSI host 0 channel 0 reset (pid 0) timed out - trying harder
SCSI bus is being reset for host 0 channel 0.

/Mathias

stewart@neuron.com wrote:
> 
>  I am also having problems with this driver, but with different adapters
>  and symptoms. depmod is reporting a lot of unresolved symbols for generic
>  scsi and scsi cdrom. Compiling it into the kernel instead of as a module
>  seems to bypass the problems.
> 
>  stewart
> 
> On Sun, 17 Dec 2000, Mathias Wiklander wrote:
> 
> > Hi!
> >
> > I have problem using my scsi card. It is an Adaptec 2940 (SCSI2). When
> > ever I try to load it as a module or if I compile it in the kernel I get
> > the folowing error messages. The last 4 messages repeats for ever. The
> > problem is on 3 diffrent machines. Anyone who know what it can be and
> > how to fix it.
> >
> > /Eastbay
> >
> > (scsi0) <Adaptec AHA-294X SCSI host adapter> found at PCI 0/19/0
> > (scsi0) Narrow Channel, SCSI ID=7, 16/255 SCBs
> > (scsi0) Cables present (Int-50 NO, Ext-50 NO)
> > (scsi0) Downloading sequencer code... 415 instructions downloaded
> > scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
> >        <Adaptec AHA-294X SCSI host adapter>
> > scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0,
> > lun 0 Inquiry 00 00 00 ff 00
> > SCSI host 0 abort (pid 0) timed out - resetting
> > SCSI bus is being reset for host 0 channel 0.
> > SCSI host 0 channel 0 reset (pid 0) timed out - trying harder
> > SCSI bus is being reset for host 0 channel 0.
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > Please read the FAQ at http://www.tux.org/lkml/
> >
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
