Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317606AbSGXWfW>; Wed, 24 Jul 2002 18:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317611AbSGXWfW>; Wed, 24 Jul 2002 18:35:22 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:62206 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S317606AbSGXWfV>; Wed, 24 Jul 2002 18:35:21 -0400
Date: Wed, 24 Jul 2002 18:37:28 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200207242237.g6OMbSO10262@devserv.devel.redhat.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Safety of IRQ during i/o
In-Reply-To: <mailman.1027541521.16533.linux-kernel2news@redhat.com>
References: <mailman.1027541521.16533.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>[...]
> I would think that this would be safe when using DMA, and likely to be
> safe for PIO and more recent chipsets, but I wouldn't want to actually
> tell anyone that.

A little story from OLS. I have a 486/75 laptop, which can only
do PIO. It always was losing characters evern on 9600 baud on its
serial port, and I thought it was simply broken for five years.
A guy who did a security talk showed me that doing hdparm -u
fixes the problem. Apparently, the lappy has a non-buffering UART.

So, it seems that hdparm -u is a very useful thing for obsotele
boxes. If you do DMA, you probably do not care.

-- Pete
