Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276040AbRI1NHJ>; Fri, 28 Sep 2001 09:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276024AbRI1NG7>; Fri, 28 Sep 2001 09:06:59 -0400
Received: from [213.236.192.200] ([213.236.192.200]:24546 "EHLO
	mail.circlestorm.org") by vger.kernel.org with ESMTP
	id <S276041AbRI1NGy>; Fri, 28 Sep 2001 09:06:54 -0400
Message-ID: <008f01c1481e$c15eaa70$d2c0ecd5@dead2>
From: "Dead2" <dead2@circlestorm.org>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: Asus CUV266-D problems
Date: Fri, 28 Sep 2001 15:09:07 +0200
Organization: CircleStorm Productions
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, I have now upgraded to the 1004 bios version, and
reinstalled SuSE linux 7.1 using the minimum install, and added
the packages required to compile the kernel.

Unfortunately I still have big problems with booting this computer.

SuSE installer installs 3 kernels:
Linux
Linux 2.4
Suse

All of these use kernel 2.4.0, but with different configurations.

All of these fails during boot, the last message i see is "Starting Syslog",
then i get a blank screen and nothing more happens. Only thing that works
then is a hard boot.

I managed to boot the 'suse' kernel once, and the attached files are from
that session.
The file 'config' is from the 2.4.10 kernel i compiled and tried to boot,
but that too
gets the same errors.

It seems to me that it has a lot of problems with the HDD/-controller, as it
keeps
complaining about it all the time.

Among others, these are the strangest in my openion:
<4>Warning, log replay starting on readonly filesystem
<4>hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
<4>hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
<4>hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
<4>hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
<4>hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
<4>hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
<4>hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
<4>hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
<4>ide0: reset timed-out, status=0xd0

I have tried changing the disk, changing cable, tested all HDD-settings (MW,
SMART, DMA)

As this is a quite attractive server board, I hope I will get some good help
with this problem.

Any additional information needed? Tell me..

-=Dead2=-

----- Original Message -----
From: "Jordan Breeding" <ledzep37@home.com>
> Also if you wouldn't mind sending me your
> .config from your 2.4.10 kernel I would like to check some options to do
> with your problem.  Thanks.
>
> Jordan
>
> Jordan Breeding wrote:
> >
> >
> > P.S. - I didn't see a 1003 version of the -D bios at ftp.asuscom.de but
> > I did see a 1004 version.  I also did not see a DLS bios listed at all,
> > this board is hinted at and has basic specs listed at several sites on
> > the internet, does it exist, can it be bought?  Thanks for any
> > information that you can give me about the CUV266-DLS.  BTW, the
> > unexpected APIC thing is no big deal, it is saying that one of the
> > registers of the APIC stuff is set to something that was unexpected, it
> > happens on almost all current SMP boards I have worked with.
> >
> > Dead2 wrote:
> > >
> > > I'm having big problems with booting on this motherboard.
> > >
> > > It is a dual motherboard with 2x Intel P3 866Mhz cpus
> > > Asus CUV 266-D  Bios rev. 1003
> > >
> > > I have tried to boot with the following kernels:
> > > 2.4.0 (SuSE 7.1 Install CD)
> > > 2.4.4? (SuSE 7.2 Install CD)
> > > 2.4.10 Custom compiled with SMP, but no extra ACPI or APM
> > >
> > > 2.4.0 boots and works for a while, but installation always fails..
> > > It just stops, and never gives any error messages.
> > >
> > > 2.4.4 boots and works for a while, but installation always fails..
> > > It most often stops, but some times it complains about some HDD
> > > error (too fast for me to see what it actually says) then reboots.
> > >
> > > 2.4.10 boots, but only with MPS 1.1, and most of the bios in safety
mode.
> > > When it gets to checking the HDD it fails and mounts it read-only.
> > >
> > > I can see ACPI errors occuring while booting, but they run along too
fast
> > > for me to fine-read.. (any way to pause/delay it?)
> > > Something about unexpected or unknown ACPI-IO *i think*
> > >
> > > I have tried to change the HDD with another one, and have confirmed
> > > that both are working in another comp. (Western Digital WD200)
> > >
> > > If you need any other info, please let me know.
> > >
> > > Please give me feedback on what this might be, and how this can be
solved.
> > >
> > > - Hans K. Rosbach aka Dead2
> > >
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/


