Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314082AbSEJLQz>; Fri, 10 May 2002 07:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315042AbSEJLQz>; Fri, 10 May 2002 07:16:55 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:42513 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S314082AbSEJLQy>; Fri, 10 May 2002 07:16:54 -0400
Message-Id: <200205101112.g4ABCoX29098@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Tomasz Rola <rtomek@cis.com.pl>, mikeH <mikeH@notnowlewis.co.uk>
Subject: Re: lost interrupt hell - Plea for Help
Date: Fri, 10 May 2002 14:15:53 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1020509132713.1987A-100000@pioneer>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 May 2002 09:34, Tomasz Rola wrote:
> > I have tried every combination of master / slave between the two drives,
> > the drives on their own, scsi emulation through ide-scsi, purely as IDE
> > drives, ommitting ide cdrom support from teh kernel completely and only
> > using ide-scsi... every time I try to get a track ripped, dmesg fills up
> > with hdX: lost interrupt.
> >
> > If I try to rip from the DVD drive, the system hangs and its reset
> > button time.
> >
> > Can anyone tell me where I'm going wrong? Is there anything from my
> > system you need to see to help me?
>
> Hi again. I've thought I've already given up but just to be sure and not
> forget about anything (yes, some people - like me - don't know when to
> stop and go home):
>
> 1. Have you tried another ide cables?
> 2. Do they stick ok?
> 3. How about unplugging CD completely from the motherboard?
> 4. Perhaps you need to compile via-specific options into your kernel.
>
> In my case, every time I've seen lost interrupt it was something from the
> above.

But none of the above justifies kernel hang. It's a bug to fix.
There is IDE maintainer for 2.4:

Andre Hedrick <andre@linux-ide.org> [09 apr 2002]
	ATA/ATAPI Storage Architect [2.0,2.2,2.4]
	HBA interface developer
	Serial ATA Architect [future release]
	Voting NCITS member AT-Attachment Committee

Ask him what details he needs and maybe he will be able to help.
--
vda
