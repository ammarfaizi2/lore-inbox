Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129730AbQLKTXD>; Mon, 11 Dec 2000 14:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129866AbQLKTWx>; Mon, 11 Dec 2000 14:22:53 -0500
Received: from web2006.mail.yahoo.com ([128.11.68.206]:61964 "HELO
	web2006.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129730AbQLKTWq>; Mon, 11 Dec 2000 14:22:46 -0500
Message-ID: <20001211185219.28022.qmail@web2006.mail.yahoo.com>
Date: Mon, 11 Dec 2000 10:52:19 -0800 (PST)
From: Tom Murphy <freyason@yahoo.com>
Subject: 2.4.0-test12-pre7 shutdowns and eepro100 woes
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

   test12-pre7 seems to randomly just power off my machine.
CONFIG_APM=y and CONFIG_APM_REAL_MODE_POWER_OFF=y as well. Could this
be what is
making it power off the machine randomly? Has it been fixed in pre8?

   I wasn't doing much on the machine at the time.. it just happens
sporadically.

   Also, regarding the eepro100 driver, are there any plans to fix
support for the following chipset (given by lspci):

02:08.0 Ethernet controller: Intel Corporation 82820 820 (Camino 2)
Chipset Ethernet (rev 01)

  I have one of these at work and I will get the following messages:

Dec 11 10:46:13 morpheus kernel: eepro100: cmd_wait for(0xffffff80)
+timedout with(0xffffff80)!
Dec 11 10:46:20 morpheus last message repeated 6 times

   (using eepro100 from 2.2.18pre27.. I guess it's not 2.2.18 proper)

  Thanks in advance,

	Tom

ps. please reply to my e-mail address. Thanks!
   

__________________________________________________
Do You Yahoo!?
Yahoo! Shopping - Thousands of Stores. Millions of Products.
http://shopping.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
