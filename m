Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLFQSt>; Wed, 6 Dec 2000 11:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129406AbQLFQSj>; Wed, 6 Dec 2000 11:18:39 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:11018 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S129183AbQLFQSf>; Wed, 6 Dec 2000 11:18:35 -0500
Message-ID: <3A2E5FAA.FF29E9D7@Hell.WH8.TU-Dresden.De>
Date: Wed, 06 Dec 2000 16:47:54 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Skip Collins <bernard.collins@jhuapl.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: system hang and corrupt ext2 filesystem with test12-pre5
In-Reply-To: <3A2E51B0.76C65771@jhuapl.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Skip Collins wrote:
> 
> I have a 900MHz Athlon/Asus A7V mobo system with an onboard ata100
> promise controller. I have only had problems when my ata100/udma5
> harddrive is connected to the promise controller. Using the ATA66 ide
> bus eliminates the problem. I typically see the corruption when copying
> large (~1GB) files such as vmware virtual disks. It also happens
> frequently inside vmware when doing heavy disk access things like
> installing software or defragging a win2000 virtual disk.

I also have an A7V and both of my IBM IDE drives are connected to the
Promise controller, running in UDMA-5 mode. There hasn't been any
corruption on either of the drives that had to do with UDMA-5 mode.
And the ext2 bugs that 2.4 kernels had, have been fixed in the latest
versions.

What drive are you using? AFAIR, Andre Hedrick once said certain Maxtor
drives aren't quite safe with DMA.

-Udo.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
