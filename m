Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261918AbRE2VMQ>; Tue, 29 May 2001 17:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261956AbRE2VMG>; Tue, 29 May 2001 17:12:06 -0400
Received: from wb3-a.mail.utexas.edu ([128.83.126.138]:24581 "HELO
	mail.utexas.edu") by vger.kernel.org with SMTP id <S261918AbRE2VLw>;
	Tue, 29 May 2001 17:11:52 -0400
Message-ID: <3B1367DD.A71E8066@mail.utexas.edu>
Date: Tue, 29 May 2001 15:11:57 +0600
From: "Bobby D. Bryant" <bdbryant@mail.utexas.edu>
Organization: (I do not speak for) The University of Texas at Austin (nor they for 
 me).
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-athlon i686)
X-Accept-Language: en,fr,de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Mike Frisch <mfrisch@saturn.tlug.org>
Subject: Re: Status of ALi MAGiK 1 support in 2.4.?
In-Reply-To: <3B12DCCF.6524A99@mail.utexas.edu> <20010529100713.A3845@saturn.tlug.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Frisch wrote:

> On Tue, May 29, 2001 at 05:18:39AM +0600, Bobby D. Bryant wrote:
> > sailing ever since.  The only problems that I'm are ware of are a
> > (maybe) DMA problem and a (maybe) SMBus problem, per below.  Right now
>
> I noticed the Win32 benchmark/test application Sandra mentioned an SMBus
> problem with the A7A266 as well.  I have yet to try lm_sensors myself,
> but it looks like I won't get far.

My sensors are working and appear to give the correct numbers; I'm just
getting a regular spew of messages from the SMB resets.



> > May 22 21:45:07 pollux kernel: ALI15X3: IDE controller on PCI bus 00 dev
> > 20
> > May 22 21:45:07 pollux kernel: PCI: No IRQ known for interrupt pin A of
> > device 00:04.0. Please try using pci=biosirq.
>
> I get the same message, but it does not appear to dramatically affect
> my performance.  As I mentioned, I am getting 25MB/s (through hdparm; I
> have yet to try anything more) with my Quantum Fireball.  My DMA is
> enabled in the BIOS and detected by the kernel.

That's interesting, in light of the other message I just sent (i.e., DMA
enabled in BIOS, but *not* detected by the kernel).

What version of the BIOS are you running?  I'm still on the 1003b, because
I've heard a few horror stories about 1004 that have put me off upgrading.

I'm on kernel 2.4.4, with Athlon optimizations.


> > The routing to IQR 0 sounds funny to me, but this is already way beyond
> > what I understand.
>
> Do you have the PnP operating system setting in the BIOS turned off?
> (ie. telling the BIOS you have non-PnP aware O/S)  I noticed that prior
> to doing this, all of my PCI cards were listed as IRo 0.

I think I tried it both ways earlier.  At any rate, since I had to reboot to
check the DMA settings I went ahead and set it back to 'off', and it still
says the same thing.

Thanks,

Bobby Bryant
Austin, Texas


