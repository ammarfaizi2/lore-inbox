Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316655AbSFUPOe>; Fri, 21 Jun 2002 11:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316659AbSFUPOd>; Fri, 21 Jun 2002 11:14:33 -0400
Received: from mta3.snet.net ([204.60.203.69]:39415 "EHLO mta3.snet.net")
	by vger.kernel.org with ESMTP id <S316655AbSFUPOc>;
	Fri, 21 Jun 2002 11:14:32 -0400
Date: Fri, 21 Jun 2002 11:14:25 -0400 (EDT)
From: "T.Raykoff" <traykoff@snet.net>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
cc: Taavo Raykoff <traykoff@snet.net>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18 IDE channels block each other under load?
In-Reply-To: <200206211617.14863.roy@karlsbakk.net>
Message-ID: <Pine.LNX.4.33.0206211113300.27258-100000@srv1.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes.  Baffling.  hdparm and prod/ide/hdx both show dma_mode is on.

Normally, I have these running with -X69 (UltraDMA 100)

TR.


On Fri, 21 Jun 2002, Roy Sigurd Karlsbakk wrote:

> On Friday 21 June 2002 16:03, Taavo Raykoff wrote:
> > Can someone tell me what is going on here?
> > <snip>
> > hdparm settings appear to have no influence on this behavior.
>
> Are you running DMA on these controllers? It looks like they're running PIO
>
> Can you check the output of 'hdparm /dev/hd_' and "cat
> /proc/ide/hd_/settings"?
> --
> Roy Sigurd Karlsbakk, Datavaktmester
>
> Computers are like air conditioners.
> They stop working when you open Windows.
>
>

