Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbRALJFE>; Fri, 12 Jan 2001 04:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbRALJEz>; Fri, 12 Jan 2001 04:04:55 -0500
Received: from [213.97.45.174] ([213.97.45.174]:21995 "EHLO pau.intranet.ct")
	by vger.kernel.org with ESMTP id <S129226AbRALJEo>;
	Fri, 12 Jan 2001 04:04:44 -0500
Date: Fri, 12 Jan 2001 10:04:37 +0100 (CET)
From: Pau <linux4u@wanadoo.es>
To: <linux-kernel@vger.kernel.org>
Subject: xircom_tulib_cb + NFS in 2.4.0 does not work
Message-ID: <Pine.LNX.4.30.0101120958020.1297-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Whan I write in a NFS mounted filesystem, after a few seconds I keep on
getting these messages:

tulip.c: outl_CSR6 too many attempts,csr5=0x60218140

A few moments later the eth interface stops working.
The only way to reactivate the network interface is:

ifdown eth0 && ifup eth0 && ifconfig eth0 -promisc

Any hints?

Pau

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
