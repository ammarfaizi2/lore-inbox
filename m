Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271734AbRHUQTC>; Tue, 21 Aug 2001 12:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271732AbRHUQSv>; Tue, 21 Aug 2001 12:18:51 -0400
Received: from relay01.cablecom.net ([62.2.33.101]:16143 "EHLO
	relay01.cablecom.net") by vger.kernel.org with ESMTP
	id <S271733AbRHUQSs>; Tue, 21 Aug 2001 12:18:48 -0400
Message-Id: <200108211618.f7LGIxk06055@mail.swissonline.ch>
Content-Type: text/plain; charset=US-ASCII
From: Christian Widmer <cwidmer@iiic.ethz.ch>
Reply-To: cwidmer@iiic.ethz.ch
To: Kristian <kristian@korseby.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: massive filesystem corruption with 2.4.9
Date: Tue, 21 Aug 2001 18:18:52 +0200
X-Mailer: KMail [version 1.3]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15ZC3L-0007s7-00@the-village.bc.nu> <3B8285A9.8030306@korseby.net>
In-Reply-To: <3B8285A9.8030306@korseby.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > If your disk is in UDMA33/66 mode you can pretty rule the 
>  > disk out as the data is protected
i think this should be with the promise driver.

>  > If you have a VIA chipset, especially if there is an SB Live! in the
>  > machine then that may be the cause (fixes in 2.4.8-ac, should be a fix
>  > in 2.4.9 but Linus tree also applies another bogus change but which
>  > should be harmless)
it was an intel LX chipset

that it is a memory problem i also don't belive. that ram work for over 2 year
with no errors found with memtest (memtset86, intels memtest) compiling
seveal times xfree86 and an many many times several kernels. 

and i never had any problems. until i tried the first time a 2.4.x kernel on 
the fileserver (that was 2.4.6). so i moved the fileserver back to 2.2.19.
