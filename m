Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129245AbQKNB76>; Mon, 13 Nov 2000 20:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130347AbQKNB7s>; Mon, 13 Nov 2000 20:59:48 -0500
Received: from pizda.ninka.net ([216.101.162.242]:9863 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129245AbQKNB7g>;
	Mon, 13 Nov 2000 20:59:36 -0500
Date: Mon, 13 Nov 2000 17:14:44 -0800
Message-Id: <200011140114.RAA14493@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: tleete@mountain.net
CC: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
In-Reply-To: <3A1073B4.CDCA21DF@mountain.net> (message from Tom Leete on Mon,
	13 Nov 2000 18:05:24 -0500)
Subject: Re: Hard lockups solved
In-Reply-To: <3A1073B4.CDCA21DF@mountain.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Mon, 13 Nov 2000 18:05:24 -0500
   From: Tom Leete <tleete@mountain.net>

   Your net/ipv4/tcp.c patch from the NE2000 thread cured them even
   before I found the hardware fault. Has that patch gone to the
   queue? I recommend it.

The bugs I was "fixing" there were due to problems in wait queue
exclusivity nesting.  We instead fixed wait queue exclusivity nesting
so it actually worked in test11-pre3, can you see if by itself that
kernel does not show your problems too?

Thanks.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
