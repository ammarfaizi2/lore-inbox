Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131015AbRAaJ2P>; Wed, 31 Jan 2001 04:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131245AbRAaJ14>; Wed, 31 Jan 2001 04:27:56 -0500
Received: from pop.gmx.net ([194.221.183.20]:15256 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S131015AbRAaJ1t>;
	Wed, 31 Jan 2001 04:27:49 -0500
Message-ID: <3A77DA8D.79E6B643@gmx.de>
Date: Wed, 31 Jan 2001 10:27:41 +0100
From: Martin Rauh <martin.rauh@gmx.de>
X-Mailer: Mozilla 4.6 [de] (WinNT; U)
X-Accept-Language: de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Ethernet Flow Control and Linux IP Stack
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

what will happen in the (IP) protocol layer of the kernel
if the NIC can not send the packet,
because the NIC is paused by the receiving station with Ethernet Flow
Control
PAUSE frames.
In other words, what are the consequences if netif_stop_queue is called
and netif_start_queue is not called for a noticeable time.

Cheers,

Martin Rauh

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
