Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130988AbRCFQ33>; Tue, 6 Mar 2001 11:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131010AbRCFQ3S>; Tue, 6 Mar 2001 11:29:18 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:8458 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130988AbRCFQ3J>; Tue, 6 Mar 2001 11:29:09 -0500
Subject: Re: -ac11 sound card, anacron, suspend errors on Thinkpad A20p
To: Billy.Harvey@thrillseeker.net (Billy Harvey)
Date: Tue, 6 Mar 2001 16:31:41 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel),
        linux-thinkpad@www.bm-soft.com
In-Reply-To: <15013.1126.621871.683720@rhino.thrillseeker.net> from "Billy Harvey" at Mar 06, 2001 10:38:14 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14aKNC-0000yQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When using -ac11 (otherwise stable) I've noticed the following sound
> card messages when unplugging or plugging in my Thinkpad:

The cs46xx drivers do not support power management yet. If you want to play with
the test support edit cs46xx.c and add 

#define CS_46XX_PM 1

at the top
