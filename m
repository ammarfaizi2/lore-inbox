Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317403AbSFIIMB>; Sun, 9 Jun 2002 04:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317444AbSFIIMA>; Sun, 9 Jun 2002 04:12:00 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:16910
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317403AbSFIIMA>; Sun, 9 Jun 2002 04:12:00 -0400
Date: Sun, 9 Jun 2002 01:08:38 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Samium Gromoff <_deepfire@mail.ru>
cc: roy@karlsbakk.net, linux-kernel@vger.kernel.org
Subject: Re: CMD-649 support? (in a hurry - please help)
In-Reply-To: <E17GJ5i-000MBg-00@f5.mail.ru>
Message-ID: <Pine.LNX.4.10.10206090107120.2492-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You need to be aware that many drives now under report performance on seek
to lba0 and read on the whole device.  I suggest you retry on a partition.

On Fri, 7 Jun 2002, Samium Gromoff wrote:

> > > Yeah the Linux driver supports them, but CMD chips in general are
> > > pretty buggy...
> 
> > oh. anyone around with any experience with the 649?
>  --
> > Roy Sigurd Karlsbakk, Datavaktmester
> 
>  i have one. 2.4.19-pre3, 1x IBM 60GXP - 1 month
> or so of a stable usage.
>  also it runs faster on udma66 than on udma100, but thats beyond me... ;)
>  p166, 40M
>          mwdma2 - 11 MB/s
>          udma4 - 13.5 MB/s
>          udma5 - 11.5 MB/s
> 
> ---
> cheers,
>    Samium Gromoff
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

