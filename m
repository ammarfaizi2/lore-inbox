Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266167AbRF2UJ7>; Fri, 29 Jun 2001 16:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266168AbRF2UJt>; Fri, 29 Jun 2001 16:09:49 -0400
Received: from femail12.sdc1.sfba.home.com ([24.0.95.108]:58759 "EHLO
	femail12.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S266167AbRF2UJ3>; Fri, 29 Jun 2001 16:09:29 -0400
Message-ID: <3B3CE127.33A89C9E@home.com>
Date: Fri, 29 Jun 2001 13:12:23 -0700
From: John Golubenko <jeneago@home.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.0 i586)
X-Accept-Language: ru, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: John Nilsson <pzycrow@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Some experience of linux on a Laptop
In-Reply-To: <fa.inojkfv.1tiu4gb@ifi.uio.no> <fa.gblj07v.1blumpa@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Features I would like in the kernel:
> > 1: Make the whole insmod-rmmod tingie a kernel internal so they could be
> > trigged before rootmount.
> 
> Already there. In fact Red Hat uses it for the scsi devices. That is what
> initrd is for.
> 
> > 2: Compile time optimization options in Make menuconfig
> 
> such as ?
> 
> > 3: Lilo/grub config in make menuconfig
> 
> make bzlilo does the lilo install - what else would you expect there
> 
> > 4: make bzImage && make modules && make modules install && cp
> > arch/i386/boot/bzImage /boot/'uname -r' something inside make menuconfig
> 
> So really you want an outside GUI tool that lets you reconfigure build and
> install kernels. Yeah I'd agree with that. Someone just needs to write the
> killer gnome/kde config tool. I've got C code for parsing/loading config.in
> files and deducing the dependancy constraints if anyone ever wants to try
> and write such a tool 8)
> 
> > 5: Better support for toshiba computers... well try =)
> 
> modprobe toshiba and look at http://www.buzzard.org.uk/toshiba/
> 
> > 6: Wouldn't it be easier for svgalib/framebuffer/GGI/X11 and others if the
> > graphiccard drivers where kernel modules?
> 
> No.
> 
> > 8: A way to change kernel without rebooting. I have no diskdrive or cddrive
> > in my laptop so I often do drastic things when I install a new distribution.
> 
> Thats actually an incredibly hard problem to solve. The only people who do
> this level of stuff are some of the telephony folks, and the expensive
> tandem non-stop boxes.
> 
> Alan
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Could you please send me that peace of code to parse/loading config.in,
It would be interesting thing to do.
Thanks,
John.
