Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264310AbRFHTeP>; Fri, 8 Jun 2001 15:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264317AbRFHTeF>; Fri, 8 Jun 2001 15:34:05 -0400
Received: from mail2.aracnet.com ([216.99.193.35]:40715 "EHLO
	mail2.aracnet.com") by vger.kernel.org with ESMTP
	id <S264311AbRFHTd7>; Fri, 8 Jun 2001 15:33:59 -0400
Date: Fri, 8 Jun 2001 12:33:57 -0700 (PDT)
From: Paul Buder <paulb@aracnet.com>
To: David Woodhouse <dwmw2@infradead.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Large ramdisk crashes system 
In-Reply-To: <14555.991956946@redhat.com>
Message-ID: <Pine.LNX.4.33.0106081232220.17187-100000@shell1.aracnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Jun 2001, David Woodhouse wrote:

>
> paulb@aracnet.com said:
> > the kernel is 2.4.5 with 'Simple RAM-based file system support' turned on.
>
> > I issued the following commands.
>
> > mkfs /dev/ram0 400000
> > mount /dev/ram0 /mnt
> > dd if=/dev/zero of=/mnt/junk bs=1024 count=500000
>
> Why turn on ramfs if you're not going to use it?
>
Actually I experimented with both ext2 and ramfs, getting similar
results.  I forgot to mention that in the post though.

