Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129183AbQK3MA7>; Thu, 30 Nov 2000 07:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129226AbQK3MAs>; Thu, 30 Nov 2000 07:00:48 -0500
Received: from [194.122.47.18] ([194.122.47.18]:6923 "EHLO msnexch2.rkes.de")
        by vger.kernel.org with ESMTP id <S129183AbQK3MAc>;
        Thu, 30 Nov 2000 07:00:32 -0500
Message-ID: <91571DF701C0D211B7CA00805F628DBE23358D@BER1_B01>
From: "Hinderling, Anselm" <Anselm.Hinderling@RKES.DE>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: /sbin/route problem with 2.4.0test
Date: Thu, 30 Nov 2000 12:34:34 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From:	Dries van Oosten [SMTP:D.vanOosten@phys.uu.nl]
> Sent:	Thursday, November 30, 2000 12:17 PM
> To:	linux-kernel@vger.kernel.org
> Subject:	/sbin/route problem with 2.4.0test
> 
> I have plowed my way trough the kernel-digest archives, but I couldn't
> find an answer, so sorry if it's old news.
> I have a machine running 2.4.0test8 and /sbin/route refuses to work. It
> only prints the table headers and then nothing happens. I can stop it with
> ctrl-c, but the actual routing table is not printed. I don't know much
> about the changes between 2.2 and 2.4, so I looked up the routing table
> struct in include/net/route.h. At first I thought the table remained the
> same, because they were the same version. One closer inspection I found
> that the entry inet_peer had been added to the rtable struct. Can this be
> the cause of my problem with the route utility?
> If so? What's the fix?
> 
have you ever tried "/sbin/route -n" (or even --help ;-)?

> thanks for your patience,
> Dries van Oosten
> 
> 
> 
> 
		anselm.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
