Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288692AbSADRPn>; Fri, 4 Jan 2002 12:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288691AbSADRPd>; Fri, 4 Jan 2002 12:15:33 -0500
Received: from opal.biophys.uni-duesseldorf.de ([134.99.176.7]:35044 "EHLO
	opal.biophys.uni-duesseldorf.de") by vger.kernel.org with ESMTP
	id <S280126AbSADRPZ>; Fri, 4 Jan 2002 12:15:25 -0500
Date: Fri, 4 Jan 2002 18:15:01 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: Who uses hdx=bswap or hdx=swapdata?
In-Reply-To: <Pine.GSO.4.21.0201041131010.12102-100000@vervain.sonytel.be>
Message-ID: <Pine.LNX.4.33.0201041751360.5790-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > For 2.5 would it perhaps be cleaner if we had a bswapping loop device. Sort
> > of very bad crypto mode ?
>
> Don't mention crypto, or Atari will come after us with the DMCA sword, claiming
> they deliberately implemented access control? ;-)

Caution - I recall that on some m68k boxes we had to further byteswap
specific parts of the identify data or they wouldn't make sense. The IDE
driver will still have to be aware of these exceptions. I can't recall the
particulars anymore - Geert?

Since hdx=swapdata only works on disks replacing this with a byteswapping
loop device sounds fine (loopback being used for anything
kernel-internally now :-)

	Michael

