Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130051AbRCDNdN>; Sun, 4 Mar 2001 08:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130054AbRCDNdD>; Sun, 4 Mar 2001 08:33:03 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:60941 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130051AbRCDNcr>; Sun, 4 Mar 2001 08:32:47 -0500
Subject: Re: LILO error with 2.4.3-pre1...
To: sjhill@cotw.com
Date: Sun, 4 Mar 2001 13:35:19 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3AA19820.6A33E871@cotw.com> from "Steven J. Hill" at Mar 03, 2001 07:19:28 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14ZYfS-0005De-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    LILO version 21.4-4, Copyright (C) 1992-1998 Werner Almesberger
>    'lba32' extensions Copyright (C) 1999,2000 John Coffman
> 
>    Boot image: /boot/vmlinuz-2.4.3-pre1
>    Fatal: geo_comp_addr: Cylinder number is too big (1274 > 1023)
> 
> I have no idea why the 1023 limit is coming up considering 2.4.2 and
> LILO were working just fine together and I have a newer BIOS that has
> not problems detecting the driver properly. Go ahead, call me idiot :).

You need to specify the lba32 option in your config

