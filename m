Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287619AbSALWlV>; Sat, 12 Jan 2002 17:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287625AbSALWlH>; Sat, 12 Jan 2002 17:41:07 -0500
Received: from colorfullife.com ([216.156.138.34]:15634 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S287619AbSALWlB>;
	Sat, 12 Jan 2002 17:41:01 -0500
Message-ID: <3C40BB5E.8AB0A44F@colorfullife.com>
Date: Sat, 12 Jan 2002 23:40:30 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.2-pre11 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: Who uses hdx=bswap or hdx=swapdata?
In-Reply-To: <E16MRjQ-0003Sb-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > IIRC it's used to access non-Atari IDE disks on Atari (which has a byte-swapped
> > IDE interface) and vice-versa.
> >
> > So yes, you can use it on SMP machines, to access disks that were used before
> > on Atari.
> 
> For 2.5 would it perhaps be cleaner if we had a bswapping loop device. Sort
> of very bad crypto mode ?

I tried to implement that, but hdx=bswap operates on drives, and loop on
partitions. Do you have another idea? It probably has to wait until the
partition code is further cleaned up.

--
	Manfred
