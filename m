Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313817AbSDPSqR>; Tue, 16 Apr 2002 14:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313820AbSDPSqQ>; Tue, 16 Apr 2002 14:46:16 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:39176 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S313817AbSDPSqP>; Tue, 16 Apr 2002 14:46:15 -0400
Message-Id: <200204161843.g3GIhSX26862@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: E M Recio <polywog@navpoint.com>, <linux-kernel@vger.kernel.org>
Subject: Re: AMD Athlon + VIA Crashing On Disk I/O
Date: Tue, 16 Apr 2002 21:45:43 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.33.0204160921060.472-100000@polywog.navpoint.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 April 2002 11:28, E M Recio wrote:
> Hiya,
>
> I have an AMD Athlon 1.2 with a VIA 8259A Chipset (see bottom). If I
> compile the kernel with the Athlon option it crashes all the time. In
> fact, I can't even get Redhat 7.2 installed without a core dump when it
> tries to mount the filesystem. With the later kernels, it doesn't core
> dump, but just freezes.

Kernel version?

> IE: If I have ide-scsi module loaded, and I try to access the floppy
> drive, it locks up the machine (regardless of whether cputype is Athlon
> or K6.)
>
> IE: Updatedb locks up the machine.
>
> I get (when FSCK):
>
> spurious 8259A IRQ7

cat /proc/interrupts, is ther lots of ERR: interrupts?

> Does anyone know if there's a bug fix for this chipset? My board is
> made from FIC (crappy, instructions don't even matchup). I used to be
> able to fix it by changing the CPU type to K6 but that doesn't work now
> with the later kernels (2.4.15 and up.)

Try to compile for 486.
--
vda
