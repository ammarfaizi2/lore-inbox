Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274842AbRJAKEa>; Mon, 1 Oct 2001 06:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274834AbRJAKEV>; Mon, 1 Oct 2001 06:04:21 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:48396 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S274835AbRJAKEF>;
	Mon, 1 Oct 2001 06:04:05 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Miles Lane <miles@megapathdsl.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.11-pre1 -- Building aedsp16.o -- No rule to make target `/etc/sound/dsp001.ld', needed by `pss_boot.h' 
In-Reply-To: Your message of "01 Oct 2001 02:34:23 MST."
             <1001928866.1246.95.camel@stomata.megapathdsl.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 01 Oct 2001 20:04:06 +1000
Message-ID: <635.1001930646@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01 Oct 2001 02:34:23 -0700, 
Miles Lane <miles@megapathdsl.net> wrote:
>gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon  -DMODULE   -c -o aedsp16.o aedsp16.c
>make[2]: *** No rule to make target `/etc/sound/dsp001.ld', needed by `pss_boot.h'.  Stop.

>gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon  -DMODULE   -c -o cpqfcTSinit.o cpqfcTSinit.c
>cpqfcTSinit.c: In function `cpqfcTS_ioctl':
>cpqfcTSinit.c:662: `SCSI_IOCTL_FC_TARGET_ADDRESS' undeclared (first use in this function)

You really need to search the archives better.  Both have already been
covered.

