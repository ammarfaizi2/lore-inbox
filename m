Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129568AbRCLHt5>; Mon, 12 Mar 2001 02:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129569AbRCLHtr>; Mon, 12 Mar 2001 02:49:47 -0500
Received: from bart.one-2-one.net ([195.94.80.12]:4103 "EHLO
	bart.one-2-one.net") by vger.kernel.org with ESMTP
	id <S129568AbRCLHtj>; Mon, 12 Mar 2001 02:49:39 -0500
Date: Mon, 12 Mar 2001 08:50:23 +0100 (CET)
From: Martin Diehl <home@mdiehl.de>
To: Steven Walter <srwalter@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: IDE on 2.4.2
In-Reply-To: <20010311153752.A29108@hapablap.dyn.dhs.org>
Message-ID: <Pine.LNX.4.21.0103120118480.571-100000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 11 Mar 2001, Steven Walter wrote:

> > on insmod). This is with SiS5513 rev 208 IDE function from SiS5591
> > chipset with CONFIG_BLK_DEV_SIS5513 and autotune enabled (default).
> 
> I have this exact same chip on my board (a PCChips M599-LMR or something
> like that) which works flawlessly on 2.4.2, even with UDMA66.

Do you have CONFIG_BLK_DEV_SIS5513 and autotuning enabled at the
same time? Unless I enable them both it works flawlessly for me too - up
to UDMA33. In fact, I've never seen any docs claiming the 5591/5513 would
even provide UDMA66 support. How do you program the controler to do UDMA66
cycles?
Anyway, might be interesting to have a look at your lspci -d:5513 -vvvxxx
report from working UDMA33/66 setups!

Martin



