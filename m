Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261617AbRE0LPY>; Sun, 27 May 2001 07:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261639AbRE0LPE>; Sun, 27 May 2001 07:15:04 -0400
Received: from mailout00.sul.t-online.com ([194.25.134.16]:24330 "EHLO
	mailout00.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S261617AbRE0LPA>; Sun, 27 May 2001 07:15:00 -0400
Date: Sun, 27 May 2001 13:08:39 +0200
From: Marc Schiffbauer <marc.schiffbauer@links2linux.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Solved ?: IDE Performance lack !
Message-ID: <20010527130839.B20142@lisa.links2linux.home>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <01052712064100.02124@linux.zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01052712064100.02124@linux.zuhause.de>; from stepken@little-idiot.de on Sun, May 27, 2001 at 12:06:41PM +0200
X-Operating-System: Linux 2.2.18-lisa01 i586
X-Editor: VIM 5.7.8
X-Homepage: http://www.links2linux.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Guido Stepken schrieb am 27.05.01 um 12:06 Uhr:
> Hi !
> 
> My performance problemes have disappeared. I recompiled the kernel with:
> 
> (Direct) PCI access mode
> APIC and IOApic   == OFF
> SCSI competely == OFF
> NE1000/2000 Modules compiled in as Module (directly compiled in did not work)
> Changed BIOS PCI Mode to AUTO (perhaps useless)
> 

Hmm, strange. My PCI-Mode is (Any), I have APIC enabled
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y

And I use SCSI. 
I do not have any Problems. Do you have these Problems under heavy
load, or when your machine is idle?

> Now my performance is normal, with and without hdparm optimisations (tnx to 
> posters)

Hmm. hdparm -d1 should AFAIK always speedup your IDE-HD
I have about 6MB/s without and about 26 MB/s using DMA

> 
> IMHO, there are still problems with interrupts (is thre still one 
> interrupt/IP paket ??)
> 

Dont know. Try to find out e.g. with xosview, which shows you
interupts...

-Marc
-- 
+-O . . . o . . . O . . . o . . . O . . .  ___  . . . O . . . o .-+
| Ein neuer Service von Links2Linux.de:   /  o\   RPMs for SuSE   |
| --> PackMan! <-- naeheres unter        |   __|   and  others    |
| http://packman.links2linux.de/ . . . O  \__\  . . . O . . . O . |
