Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263812AbTE3RTb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 13:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbTE3RTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 13:19:31 -0400
Received: from pusa.informat.uv.es ([147.156.10.98]:64677 "EHLO
	pusa.informat.uv.es") by vger.kernel.org with ESMTP id S263812AbTE3RT2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 13:19:28 -0400
Date: Fri, 30 May 2003 19:32:42 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: readcd supossed to suport 2.5.x IDE interface?
Message-ID: <20030530173242.GA2679@pusa.informat.uv.es>
References: <20030530172036.GA1636@pusa.informat.uv.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030530172036.GA1636@pusa.informat.uv.es>
User-Agent: Mutt/1.3.28i
From: uaca@alumni.uv.es
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi again,

I'm sorry I did not tell I was using 2.5.68 vanilla, also I just saw the new
patches. I will report about it later

	Ulisses

On Fri, May 30, 2003 at 07:20:36PM +0200, uaca@alumni.uv.es wrote:
> Hi all
> 
> I'm recording CD-R/W media with cdrecord using dev=<ide device> without
> problems but I tried to use readcd in order to read media in raw mode 
> and doesn't work:
> 
> agapito:/home/ulisses# readcd dev=/dev/hdc f=/dev/null
> Read  speed:  8450 kB/s (CD  48x, DVD  6x).
> Write speed:  7056 kB/s (CD  40x, DVD  5x).
> Capacity: 359819 Blocks = 719638 kBytes = 702 MBytes = 736 prMB
> Sectorsize: 2048 Bytes
> Copy from SCSI (0,0,0) disk to file '/dev/null'
> end:    359819
> readcd: Operation not permitted. Cannot send SCSI cmd via ioctl
> agapito:/home/ulisses# readcd dev=/dev/hdc f=/dev/null
> 
> the error message comes from:
> 
> ioctl(3, 0x2285, 0xbffff570)            = -1 ENOTTY (Inappropriate ioctl for device)
> 
> where the file descriptor is the IDE device
> 
> I would like to help if this is a kernel flaw
> 
> I was not sure were I should post this because Joerg Schilling doesn't
> support it's tools for IDE devices (not SCSI emulated) on Linux
> 
> Thanks all
> 
> 	Ulisses
> 
> PD: I had a crazy idea, there are a lot of Install Parties, why not "Bug
> hunting fests/sessions" before 2.6 reach the street?
> 
>                 Debian GNU/Linux: a dream come true
> -----------------------------------------------------------------------------
> "Computers are useless. They can only give answers."            Pablo Picasso
> 
> --->	Visita http://www.valux.org/ para saber acerca de la	<---
> --->	Asociación Valenciana de Usuarios de Linux		<---
>  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
                Debian GNU/Linux: a dream come true
-----------------------------------------------------------------------------
"Computers are useless. They can only give answers."            Pablo Picasso

--->	Visita http://www.valux.org/ para saber acerca de la	<---
--->	Asociación Valenciana de Usuarios de Linux		<---
 
