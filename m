Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282975AbRK0VjN>; Tue, 27 Nov 2001 16:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282974AbRK0VjD>; Tue, 27 Nov 2001 16:39:03 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:45952 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S282968AbRK0ViZ>; Tue, 27 Nov 2001 16:38:25 -0500
Date: Tue, 27 Nov 2001 14:42:08 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Cc: jmerkey@timpanogas.org
Subject: Re: aha152x driver build broken 2.5.1-pre2
Message-ID: <20011127144208.B6048@vger.timpanogas.org>
In-Reply-To: <20011127144016.A6048@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011127144016.A6048@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Tue, Nov 27, 2001 at 02:40:16PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Sorry.  Did not see your post on this subject.  

Jeff


On Tue, Nov 27, 2001 at 02:40:16PM -0700, Jeff V. Merkey wrote:
> 
> 
> See attached.  Build broken in 2.5.1-pre2 for the aha152x drivers.
> Reporting undelcared functions.
> 
> Jeff
> 

> make all_targets
> make[3]: Entering directory `/usr/src/linux/drivers/scsi'
> ld -m elf_i386 -r -o scsi_mod.o scsi.o hosts.o scsi_ioctl.o constants.o scsicam.o scsi_proc.o scsi_error.o scsi_obsolete.o scsi_queue.o scsi_lib.o scsi_merge.o scsi_dma.o scsi_scan.o scsi_syms.o
> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686   -DAHA152X_STAT -DAUTOCONF -c -o aha152x.o aha152x.c
> aha152x.c: In function `aha152x_detect':
> aha152x.c:1352: `io_request_lock' undeclared (first use in this function)
> aha152x.c:1352: (Each undeclared identifier is reported only once
> aha152x.c:1352: for each function it appears in.)
> make[3]: *** [aha152x.o] Error 1
> make[3]: Leaving directory `/usr/src/linux/drivers/scsi'
> make[2]: *** [first_rule] Error 2
> make[2]: Leaving directory `/usr/src/linux/drivers/scsi'
> make[1]: *** [_subdir_scsi] Error 2
> make[1]: Leaving directory `/usr/src/linux/drivers'
> make: *** [_dir_drivers] Error 2

