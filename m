Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282904AbRLBRdL>; Sun, 2 Dec 2001 12:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281599AbRLBRdC>; Sun, 2 Dec 2001 12:33:02 -0500
Received: from [199.29.68.123] ([199.29.68.123]:4616 "EHLO MailAndNews.com")
	by vger.kernel.org with ESMTP id <S282904AbRLBRcq>;
	Sun, 2 Dec 2001 12:32:46 -0500
X-WM-Posted-At: MailAndNews.com; Sun, 2 Dec 01 12:32:35 -0500
Message-ID: <022601c17b57$548ef230$0500a8c0@myroom>
From: "Matt Schulkind" <mschulkind@mailandnews.com>
To: "lkml" <linux-kernel@vger.kernel.org>
Subject: AMD Viper IDE chipset
Date: Sun, 2 Dec 2001 12:32:35 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm currently using the Tyan Tiger mobo with the AMD Viper chipset. On past
kernels 2.4.14 and before definatly, hdparm -t gave me 3.8MB/s on my ATA100
drive. Using some IDE patch taht I'd found on the web, I was able to get to
28MB/s and 38MB/s with some tweaking. Now with the 2.4.16 kernel, I get
28MB/s which is a good improvement, but my drive is only being detected as
UDMA33, I have not tried forcing it to UDMA66 or UDMA100 like I had with the
IDE patch I found which had the same detecting problem. It seems that the
mode detection is broken, but the actual interface code is functioning.
Anyone else having similar problems? I'm using the IBM 60GB 75GXP drive.

-Matt Schulkind

