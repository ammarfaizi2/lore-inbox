Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311942AbSCOFjk>; Fri, 15 Mar 2002 00:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311941AbSCOFja>; Fri, 15 Mar 2002 00:39:30 -0500
Received: from web12303.mail.yahoo.com ([216.136.173.101]:60251 "HELO
	web12303.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S311937AbSCOFjR>; Fri, 15 Mar 2002 00:39:17 -0500
Message-ID: <20020315053916.531.qmail@web12303.mail.yahoo.com>
Date: Thu, 14 Mar 2002 21:39:16 -0800 (PST)
From: Miao Qingjun <qjmiao@yahoo.com>
Subject: Intel IXP1200 and Linux
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, everybody,

I have problems to run linux from IXA SDK 2.01 onto
an old IXP1200 evaluation board (not IXM1200 board).
I made some config changes, but it does not boot.
The following is my modifications

.config:
   CONFIG_SPECTACLE_ISLAND --> CONFIG_EVAL_BOARD
arch/arm/boot/compressed/Makefile:
   ZTEXTADDR <- 0xc0808000
arch/arm/boot/compressed/head.S:
0xc4004000->0xc0804000 for page table address

drivers/char/serial_ixp1200.c:
38400->9600 for DEFAULT_BAUD

Can anyone figure out which changes I also need to
make?


Thank you




__________________________________________________
Do You Yahoo!?
Yahoo! Sports - live college hoops coverage
http://sports.yahoo.com/
