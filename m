Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315443AbSELW0G>; Sun, 12 May 2002 18:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315447AbSELW0F>; Sun, 12 May 2002 18:26:05 -0400
Received: from sj-msg-core-2.cisco.com ([171.69.24.11]:28316 "EHLO
	sj-msg-core-2.cisco.com") by vger.kernel.org with ESMTP
	id <S315443AbSELW0F>; Sun, 12 May 2002 18:26:05 -0400
Message-Id: <5.1.0.14.2.20020513082205.03145ae8@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 13 May 2002 08:26:39 +1000
To: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: Tcp/ip offload card driver
Cc: john slee <indigoid@higherplane.net>,
        Linux Kernel Maillist <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0205121335050.14675-100000@filesrv1.baby-dra
 gons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IA32 isn't going to get you much more.  you need a new architecture.

300mbyte/sec is getting awfully close to real-life PCI limitations on IA32 
and real-world memory throughput
sure, the latest chipsets with DDR memory and memory-interleaving and 
things like HyperTransport, but they have an awful long way to reach your 
"order of magnitude".

i suspect you haven't reaized that "300MiB/sec" below means "300mbyte/sec" 
and not "300mbit/s".

At 01:36 PM 12/05/2002 -0400, Mr. James W. Laferriere wrote:

>         Hello John ,  Think about it ;-) .  Maybe an order of magnitude ?
>                 JimL
>
>On Sun, 12 May 2002, john slee wrote:
> > On Fri, May 10, 2002 at 10:51:06AM -0500, Nicholas Harring wrote:
> > > And how about when an SMP system isn't enough? Should I have to
> > > re-engineer my network storage architecture when hardware exists that'll
> > > increase throughput if a simple device driver gets written? Don't forget
> > > that with 64 bit PCI that the limit of the bus has been raised, and with
> >
> > jeff merkey has already demonstrated 300MiB/sec and higher speeds on x86
> > linux, with 3ware raid and dolphin sci cards.  how much faster do you
> > need to go?
> >
> > j.
> >
> > --
> > R N G G   "Well, there it goes again... And we just sit
> >  I G G G   here without opposable thumbs." -- gary larson
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
>        +------------------------------------------------------------------+
>        | James   W.   Laferriere | System    Techniques | Give me VMS     |
>        | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
>        | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
>        +------------------------------------------------------------------+
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

