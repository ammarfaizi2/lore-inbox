Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316621AbSE0NwG>; Mon, 27 May 2002 09:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316623AbSE0NwF>; Mon, 27 May 2002 09:52:05 -0400
Received: from spook.vger.org ([213.204.128.210]:41366 "HELO
	kenny.worldonline.se") by vger.kernel.org with SMTP
	id <S316621AbSE0NwF>; Mon, 27 May 2002 09:52:05 -0400
Date: Mon, 27 May 2002 16:29:15 +0200 (CEST)
From: me@vger.org
To: Tomas Szepe <szepe@pinerecords.com>
cc: Simen Timian Thoresen <simentt@dolphinics.no>,
        linux-kernel@vger.kernel.org
Subject: Re: /dev/hd[ijkl] only using udma (not udma 100)
In-Reply-To: <20020527092441.GA7155@beth.pinerecords.com>
Message-ID: <Pine.LNX.4.21.0205271626570.7794-100000@kenny.worldonline.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 May 2002, Tomas Szepe wrote:

> > It would realy be nice to find a way to force transfer mode on boot up but
> > i cant see to find any way.
> 
> I've been using "ide2=ata66" to force ATA66/ATA100 transfer modes
> on a Promise Ultra100 TX2 controller.
> 

I might have worked for ide2 and 3 but it didnt work for ide4 and 5.

But hdparm -X69 /dev works just fine, just bad that it isnt at boot up but
I will set it as soon as possible.

-X69 is UDMA 5 mode, funny thing is i can set it to UDMA 6 =) but there is
no speed change, just funny that the ide card takes that setting.

Thanks for all your help, this solution will cover my needs for the
moment.


