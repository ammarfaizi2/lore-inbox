Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284366AbRLCIvu>; Mon, 3 Dec 2001 03:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284367AbRLCIth>; Mon, 3 Dec 2001 03:49:37 -0500
Received: from zeus.kernel.org ([204.152.189.113]:59564 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S284857AbRLCHo2>;
	Mon, 3 Dec 2001 02:44:28 -0500
Date: Sun, 2 Dec 2001 23:27:59 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Matt Schulkind <mschulkind@mailandnews.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: AMD Viper IDE chipset
In-Reply-To: <022601c17b57$548ef230$0500a8c0@myroom>
Message-ID: <Pine.LNX.4.10.10112022326410.30807-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Dec 2001, Matt Schulkind wrote:

> I'm currently using the Tyan Tiger mobo with the AMD Viper chipset. On past
> kernels 2.4.14 and before definatly, hdparm -t gave me 3.8MB/s on my ATA100
> drive. Using some IDE patch taht I'd found on the web, I was able to get to
> 28MB/s and 38MB/s with some tweaking. Now with the 2.4.16 kernel, I get
> 28MB/s which is a good improvement, but my drive is only being detected as
> UDMA33, I have not tried forcing it to UDMA66 or UDMA100 like I had with the
> IDE patch I found which had the same detecting problem. It seems that the
> mode detection is broken, but the actual interface code is functioning.
> Anyone else having similar problems? I'm using the IBM 60GB 75GXP drive.
> 
> -Matt Schulkind

NAH, You just need the rest of my code but nobody is adopting it.
My code base on top on any kernel tested to date will give you that 25%
boost.

Cheers,

Andre Hedrick
Linux ATA Development

