Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129248AbQLEBWq>; Mon, 4 Dec 2000 20:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129547AbQLEBWg>; Mon, 4 Dec 2000 20:22:36 -0500
Received: from theseus.mathematik.uni-ulm.de ([134.60.166.2]:42967 "HELO
	theseus.mathematik.uni-ulm.de") by vger.kernel.org with SMTP
	id <S129248AbQLEBWa>; Mon, 4 Dec 2000 20:22:30 -0500
Message-ID: <20001205005159.12636.qmail@theseus.mathematik.uni-ulm.de>
From: ehrhardt@mathematik.uni-ulm.de
Date: Tue, 5 Dec 2000 01:51:59 +0100
To: Stefan Pfetzing <dreamind@dreamind.yi.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Posible Bug at page_alloc.c in the [2.4.0-test11] kernel
In-Reply-To: <Pine.LNX.4.21.0012050048090.930-100000@server.dreamind>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.21.0012050048090.930-100000@server.dreamind>; from dreamind@dreamind.yi.org on Tue, Dec 05, 2000 at 01:04:05AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2000 at 01:04:05AM +0100, Stefan Pfetzing wrote:
> Hello,
> 
> I think i possibly foun a Bug in the Linux Kernel 2.4.0-test11.
> I patched the kernel with the bttv driver 7.49 but nothing else.
> My system was up for 5 1/2 days and than it crashed.
> [ page_alloc: BUG at line 84 ]

That's interesting. Could you double check that you run 2.4.0-test11
and not 2.4.0-test12preX? There has been at least one reports of this
very bug and two others that look related. However, it looked like a
test12-pre[34] problem - until now.

> [ ... ]
> If i forgot anything (kernel config or anything else please mail me.

The compiler version you are using is always an interesting data point.
But I doubt that this is the problem here.

      Gruesse  Christian

-- 

THAT'S ALL FOLKS!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
