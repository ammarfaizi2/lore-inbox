Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAFBRx>; Fri, 5 Jan 2001 20:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129921AbRAFBRo>; Fri, 5 Jan 2001 20:17:44 -0500
Received: from pizda.ninka.net ([216.101.162.242]:51593 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129324AbRAFBRa>;
	Fri, 5 Jan 2001 20:17:30 -0500
Date: Fri, 5 Jan 2001 16:59:50 -0800
Message-Id: <200101060059.QAA09816@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: schu@schu.net
CC: linux-kernel@vger.kernel.org, rusty@linuxcare.com.au
In-Reply-To: <3A56653C.BF55B6E0@schu.net> (message from Matthew Schumacher on
	Fri, 05 Jan 2001 15:22:20 -0900)
Subject: Re: PROBLEM: 2.4.0 Kernel Fails to compile when CONFIG_IP_NF_FTP is selected
In-Reply-To: <3A56653C.BF55B6E0@schu.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You need to enable both CONNTRACK and full NAT in your configuration.

Rusty, why doesn't the Config stuff just enforece this if it
is necessary when enabling FTP support etc.?

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
