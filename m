Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270820AbRHNUbZ>; Tue, 14 Aug 2001 16:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270808AbRHNUbH>; Tue, 14 Aug 2001 16:31:07 -0400
Received: from [209.202.108.240] ([209.202.108.240]:26121 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S270824AbRHNUa6>; Tue, 14 Aug 2001 16:30:58 -0400
Date: Tue, 14 Aug 2001 16:30:38 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: memory compress tech...
In-Reply-To: <Pine.LNX.4.30.0108142134090.5059-100000@Appserv.suse.de>
Message-ID: <Pine.LNX.4.33.0108141541020.31226-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2001, Dave Jones wrote:

> On Tue, 14 Aug 2001, Ignacio Vazquez-Abrams wrote:
>
> > > maybe for compressing swap?  you have to read less data off the disk,
> > > which is faster.  and the processor is probably idling anyway, waiting on
> > > disk.
> > Ah, now THAT is a good idea.
>
> I missed the beginning of this thread, but this sounds to me like
> what is being implemented at http://linuxcompressed.sourceforge.net/
>
> regards,
>
> Dave.

The original message talked about duplicating QEMM's MagnaRAM (a RAM
compression utility) under Linux, which seems to be part of what the page at
the URL describes. They say that they're not aiming for performance right now,
and I can believe that (their numbers are quite iffy).

They also do go over compressed swap, and after looking at point IV in section
4 of their design considerations, they seem to be headed in the right
direction.

I think maybe I'll go help...

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>





