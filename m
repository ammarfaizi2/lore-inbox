Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264715AbTAXTlY>; Fri, 24 Jan 2003 14:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264857AbTAXTlY>; Fri, 24 Jan 2003 14:41:24 -0500
Received: from rth.ninka.net ([216.101.162.244]:32940 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S264715AbTAXTlX>;
	Fri, 24 Jan 2003 14:41:23 -0500
Subject: Re: SSH Hangs in 2.5.59 and 2.5.55 but not 2.4.x, through Cisco PIX
From: "David S. Miller" <davem@redhat.com>
To: David C Niemi <lkernel2003@tuxers.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0301241237160.29548-100000@harappa.oldtrail.reston.va.us>
References: <Pine.LNX.4.44.0301241237160.29548-100000@harappa.oldtrail.reston.va.us>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 24 Jan 2003 12:29:24 -0800
Message-Id: <1043440164.16483.14.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-24 at 10:43, David C Niemi wrote:
> The system involved is a new Dell desktop with a P4/2.6 CPU and an
> integrated Intel E1000 NIC, being used at 100Mb full duplex
> (autonegotiated).

What happens if you comment out the enabling of
NETIF_F_TSO in drivers/net/e1000/e1000_main.c around
line 428?  Does the problem persist?

