Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267020AbSLXAQt>; Mon, 23 Dec 2002 19:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267021AbSLXAQt>; Mon, 23 Dec 2002 19:16:49 -0500
Received: from smtp-01.inode.at ([62.99.194.3]:5345 "EHLO smtp.inode.at")
	by vger.kernel.org with ESMTP id <S267020AbSLXAQr> convert rfc822-to-8bit;
	Mon, 23 Dec 2002 19:16:47 -0500
Content-Type: text/plain; charset=US-ASCII
From: Patrick Petermair <black666@inode.at>
Reply-To: black666@inode.at
To: AnonimoVeneziano <voloterreno@tin.it>
Subject: Re: vt8235 fix, hopefully last variant
Date: Tue, 24 Dec 2002 01:26:46 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <20021219112640.A21164@ucw.cz> <200212232242.20382.black666@inode.at> <3E07A5AC.3060201@tin.it>
In-Reply-To: <3E07A5AC.3060201@tin.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212240126.46794.black666@inode.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AnonimoVeneziano:

> >What is it exactly that doesn't work? The patching, compiling,
> > booting, dma,...?
> >
> The patching .... it said something about HUNKS failed....

It's normal that Hunk 1 and 2 fail... Hunk 3 is the important one. So 
you can compile the kernel even with Hunks 1&2 failing.

Quote from Vojtech:
-----

> I tried the last patch, but it didn't work - I got Hunk messages:
> 
> starbase:/usr/src/linux-2.4.20# patch -p1 < vt8235-atapi 
> patching file drivers/ide/via82cxxx.c
> Hunk #1 FAILED at 1.
> Hunk #2 FAILED at 141.
> Hunk #3 succeeded at 283 (offset -57 lines).
> 2 out of 3 hunks FAILED -- saving rejects to file 
> starbase:/usr/src/linux-2.4.20# 

Since they're in comments only, you can ignore them.

-----

Patrick

