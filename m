Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbTE3RVy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 13:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263848AbTE3RVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 13:21:41 -0400
Received: from web80107.mail.yahoo.com ([66.163.169.80]:16975 "HELO
	web80107.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263879AbTE3RVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 13:21:11 -0400
Message-ID: <20030530173431.4290.qmail@web80107.mail.yahoo.com>
Date: Fri, 30 May 2003 10:34:31 -0700 (PDT)
From: Jordan Breeding <jordan.breeding@sbcglobal.net>
Subject: Re: readcd supossed to suport 2.5.x IDE interface?
To: linux-kernel@vger.kernel.org
Cc: uaca@alumni.uv.es
In-Reply-To: <20030530172036.GA1636@pusa.informat.uv.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please see this thread:
http://marc.theaimsgroup.com/?t=105430004000003&r=1&w=2.

Jordan

--- uaca@alumni.uv.es wrote:
> Hi all
> 
> I'm recording CD-R/W media with cdrecord using
> dev=<ide device> without
> problems but I tried to use readcd in order to read
> media in raw mode 
> and doesn't work:
> 
> agapito:/home/ulisses# readcd dev=/dev/hdc
> f=/dev/null
> Read  speed:  8450 kB/s (CD  48x, DVD  6x).
> Write speed:  7056 kB/s (CD  40x, DVD  5x).
> Capacity: 359819 Blocks = 719638 kBytes = 702 MBytes
> = 736 prMB
> Sectorsize: 2048 Bytes
> Copy from SCSI (0,0,0) disk to file '/dev/null'
> end:    359819
> readcd: Operation not permitted. Cannot send SCSI
> cmd via ioctl
> agapito:/home/ulisses# readcd dev=/dev/hdc
> f=/dev/null
> 
> the error message comes from:
> 
> ioctl(3, 0x2285, 0xbffff570)            = -1 ENOTTY
> (Inappropriate ioctl for device)
> 
> where the file descriptor is the IDE device
> 
> I would like to help if this is a kernel flaw
> 
> I was not sure were I should post this because Joerg
> Schilling doesn't
> support it's tools for IDE devices (not SCSI
> emulated) on Linux
> 
> Thanks all
> 
> 	Ulisses
> 
> PD: I had a crazy idea, there are a lot of Install
> Parties, why not "Bug
> hunting fests/sessions" before 2.6 reach the street?
> 
>                 Debian GNU/Linux: a dream come true
>
-----------------------------------------------------------------------------
> "Computers are useless. They can only give answers."
>            Pablo Picasso
> 
> --->	Visita http://www.valux.org/ para saber acerca
> de la	<---
> --->	Asociación Valenciana de Usuarios de Linux	
> <---
>  
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

