Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261807AbRE1MLX>; Mon, 28 May 2001 08:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263034AbRE1MLE>; Mon, 28 May 2001 08:11:04 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:49561 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S261807AbRE1MK5>;
	Mon, 28 May 2001 08:10:57 -0400
Date: Mon, 28 May 2001 14:10:27 +0200 (CEST)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Andris Pavenis <pavenis@latnet.lv>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Danny ter Haar <dth@trinity.hoho.nl>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.4-ac[356]: network (8139too) related crashes
In-Reply-To: <200105280614.f4S6EE100410@hal.astr.lu.lv>
Message-ID: <Pine.LNX.4.21.0105281403550.13673-100000@tux.rsn.bth.se>
X-message-flag: Get yourself a real mail client! http://www.washington.edu/pine/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 May 2001, Andris Pavenis wrote:

> On Sunday 27 May 2001 02:34, Alan Cox wrote:
[snip]
> > Can you try 2.4.5 with the 8139too.c file from the 2.4.3-ac3 that works for
> > you and report on that
> 
> Done. 
> 
> Seems that taking 8139too.o from 2.4.3-ac3 fixes the problem. 
> 
> Tortured it much more as it was required to get 2.4.4-ac[356] and 2.4.5. to 
> freeze (FTP uploads and downloads totally more than 100Mb with speed about
> 600Kb/s, for bad version of 8138too.c about 10Mb was usually more than enough
> for freezing)

I've also been having problems with 2.4.4 (and 2.4.4-ac10).
But my problems havn't been very easy to trigger as sometimes it happens
after a few hours and sometimes after 4 days.

I have a 8139A card.

The machine ran 2.4.2-ac6 for a long time without any problems, and then I
switched to 2.4.4 and it hung after 1 day. It was a silent deadlock, it
didn't print anything on the screen and it didn't respond to anything.

Then I switched to the 8139too driver from 2.4.2-ac6 to see if it's
stable. It has 2 days of uptime now so I'll have to wait some more until
I can say if it's stable or not.

/Martin

