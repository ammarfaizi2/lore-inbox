Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131123AbRAWUua>; Tue, 23 Jan 2001 15:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130667AbRAWUuV>; Tue, 23 Jan 2001 15:50:21 -0500
Received: from alpha.netvision.net.il ([194.90.1.13]:37650 "EHLO
	alpha.netvision.net.il") by vger.kernel.org with ESMTP
	id <S131324AbRAWUuC>; Tue, 23 Jan 2001 15:50:02 -0500
Date: Wed, 24 Jan 2001 01:54:21 +0200 (GMT-2)
From: Idan Sofer <i_sofer@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: 815e hang update.
Message-ID: <Pine.LNX.3.96-heb-2.07.1010124013515.13298H-100000@laflaf>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I tried to start downloading without squid working. I started downloading
something big(Mozilla 0.7) to see what happends. The transfer hanged, but
this time, it did not take the rest of the system with it. the system
functioned just fine, but it did not recieve nor transmitted in/from the
eth0 device(even ping didn't work).

The greed LED in both the hub and the NIC suggested that the connection
was just fine.

ifconfig eth0 down
ifconfig eth0 up

brought the host back to the net, so it seems the NIC driver has to do
with the hangs somehow
(and indeed, the boot message suggest something which has to do with
"receiver lock-up bug workaround").



Idan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
