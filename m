Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133021AbRAXXMR>; Wed, 24 Jan 2001 18:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133046AbRAXXMH>; Wed, 24 Jan 2001 18:12:07 -0500
Received: from post.cnt.ru ([212.15.122.243]:46093 "EHLO post.cnt.ru")
	by vger.kernel.org with ESMTP id <S133021AbRAXXMA>;
	Wed, 24 Jan 2001 18:12:00 -0500
Date: Thu, 25 Jan 2001 02:11:49 +0300
From: "dobro.cnt" <dobro@cnt.ru>
X-Mailer: The Bat! (v1.34a) UNREG / CD5BF9353B3B7091
Reply-To: "dobro.cnt" <dobro@cnt.ru>
X-Priority: 3 (Normal)
Message-ID: <791.010125@cnt.ru>
To: linux-kernel@vger.kernel.org
CC: linux-alpha@vger.kernel.org
Subject: Problem with 2.4.0 and Nautilus
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have Alpha system based on AMD 751 & ALI 1543C chipset (Nautilus).
Since I compiled and boot kernel 2.4.0 problem appears.
1. don't work IDE DMA mode at all, only PIO
2. don't work eepro100 support for Intel Ethernet card - driver
reports I use non-busmaster slot (2.2.16 works fine)
3. many other issues such SCSI device hang up during insmod driver and
so on.

It seems there is problem with DMA, but 2.2.16 works fine. Any help?

Mike Pershin


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
