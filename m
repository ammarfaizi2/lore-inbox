Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287045AbSAGVHC>; Mon, 7 Jan 2002 16:07:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287051AbSAGVGw>; Mon, 7 Jan 2002 16:06:52 -0500
Received: from net128-053.mclink.it ([195.110.128.53]:2513 "EHLO
	mail.mclink.it") by vger.kernel.org with ESMTP id <S287045AbSAGVGl>;
	Mon, 7 Jan 2002 16:06:41 -0500
Message-ID: <3C3A0E04.9020909@arpacoop.it>
Date: Mon, 07 Jan 2002 22:07:16 +0100
From: Carl Scarfoglio <scarfoglio@arpacoop.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020105
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.2-pre9 - HD performance degradation
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ran hdparm -t on my disks and discovered an abysmal drop in hard disk 
performance since 2.5.2-pre1. Yesterday I ran fsck on all disks and it 
took more than three times as much to complete under 2.5.2-pre9 than 
usual. I am running SuSE 6.3, MB is Asus A7v, controller ATA 33 + 
Promise PDC 20265.
These are the results for a disk, (ATA 100 IBM 307030),for the other 
disks they are pretty the same.
Resuslts for "hdpam -t /dev/hdg"
Kernel 2.5.2-pre1 - 35 MB/sec
Kernel 2.5.2-pre4 - 15 MB/sec
Kernel 2.5.2-pre9 - 10 MB/sec
For the rest, it seems pretty stable, but I still get kernel panic on 
cold boots from the AHA 2904 (AIC7850).
Cheers,
		Carlo Scarfoglio

