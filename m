Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbQLFQFu>; Wed, 6 Dec 2000 11:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129507AbQLFQFj>; Wed, 6 Dec 2000 11:05:39 -0500
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:31475 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S129406AbQLFQFa>; Wed, 6 Dec 2000 11:05:30 -0500
Date: Wed, 6 Dec 2000 10:35:01 -0500 (EST)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: Skip Collins <bernard.collins@jhuapl.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: system hang and corrupt ext2 filesystem with test12-pre5
In-Reply-To: <3A2E51B0.76C65771@jhuapl.edu>
Message-ID: <Pine.LNX.4.30.0012061032210.19876-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd be more inclined to think its the combination of drive/controller
more than an ext2fs problem. If it was a fs corruption issue, you should
still see it on the slower bus.

On Wed, 6 Dec 2000, Skip Collins wrote:
> I have a 900MHz Athlon/Asus A7V mobo system with an onboard ata100
> promise controller. I have only had problems when my ata100/udma5
> harddrive is connected to the promise controller. Using the ATA66 ide
> bus eliminates the problem. I typically see the corruption when copying
> large (~1GB) files such as vmware virtual disks. It also happens
> frequently inside vmware when doing heavy disk access things like
> installing software or defragging a win2000 virtual disk.
>
> For now I am going to fall back to the slower ide bus. But I wanted to
> let people know that there still may be problems with ext2 corruption in
> the latest test kernel.
>

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
