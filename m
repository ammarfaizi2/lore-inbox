Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281263AbRKESS0>; Mon, 5 Nov 2001 13:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281268AbRKESSQ>; Mon, 5 Nov 2001 13:18:16 -0500
Received: from mystery.lviv.net ([194.44.62.155]:8066 "EHLO mystery.lviv.net")
	by vger.kernel.org with ESMTP id <S281263AbRKESSD>;
	Mon, 5 Nov 2001 13:18:03 -0500
Date: Mon, 5 Nov 2001 20:17:44 +0200
From: "Volodymyr M . Lisivka" <lvm@mystery.lviv.net>
To: linux-kernel@vger.kernel.org
Cc: lvm@mystery.lviv.net
Subject: Oops in 2.4.13 - ide hotswap
Message-ID: <20011105201744.A24584@mystery.mystery.lviv.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.2.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I try to use hotswap feature with my hddrack.
But at first, I try to use this feature with
  plugged on hdd.

I use
kernel-2.4.13 (from kernel.org)
hdparm-4.1.3
and idectl from hdparm contrib.

I unmounted all partitions on my second hdd&DVD and executed
# idectl 1  rescan

It normaly unregisters my second IDE chanel then
registers it again, found my hdd&dvd and
throws Oops in

>> EIP; c01f6cee <ide_build_sglist+8e/130>   <=====

The experiment with SuSE-7.1/kernel-2.4.2 on my home computer
was finished successfully.

-- 
                       _   _  __ _
Best regards,        | | | |/ _` |  mailto:lvm@mystery.lviv.net
                      | |_| | (_| |
Volodymyr M. Lisivka  \__,_|\__,_|  ICQ#14549856
