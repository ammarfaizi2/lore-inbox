Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284285AbRLRRNk>; Tue, 18 Dec 2001 12:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284302AbRLRRNd>; Tue, 18 Dec 2001 12:13:33 -0500
Received: from mail8.cadvision.com ([207.228.64.93]:23303 "EHLO
	mail8.cadvision.com") by vger.kernel.org with ESMTP
	id <S284285AbRLRRN1>; Tue, 18 Dec 2001 12:13:27 -0500
Message-ID: <004701c187e7$b40c88c0$0100007f@localdomain.wni.com.wirelessnetworksinc.com>
From: "Herman Oosthuysen" <Herman@WirelessNetworksInc.com>
To: "Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        <linux-audio-dev@music.columbia.edu>
In-Reply-To: <Pine.LNX.4.33.0112172153410.2416-100000@penguin.transmeta.com> <200112181619.fBIGJBv13914@maila.telia.com>
Subject: Re: Scheduler ( was: Just a second ) ...
Date: Tue, 18 Dec 2001 10:16:16 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My tuppence worth from a real-time embedded perspective:
A shorter time slice and other real-time improvements to the scheduler will
certainly improve life to the embedded crowd.  Bear in mind that 90% of
processors are used for embedded apps.  Shorter time slices etc. means
smaller buffers, less RAM and lower cost.

I don't know what the current distribution is for Linux regarding embedded
vs data processing, but the embedded use of Linux is certainly growing
rapidly - we expect to make a million thingummyjigs running Linux next year
and there are many other companies doing the same.  Within the next few
years, I expect embedded use of Linux to overshadow data use by a large
margin.

Since embedded processors are 'invisible' and never in the news, I would be
very happy if Linus and others will keep us poor boys in mind...
--
Herman Oosthuysen
Herman@WirelessNetworksInc.com
Suite 300, #3016, 5th Ave NE,
Calgary, Alberta, T2A 6K4, Canada
Phone: (403) 569-5688, Fax: (403) 235-3965
----- Original Message ----- >
> Lets see: we have >1 GHz CPU and interrupts at >1000 Hz
>  => 1 Mcycle / interrupt - is that insane?
>
> If the hardware can support it? Why not let it? It is really up to the
> applications/user to decide...
>
> > Raising that min_fragment thing from 5 to 10 would make the minimum DMA
> > buffer go from 32 bytes to 1kB, which is a _lot_ more reasonable (what,
> > at 2*2 bytes per sample and 44kHz would mean that a 1kB DMA buffer
empties
> > in less than 1/100th of a second, but at least it should be < 200
irqs/sec
> > rather than >400).
> >
>
> /RogerL
>
> --
> Roger Larsson
> Skellefteå
> Sweden


