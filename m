Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131408AbRC3Ncu>; Fri, 30 Mar 2001 08:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131410AbRC3Ncl>; Fri, 30 Mar 2001 08:32:41 -0500
Received: from [194.25.18.216] ([194.25.18.216]:22022 "EHLO ntovmsw02.otto.de")
	by vger.kernel.org with ESMTP id <S131408AbRC3NcZ>;
	Fri, 30 Mar 2001 08:32:25 -0500
Message-Id: <4B6025B1ABF9D211B5860008C75D57CC0271B9E6@NTOVMAIL04>
From: "Butter, Frank" <Frank.Butter@otto.de>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: AW: WG: 2.4 on COMPQ Proliant
Date: Fri, 30 Mar 2001 15:32:18 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I solved the SCSI problem now - thanks for the hint to take 
sym53c8xx instead of ncr53c8xx.

For the SMP-Problem it helped to use an option offerd at boot time:
"Press F9 to select different operating system". Before I used 
"Minimum Configuration...", because Linux wasn't listed.
After I've choosen UNIX/SCO, the SMP was detected properly.

Now I have 3 of these machines, dedicated to a cluster.
On the second machine, The "F9"-option is not offered! 
(only F10 for Partitioning Utilities - but they were not found).

What option do I have now to change the settings? Is there a
posibility to start something from "SmartStart" to adjust it?

I've installed RedHat7 default for servers - there is no special 
COMPAQ-Partition on it (I'm not sure if there was before).

Thx,
Frank




>Hello EveryBody,
> I have a COMPAQ ML570 (2xPIII-700Mhz/1MBytes Cache, 2 x NCR SCSI
controller=
> ,=20
> 1 SMART ARRAY 5304 (128 MBytes Cache). I test with linux 2.4.2-ac20, and
al=
> l=20
> disks, CPU's and memory have been detected by the KERNEL.
> See your BIOS Version, My COMPAQ has BIOS P20 01/21/2001, I download
from=20
> compaq.com
>
> Andre Margis

Em Quinta 29 Mar=E7o 2001 20:02, Mr. James W. Laferriere escreveu:
> Hello Frank ,  Highly recommend the sym53c***** .  JimL
>
> On Thu, 29 Mar 2001, Butter, Frank wrote:
> > 2.2.16 claimes to find a ncr53c1510D-chipset, supported by
> > the driver ncr53c8xx. Which kernel-param would be the correct one for
> > this? Frank
> >
> > > -----Urspr=FCngliche Nachricht-----
> > > Von: Butter, Frank
> > > Gesendet: Donnerstag, 29. M=E4rz 2001 17:11
> > > An: 'linux-kernel@vger.kernel.org'
> > > Betreff: 2.4 on COMPQ Proliant
> > > Has anyone experiences with 2.4.x on recent Compaq Proliant
> > > Servers (e.g. ML570)?
> > >
> > > I've installed RedHat7 and it worked fine out of the box.
> > > Except that the SMP-enabled kernel stated there was no
> > > SMP-board detected ;-/
> > > For some reasons (Fibrechannel drivers and so on) I've compiled
> > > 2.4.2 and installed it. Although I've compiled the support
> > > in, the NCR-SCSI-chip was not found and therefore no
> > > root-partition. It is a model supported by 53c8xx - detected
> > > by the original RedHat-kernel.
> > >
> > > For testing I compiled a kernel with all (!) scsi-low-level-drivers -
> > > with the same result. The SMP-board also was NOT detected by 2.4.2.
> > >
> > > Any hint?
> > >
> > > Frank

