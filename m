Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314042AbSDQDs3>; Tue, 16 Apr 2002 23:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314043AbSDQDs2>; Tue, 16 Apr 2002 23:48:28 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:56582
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S314042AbSDQDs2>; Tue, 16 Apr 2002 23:48:28 -0400
Date: Tue, 16 Apr 2002 20:47:49 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Josh McKinney <forming@comcast.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: AMD Athlon + VIA Crashing On Disk I/O
In-Reply-To: <20020417015525.GA3118@cy599856-a>
Message-ID: <Pine.LNX.4.10.10204162039350.11230-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Josh,

I think I have an answer why the crash but I need to verify with a client
as we are seeing the same problem on various VIA boards.  The good new is
we found on board that does not do this nasty.  So we are doing a
component wide comparisong of settings.

It is a really cool and smart embedded server found at

	http://www.nit.ca/

Cheers,

Andre Hedrick
LAD Storage Consulting Group


On Tue, 16 Apr 2002, Josh McKinney wrote:

> On approximately Tue, Apr 16, 2002 at 09:45:43PM -0200, Denis Vlasenko wrote:
> > >
> > > I get (when FSCK):
> > >
> > > spurious 8259A IRQ7
> > 
> > cat /proc/interrupts, is ther lots of ERR: interrupts?
> > 
> 
> I also get the spurious 8259A messages upon booting my Soyo Dragon+ board, KT266A chipset.
> Here is the output of /proc/interrupts:
> 
>          CPU0
>   0:    1146449          XT-PIC  timer
>   1:       1258          XT-PIC  keyboard
>   2:          0          XT-PIC  cascade
>   8:          1          XT-PIC  rtc
>  10:      10584          XT-PIC  eth0
>  11:          0          XT-PIC  es1370
>  12:         20          XT-PIC  PS/2 Mouse
>  14:         17          XT-PIC  ide0
>  15:      15193          XT-PIC  ide1
> NMI:          0
> LOC:    1146346
> ERR:         78
> MIS:          0
> 
> I am just curious as to what this means, I haven't seen any real problems with the board,
> except for everything wanting to go to IRQ 11, but that isn't a kernel issue.
> 
> Josh
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


