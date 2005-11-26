Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbVKZW4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbVKZW4I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 17:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbVKZW4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 17:56:08 -0500
Received: from hornet.berlios.de ([195.37.77.140]:51788 "EHLO
	hornet.berlios.de") by vger.kernel.org with ESMTP id S1750771AbVKZW4H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 17:56:07 -0500
From: Michael Frank <mhf@users.berlios.de>
Reply-To: mhf@users.berlios.de
To: David Brown <dmlb2000@gmail.com>
Subject: Re: linux-2.6.14.tar.bz2 permissions
Date: Sat, 26 Nov 2005 23:53:23 +0100
Cc: linux-kernel@vger.kernel.org
References: <9c21eeae0511261352u33e32343wf50062ba3038ef06@mail.gmail.com> <20051126223921.E7EF31AC3@hornet.berlios.de> <9c21eeae0511261441j7e4cc7c7ya99daaf1e437cb2a@mail.gmail.com>
In-Reply-To: <9c21eeae0511261441j7e4cc7c7ya99daaf1e437cb2a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
Message-Id: <20051126225656.04D3D1AC3@hornet.berlios.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
On Saturday 26 November 2005 23:41, David Brown wrote:
> > Check your umask and set it to 022 ;)
>
> it is, still comes up world read/write.

Sorry for my sleepy advise.

sudo umask 022
sudo tar jxf linux-2.6.14.1.tar.bz2 --no-same-permissions
ls -l linux-2.6.14.1

-rw-r--r--   1 root root 18693 Nov  8 20:22 COPYING
-rw-r--r--   1 root root 89223 Nov  8 20:22 CREDITS
drwxr-xr-x  53 root root  5208 Nov  8 20:22 Documentation
-rw-r--r--   1 root root  1258 Nov  8 20:22 Kbuild
-rw-r--r--   1 root root 60997 Nov  8 20:22 MAINTAINERS
-rw-r--r--   1 root root 43534 Nov  8 20:22 Makefile
-rw-r--r--   1 root root 14755 Nov  8 20:22 README
-rw-r--r--   1 root root  3065 Nov  8 20:22 REPORTING-BUGS
drwxr-xr-x  26 root root   632 Nov  8 20:22 arch
drwxr-xr-x   2 root root   968 Nov  8 20:22 crypto
drwxr-xr-x  22 root root   600 Nov 26 23:50 drivers
[snip]

>
> - David Brown
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to
> majordomo@vger.kernel.org More majordomo info at 
> http://vger.kernel.org/majordomo-info.html Please read
> the FAQ at  http://www.tux.org/lkml/
