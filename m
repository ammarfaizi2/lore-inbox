Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275805AbRJBEzh>; Tue, 2 Oct 2001 00:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275806AbRJBEz2>; Tue, 2 Oct 2001 00:55:28 -0400
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:23563 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S275805AbRJBEzO>; Tue, 2 Oct 2001 00:55:14 -0400
Subject: Re: 2.4.11-pre1 -- Building aedsp16.o -- No rule to make target
	`/etc/sound/dsp001.ld', needed by `pss_boot.h'
From: Miles Lane <miles@megapathdsl.net>
To: Keith Owens <kaos@ocs.com.au>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <635.1001930646@ocs3.intra.ocs.com.au>
In-Reply-To: <635.1001930646@ocs3.intra.ocs.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14.99+cvs.2001.09.25.20.14 (Preview Release)
Date: 01 Oct 2001 22:06:06 -0700
Message-Id: <1001999167.916.14.camel@agate>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-10-01 at 03:04, Keith Owens wrote:
> On 01 Oct 2001 02:34:23 -0700, 
> Miles Lane <miles@megapathdsl.net> wrote:
> >gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon  -DMODULE   -c -o aedsp16.o aedsp16.c
> >make[2]: *** No rule to make target `/etc/sound/dsp001.ld', needed by `pss_boot.h'.  Stop.
> 
> >gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon  -DMODULE   -c -o cpqfcTSinit.o cpqfcTSinit.c
> >cpqfcTSinit.c: In function `cpqfcTS_ioctl':
> >cpqfcTSinit.c:662: `SCSI_IOCTL_FC_TARGET_ADDRESS' undeclared (first use in this function)
> 
> You really need to search the archives better.  Both have already been
> covered.
> 
Perhaps you have a better way of searching the archive than I do.
What interface do you use for querying the list?  I am attempting
to do so through http://marc.theaimsgroup.com.  When I try searching
for the undefined symbol "acpi_debug_print_raw", the query returns
that it searched for "acpi debug print raw".  This gives me a lot of
false positives.  It would be great if there were an exact string match.
It would be even better if there were a more advance search that would 
accept multiple search strings and allow AND, OR and logical grouping 
with parentheses.

Regardless, I will try to do better.

	Miles

