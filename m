Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129437AbQK3UhQ>; Thu, 30 Nov 2000 15:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129669AbQK3UhH>; Thu, 30 Nov 2000 15:37:07 -0500
Received: from jump-isi.interactivesi.com ([207.8.4.2]:31997 "HELO
        dinero.interactivesi.com") by vger.kernel.org with SMTP
        id <S129437AbQK3Ugz>; Thu, 30 Nov 2000 15:36:55 -0500
Date: Thu, 30 Nov 2000 14:06:28 -0600
From: Timur Tabi <ttabi@interactivesi.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10011301414520.18688-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <200011301803.eAUI3Pu16137@webber.adilger.net>
Subject: Re: Pls add this driver to the kernel tree !!
X-Mailer: The Polarbar Mailer; version=1.18; build=55
Message-Id: <20001130203703Z129437-440+118@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from Mark Hahn <hahn@coffee.psychology.mcmaster.ca> on Thu,
30 Nov 2000 14:16:16 -0500 (EST)


> > Actually, there is some benefit in leaving the LINUX_VERSION_CODE checks
> > there...  If someone wants to back-port the driver to 2.2, this makes it
> > much easier.  Also, some people like to maintain a single driver for all
> > of the kernel versions, so they don't have to bugfix each driver version.
> 
> backports hurt forward progress.

Not necessarily - it all depends on what your driver does.  In many cases,
supporting 2.2 and 2.4 is easy, and all you need are a few #if's.  It's
certainly much better to have a dozen or so #if's sprinkled throughout the code
than to have two separate source trees, and have to make the same change to
multiple files.

Kernel drivers that are not easy to maintain simply delay the release of each
kernel version.  Besides, code is back-ported from 2.4 to 2.2 all the time.


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

When replying to a mailing-list message, please direct the reply to the mailing list only.  Don't send another copy to me.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
