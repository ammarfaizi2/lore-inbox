Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130356AbQK1RvT>; Tue, 28 Nov 2000 12:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130355AbQK1RvK>; Tue, 28 Nov 2000 12:51:10 -0500
Received: from nread2.inwind.it ([212.141.53.75]:1750 "EHLO relay4.inwind.it")
        by vger.kernel.org with ESMTP id <S130277AbQK1Ru7>;
        Tue, 28 Nov 2000 12:50:59 -0500
Message-Id: <3.0.6.32.20001128182352.00b5fa80@pop.tiscalinet.it>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Tue, 28 Nov 2000 18:23:52 +0100
To: "David S. Miller" <davem@redhat.com>
From: Lorenzo Allegrucci <lenstra@tiscalinet.it>
Subject: Re: lmbench on linux-2.4.0-test[4-11]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200011280957.BAA06040@pizda.ninka.net>
In-Reply-To: <3.0.6.32.20001128110817.00acae30@pop.tiscalinet.it>
 <3.0.6.32.20001128110817.00acae30@pop.tiscalinet.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01.57 28/11/00 -0800, you wrote:
>   Date:   Tue, 28 Nov 2000 11:08:17 +0100
>   From: Lorenzo Allegrucci <lenstra@tiscalinet.it>
>
>   Does anyone confirm this problem?
>
>Increase the space between the two numbers configured in
>/proc/sys/net/ipv4/ip_local_port_range, try a configuration
>such as:
>
>echo "32768 61000" >/proc/sys/net/ipv4/ip_local_port_range
>
>I bet the problem goes away then.

ip_local_port_range already comes with such configuration.
Anyhow, now even test1 shows the problem :-(
I can run lmbench on 2.2.x kernels only.
BTW, all local services (smtp, telnet etc) work well.
Any ideas?

--
Lorenzo
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
