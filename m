Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267614AbSLGEac>; Fri, 6 Dec 2002 23:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267615AbSLGEac>; Fri, 6 Dec 2002 23:30:32 -0500
Received: from imrelay-2.zambeel.com ([209.240.48.8]:53010 "EHLO
	imrelay-2.zambeel.com") by vger.kernel.org with ESMTP
	id <S267614AbSLGEab>; Fri, 6 Dec 2002 23:30:31 -0500
Message-ID: <233C89823A37714D95B1A891DE3BCE5202AB1AD7@xch-a.win.zambeel.com>
From: Manish Lachwani <manish@Zambeel.com>
To: "'Z F'" <mail4me9999@yahoo.com>, linux-kernel@vger.kernel.org
Subject: RE: CPU cache problem
Date: Fri, 6 Dec 2002 20:37:57 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Did you check in the BIOS if there is an L2 cache size mentioned? Not every
BIOS supports it but you shoud check there ...

Thanks
-Manish

-----Original Message-----
From: Z F [mailto:mail4me9999@yahoo.com]
Sent: Friday, December 06, 2002 8:32 PM
To: linux-kernel@vger.kernel.org
Subject: CPU cache problem


Hello everybody

Sorry to bother you with such a question, but I have a 
Intel 1.7GHz Celeron processor with ASUS P4S533 motherboard.
The problem I have is that cat /proc/cpuinfo reports that

cache size      : 20 KB

As far as I know, the CPU has 128K L2 cache.

The kernel version installed on my computer is 2.4.18.
I tried using cachesize=128 as a boot parameter, but it did not help.
L2 cache is enabled in BIOS.

Could someone tell me why it is happening, how to fix it and should I
be
worried that the motherboard is defective.

Thank you very much for your kind help

Lazar

__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
