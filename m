Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267340AbSLEPsO>; Thu, 5 Dec 2002 10:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267341AbSLEPsO>; Thu, 5 Dec 2002 10:48:14 -0500
Received: from herrmann.cherheim.etc.tu-bs.de ([134.169.163.222]:20229 "EHLO
	herrmann.priv.cher.sinus.tu-bs.de") by vger.kernel.org with ESMTP
	id <S267340AbSLEPsN>; Thu, 5 Dec 2002 10:48:13 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Felix Maibaum <f.maibaum@tu-bs.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20 locks up after ide init on tyan s2460
Date: Thu, 5 Dec 2002 16:55:43 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200212051655.43554.f.maibaum@tu-bs.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

fine-print first: I am sorry if this is a stupid question, I know you're all 
very busy, but I have no other explanation for this than a kernel bug, so 
here it goes:

I compiled 2.4.20 on my Tyan s2460 with 2 AMD XP1700+,
and after the ide init of the promise Ultra66 contoller I get the following 
message:

blk: queue c032d16c, I/O limit 4095Mb (mask 0xffffffff)

and the system locks up (no NumLock, no magic sysreq.).
This happened with the vanilla kernel as well as with the sources from debian.
To avoid an attachment I put my kernel config up at:

http://www.tu-bs.de/~y0013531/kernel_config_2.4.20

other hardware in the system is:
512M of main memory, 80G maxtor on hde, 30 and 45G IBM on hdg and hdh, this is 
the promise ultra66.
on the onboard controller there is a toshiba DVD, a plextor 12X CD/RW and a 
Pioneer DVD-R/RW,
NVIDIA Geforce2pro,
3com Boomerang 10/100 Ethernet
creative SBLive 1024

Since I don't subscribe to the list for traffic reasons, please cc me or 
answer directly. If more data is needed I'll be glad to provide it.

Thanks

Felix

