Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136506AbRA1OAZ>; Sun, 28 Jan 2001 09:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136919AbRA1OAP>; Sun, 28 Jan 2001 09:00:15 -0500
Received: from lilly.ping.de ([62.72.90.2]:52999 "HELO lilly.ping.de")
	by vger.kernel.org with SMTP id <S136506AbRA1OAA>;
	Sun, 28 Jan 2001 09:00:00 -0500
From: Stefan Meyknecht <sm@voyager.ping.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Oops accessing file on 2048 bytes/sector vfat MO in 2.4.0
In-Reply-To: <Pine.LNX.3.96.1010128020616.3321A-100000@yksi>
User-Agent: tin/1.4.2-20000205 ("Possession") (UNIX) (Linux/2.2.18 (i686))
Message-Id: <E14MsKN-00006E-00@voyager.ping.de>
Date: Sun, 28 Jan 2001 14:57:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.3.96.1010128020616.3321A-100000@yksi> you wrote:
> ... and on a fair number < 2.4.0. The patch below will give you (dog slow)
> read access to your FAT MOs. Apply in fs/fat/. And don't even think about
> write() and mmap().

Thanks for the patch! The oops is gone, but now after reading a file from the MO-disk
I receive an I/O error even though the file is successfully copied. Writing to the 
MO-disk freezes the system!

Regards

Stefan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
