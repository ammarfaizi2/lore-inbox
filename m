Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129162AbQKEWoK>; Sun, 5 Nov 2000 17:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129912AbQKEWoA>; Sun, 5 Nov 2000 17:44:00 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18496 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129162AbQKEWnp>; Sun, 5 Nov 2000 17:43:45 -0500
Subject: Re: [PATCH] Re: Negative scalability by removal of
To: dean-list-linux-kernel@arctic.org (dean gaudet)
Date: Sun, 5 Nov 2000 22:43:46 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0011051219030.22526-100000@twinlark.arctic.org> from "dean gaudet" at Nov 05, 2000 12:21:54 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13sYVx-0005fB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> oh, someone reminded me of the other reason sysvsems suck:  a cgi can grab
> the semaphore and hold it, causing a DoS.  of course folks could, and
> should use suexec/cgiwrap to avoid this.

The same cgi can killall -STOP httpd
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
