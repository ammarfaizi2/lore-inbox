Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265385AbSLVU6f>; Sun, 22 Dec 2002 15:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265409AbSLVU6f>; Sun, 22 Dec 2002 15:58:35 -0500
Received: from smtp.comcast.net ([24.153.64.2]:19612 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S265385AbSLVU6b>;
	Sun, 22 Dec 2002 15:58:31 -0500
Date: Sun, 22 Dec 2002 16:11:37 -0500
From: Joshua Stewart <joshua.stewart@comcast.net>
Subject: From __cpu_raise_softirq() to net_rx_action()
To: linux-kernel@vger.kernel.org
Message-id: <1040591503.11608.6.camel@localhost.localdomain>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10)
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm still trying to follow a packet (or even better an sk_buff) from the
NIC card to user space.  I think I have a good chunk of it figured out,
but I'm missing a bit from the time that the __netif_rx_schedule()
routine calls __cpu_raise_softirq() until the routine net_rx_action()
occurs.  I read in a book on Linux TCP/IP implementation that the
softirq basically leads to a call to net_rx_action(), but I don't see
the connection yet.  It's probably due to my lack of understanding of
IRQ's (and software IRQ's).

Any help is appreciated.

Thanks,
	Josh 



