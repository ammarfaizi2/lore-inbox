Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266453AbSKOQ6u>; Fri, 15 Nov 2002 11:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266456AbSKOQ6u>; Fri, 15 Nov 2002 11:58:50 -0500
Received: from opengfs.tovarcom.com ([65.67.58.21]:52618 "HELO
	escalade.vistahp.com") by vger.kernel.org with SMTP
	id <S266453AbSKOQ6s>; Fri, 15 Nov 2002 11:58:48 -0500
Message-ID: <20021115170836.14228.qmail@escalade.vistahp.com>
References: <YWxhbg==.a513a46732330fd5f834894ae7200923@1037378527.cotse.net>
In-Reply-To: <YWxhbg==.a513a46732330fd5f834894ae7200923@1037378527.cotse.net>
From: "Brian Jackson" <brian-kernel-list@mdrx.com>
To: alan@cotse.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: CD IO error
Date: Fri, 15 Nov 2002 11:08:36 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Willis writes: 

> 
>   I've been getting these messages since about 2.5.45.  I can't mount any
> cds at all.  Elvtune (util-linux-2.11r) also fails on /dev/hda which I'm
> running on, and /dev/hdc, my cdrom. 
> 
> Any further info needed?

Distribution
IDE controller/motherboard
a few more lines before and after the error from dmesg 


> 
> -alan 
> 
> end_request: I/O error, dev hdc, sector 0
> hdc: ATAPI 48X CD-ROM drive, 120kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.12
> end_request: I/O error, dev hdc, sector 0 
> 
> # hdparm /dev/hdc 
> 
> /dev/hdc:
>  HDIO_GET_MULTCOUNT failed: Inappropriate ioctl for device
>  IO_support   =  0 (default 16-bit)
>  unmaskirq    =  0 (off)
>  using_dma    =  1 (on)
>  keepsettings =  0 (off)
>  readonly     =  1 (on)
>  readahead    = 256 (on)
>  HDIO_GETGEO failed: Inappropriate ioctl for device 
> 
>  
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
 
