Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129199AbQKQVlq>; Fri, 17 Nov 2000 16:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129806AbQKQVli>; Fri, 17 Nov 2000 16:41:38 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:46605 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129199AbQKQVlZ>;
	Fri, 17 Nov 2000 16:41:25 -0500
Message-ID: <3A159EF1.E08E5368@mandrakesoft.com>
Date: Fri, 17 Nov 2000 16:11:13 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: becker@scyld.com, linux-kernel@vger.kernel.org, shangh@realtek.com.tw
Subject: Re: duplicate entries in rtl8129 driver
In-Reply-To: <200011172047.MAA03712@adam.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" wrote:
> 
>         Both linux-2.4.0-test12-pre6/drivers/net/rtl8129.c and
> Don Becker's version at ftp.sycld.com appear to have identical
> PCI device ID and vendor ID values for these two cards:

rtl8129 is going away as soon as humanly possible.  :)  RealTek sent me
a RTL8130 so I can test the MII stuff finally.

Note that those duplicate ids should be commented out of rtl8129.c,
also.

-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
