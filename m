Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135306AbRAGAFd>; Sat, 6 Jan 2001 19:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135383AbRAGAFX>; Sat, 6 Jan 2001 19:05:23 -0500
Received: from pizda.ninka.net ([216.101.162.242]:60049 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S135306AbRAGAFO>;
	Sat, 6 Jan 2001 19:05:14 -0500
Date: Sat, 6 Jan 2001 15:47:51 -0800
Message-Id: <200101062347.PAA13598@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: rusty@linuxcare.com.au
CC: linux-kernel@vger.kernel.org
In-Reply-To: <E14EjHY-0005jK-00@halfway> (message from Rusty Russell on Sat,
	06 Jan 2001 13:40:35 +1100)
Subject: Re: PROBLEM: 2.4.0 Kernel Fails to compile when CONFIG_IP_NF_FTP is selected
In-Reply-To: <E14EjHY-0005jK-00@halfway>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Russell <rusty@linuxcare.com.au>
   Date: Sat, 06 Jan 2001 13:40:35 +1100

   CONFIG_IP_NF_FTP controls BOTH the ftp connection tracking and NAT
   code.  The correct fix is below (untested, but you get the idea).

I've applied this, it seems fine.  (I've also adapted it to the
pending IRC stuff, so you don't need to send me a fix for that
under seperate cover).

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
