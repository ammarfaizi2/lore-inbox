Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293129AbSCSWlX>; Tue, 19 Mar 2002 17:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293135AbSCSWlD>; Tue, 19 Mar 2002 17:41:03 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:8964 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S293129AbSCSWk6> convert rfc822-to-8bit; Tue, 19 Mar 2002 17:40:58 -0500
Date: Tue, 19 Mar 2002 14:35:23 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Vincent Bernat <bernat@free.fr>
cc: Jaanus Toomsalu <jaanus@amd.matti.ee>, linux-kernel@vger.kernel.org
Subject: Re: HighPoint HPT372/374 full support?
In-Reply-To: <m3u1rcuu9x.fsf@neo.loria>
Message-ID: <Pine.LNX.4.10.10203191434020.525-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a client paying for the development of that driver addition which
will be GPLed when stable.  This is the same issue we are both seeing when
attached to VIA cores.

Regards,

Andre Hedrick
CEO/President, LAD Storage Consulting Group
Linux ATA Development
Linux Disk Certification Project

On Tue, 19 Mar 2002, Vincent Bernat wrote:

> OoO En ce début d'après-midi ensoleillé du lundi 18 mars 2002, vers
> 15:08, Jaanus Toomsalu <jaanus@amd.matti.ee> disait:
> 
> > Is there any hints to get this UDMA133 chip to work. Currently it seems to 
> > reported work over WIP (WorkInProgress), but on my onboard ABIT KR7A-RAID i 
> > get DMA disabled message and all hardisks on HPT372 IDE channel are "lost" 
> > after that.
> 
> I have the same problem here, but just when I try to use md to setup a
> disk array. In fact, I can dd to /dev/null two disks at the same time
> (each on its separate controller) without any troubles (each disk
> through output is 40 MB/s). Software raid with hptraid works fine but
> I don't get significant performance improvement. But each time I try
> to use md, I always get the same problem than you. mkraid, raidstop or
> anything which access /dev/md0 triggers a DMA problem.
> 
> I have asked the question in linux-raid mailing list yesterday but got
> no solution so far.
> 
> I have upgraded to newest BIOS patched with the latest BIOS from
> Highpoint (2.31) and there is no change (but I think the BIOS is not
> used). I have tried with a vanilla 2.4.18 and with 2.4.19-pre3-ac1.
> -- 
> I NO LONGER WANT MY MTV
> I NO LONGER WANT MY MTV
> I NO LONGER WANT MY MTV
> -+- Bart Simpson on chalkboard in episode 3G02
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

