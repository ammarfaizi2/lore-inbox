Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275832AbRJBGY3>; Tue, 2 Oct 2001 02:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275836AbRJBGYS>; Tue, 2 Oct 2001 02:24:18 -0400
Received: from zok.SGI.COM ([204.94.215.101]:40415 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S275832AbRJBGYG>;
	Tue, 2 Oct 2001 02:24:06 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Miles Lane <miles@megapathdsl.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.11-pre1 -- Building aedsp16.o -- No rule to make target `/etc/sound/dsp001.ld', needed by `pss_boot.h' 
In-Reply-To: Your message of "01 Oct 2001 22:06:06 MST."
             <1001999167.916.14.camel@agate> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 02 Oct 2001 16:24:20 +1000
Message-ID: <21468.1002003860@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01 Oct 2001 22:06:06 -0700, 
Miles Lane <miles@megapathdsl.net> wrote:
>On Mon, 2001-10-01 at 03:04, Keith Owens wrote:
>> On 01 Oct 2001 02:34:23 -0700, 
>> Miles Lane <miles@megapathdsl.net> wrote:
>> >gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon  -DMODULE   -c -o aedsp16.o aedsp16.c
>> >make[2]: *** No rule to make target `/etc/sound/dsp001.ld', needed by `pss_boot.h'.  Stop.
>> 
>> >gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon  -DMODULE   -c -o cpqfcTSinit.o cpqfcTSinit.c
>> >cpqfcTSinit.c: In function `cpqfcTS_ioctl':
>> >cpqfcTSinit.c:662: `SCSI_IOCTL_FC_TARGET_ADDRESS' undeclared (first use in this function)
>> 
>> You really need to search the archives better.  Both have already been
>> covered.
>> 
>Perhaps you have a better way of searching the archive than I do.
>What interface do you use for querying the list?

Same interface as you, I just pick more specific keywords.  The way
that MARC changes '_' to ' ' is annoying, so I avoid keywords with '_'
in them.  Searching on cpqfcTSinit.c and dsp001.ld is much better,
sometimes .o will provide a hit when .c does not.

