Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317355AbSHaKuL>; Sat, 31 Aug 2002 06:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317359AbSHaKuL>; Sat, 31 Aug 2002 06:50:11 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:9391 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317355AbSHaKuL>;
	Sat, 31 Aug 2002 06:50:11 -0400
Date: Sat, 31 Aug 2002 12:54:16 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Mike Isely <isely@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-pre4-ac1 trashed my system
Message-ID: <20020831125416.A44888@ucw.cz>
References: <Pine.LNX.4.44.0208300206140.9431-100000@grace.speakeasy.net> <Pine.LNX.4.44.0208310002030.23964-100000@grace.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0208310002030.23964-100000@grace.speakeasy.net>; from isely@pobox.com on Sat, Aug 31, 2002 at 12:04:20AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 31, 2002 at 12:04:20AM -0500, Mike Isely wrote:
> 
> 
> > OK, I have some good news and some bad news.
> >
> > The bad news is that I replicated the corruption.
> >
> > The good news is that I replicated the corruption.  Oh, and I can
> > cause it on demand, and not lose my system in the process.  I can
> > provide LOTS and LOTS of details now.  What do you want to know?
> >
> 
>    [...]
> 
> I've done some more tests and have more information now.  No smoking
> gun yet, but a few more clues.
> 
> 1. I moved the 160GB drive away from the Promise controller and
>    reattached it to the motherboard chipset's controller ("VIA
>    Technologies, Inc. Bus Master IDE (rev 06)", by the way according
>    to lspci).  Then I booted 2.4.20-pre4-ac1 (the "bad" kernel) and
>    fsck'ed the big partition again.  It passed.  Then I moved the
>    drive back to the Promise controller, booted the same OS and
>    fsck'ed again.  Failure.
> 
> 2. I booted 2.4.19-ac4 with the 160GB drive attached to the Promise
>    controller and watched the kernel log output.  There's no message
>    about any missing 80 pin cable.  This is different than
>    2.4.20-pre4-ac1 which complains that I allegedly don't have an 80
>    pin cable plugged.  However the cable is there but the driver
>    downshifts the interface to 33MHz anyway.  I described this

Note that 33 MHz isn't 33 MB/sec (UDMA2). Question remains, what you wanted to
say.


-- 
Vojtech Pavlik
SuSE Labs
