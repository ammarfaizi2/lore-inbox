Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129596AbQK1Km5>; Tue, 28 Nov 2000 05:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129863AbQK1Kmi>; Tue, 28 Nov 2000 05:42:38 -0500
Received: from pizda.ninka.net ([216.101.162.242]:33920 "EHLO pizda.ninka.net")
        by vger.kernel.org with ESMTP id <S129790AbQK1Kmf>;
        Tue, 28 Nov 2000 05:42:35 -0500
Date: Tue, 28 Nov 2000 01:57:13 -0800
Message-Id: <200011280957.BAA06040@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: lenstra@tiscalinet.it
CC: linux-kernel@vger.kernel.org
In-Reply-To: <3.0.6.32.20001128110817.00acae30@pop.tiscalinet.it> (message
        from Lorenzo Allegrucci on Tue, 28 Nov 2000 11:08:17 +0100)
Subject: Re: lmbench on linux-2.4.0-test[4-11]
In-Reply-To: <3.0.6.32.20001128110817.00acae30@pop.tiscalinet.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date:   Tue, 28 Nov 2000 11:08:17 +0100
   From: Lorenzo Allegrucci <lenstra@tiscalinet.it>

   Does anyone confirm this problem?

Increase the space between the two numbers configured in
/proc/sys/net/ipv4/ip_local_port_range, try a configuration
such as:

echo "32768 61000" >/proc/sys/net/ipv4/ip_local_port_range

I bet the problem goes away then.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
