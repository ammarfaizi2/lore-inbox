Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268712AbRHKSwR>; Sat, 11 Aug 2001 14:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268714AbRHKSwG>; Sat, 11 Aug 2001 14:52:06 -0400
Received: from pf107.gdansk.sdi.tpnet.pl ([213.77.129.107]:26639 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP
	id <S268712AbRHKSvt>; Sat, 11 Aug 2001 14:51:49 -0400
Subject: PC keyboard unknown scancodes (Power, Sleep, Wake)
To: linux-kernel@vger.kernel.org
Date: Sat, 11 Aug 2001 20:51:46 +0200 (CEST)
X-Mailer: ELM [version 2.4ME+ PL89 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E15VdrR-0000LQ-00@mm.amelek.gda.pl>
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

these three keys (on a cheap no-name "Designed for Win*" keyboard ;)
produce "unknown scancode" kernel messages when pressed or released.

Power - e0 5e
Sleep - e0 5f
Wake  - e0 63

I'd suggest adding support for them to linux/drivers/char/pc_keyb.c
but I'm not sure who maintains this file, so reporting this here...

Thanks,
Marek
