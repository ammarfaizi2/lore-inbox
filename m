Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266587AbRGRA5K>; Tue, 17 Jul 2001 20:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266529AbRGRA5A>; Tue, 17 Jul 2001 20:57:00 -0400
Received: from [209.250.53.179] ([209.250.53.179]:11278 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S266587AbRGRA4v>; Tue, 17 Jul 2001 20:56:51 -0400
Date: Tue, 17 Jul 2001 19:56:23 -0500
From: Steven Walter <srwalter@yahoo.com>
To: James Stevenson <mistral@stev.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: serious cd writer kernel bug 2.4.x
Message-ID: <20010717195622.A22955@hapablap.dyn.dhs.org>
In-Reply-To: <GBEALFKJGAFHFMBNFHAEGEBFCLAA.jorgp@bartnet.net> <Pine.LNX.4.30.0107180038180.2075-100000@cyrix.stev.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0107180038180.2075-100000@cyrix.stev.org>; from mistral@stev.org on Wed, Jul 18, 2001 at 12:42:31AM +0000
X-Uptime: 7:44pm  up 1 day, 23:45,  1 user,  load average: 1.02, 1.49, 1.58
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had a problem similar to this until I turned off DMA to the drive
(hdparm -d0 /dev/hdc).  Additionally, my drive now works with DMA after
apply Andre Hedrick's IDE patch.

On Wed, Jul 18, 2001 at 12:42:31AM +0000, James Stevenson wrote:
> Hi
> 
> > I experience almost the exact same thing with my cd-rw.
> > PlexWriter 8/4/32A, does the same thing, and if I compile the modules
> > ide-scsi and scsi
> 
> > directly into the kernel, whenever I access the cd-rw at all (try to mount a
> > valid filesystem) entire system locks and have to hard reboot.. I can access
> 
> i am not running modules but the ide-scsi stuff is compiled into the
> kernel both drives are running under the scsi-emu.
> can you also access the cd rom fine under linux.
> 
> the cd-rom works fine for me
> as soon as i touch the writer it dies.
> 
> > boot). I am using stock Mandrake 8.0 with 2.4.6-ac2 kernel. I can run
> > cdrecord --scanbus and it sees the cd-rw fine
> 
> i am also running mandrake 8.0 and cdrecord works up to that point
> i have seen it crash under.
> 
> 2.4.3
> 2.4.4
> 2.4.5
> 2.4.5-ac15
> 2.4.6
> 2.4.6-ac5
> 
> i have not tried earlery kernels for various other resons.
> 
> > hda - disk 1
> > hdb - disk 2
> > hdc - cd-rom
> > hdd - cd-rw
> 
> almost like that but its
> hda - disk 1
> hdb - disk 2
> hdc - cd writer
> hdd - cd rom
> 
> 
> -- 
> ---------------------------------------------
> Web: http://www.stev.org
> Mobile: +44 07779080838
> E-Mail: mistral@stev.org
>  12:30am  up 35 min,  6 users,  load average: 1.90, 2.32, 2.30
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
