Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132859AbQK3LsY>; Thu, 30 Nov 2000 06:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132860AbQK3LsF>; Thu, 30 Nov 2000 06:48:05 -0500
Received: from max.phys.uu.nl ([131.211.32.73]:26634 "EHLO max.phys.uu.nl")
        by vger.kernel.org with ESMTP id <S132859AbQK3Lrz>;
        Thu, 30 Nov 2000 06:47:55 -0500
Date: Thu, 30 Nov 2000 12:17:26 +0100 (MET)
From: Dries van Oosten <D.vanOosten@phys.uu.nl>
To: <linux-kernel@vger.kernel.org>
Subject: /sbin/route problem with 2.4.0test
Message-ID: <Pine.OSF.4.30.0011301211290.9926-100000@ruunat.phys.uu.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have plowed my way trough the kernel-digest archives, but I couldn't
find an answer, so sorry if it's old news.
I have a machine running 2.4.0test8 and /sbin/route refuses to work. It
only prints the table headers and then nothing happens. I can stop it with
ctrl-c, but the actual routing table is not printed. I don't know much
about the changes between 2.2 and 2.4, so I looked up the routing table
struct in include/net/route.h. At first I thought the table remained the
same, because they were the same version. One closer inspection I found
that the entry inet_peer had been added to the rtable struct. Can this be
the cause of my problem with the route utility?
If so? What's the fix?

thanks for your patience,
Dries van Oosten


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
