Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129547AbQLEBch>; Mon, 4 Dec 2000 20:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130252AbQLEBcR>; Mon, 4 Dec 2000 20:32:17 -0500
Received: from [213.157.1.114] ([213.157.1.114]:24068 "EHLO server.dreamind")
	by vger.kernel.org with ESMTP id <S129547AbQLEBcJ>;
	Mon, 4 Dec 2000 20:32:09 -0500
Date: Tue, 5 Dec 2000 02:03:56 +0100 (CET)
From: Stefan Pfetzing <dreamind@dreamind.yi.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Posible Bug at page_alloc.c in the [2.4.0-test11] kernel
In-Reply-To: <20001205005159.12636.qmail@theseus.mathematik.uni-ulm.de>
Message-ID: <Pine.LNX.4.21.0012050159290.1148-100000@server.dreamind>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Am Tue, 5 Dec 2000 schrieb ehrhardt@mathematik.uni-ulm.de :

> On Tue, Dec 05, 2000 at 01:04:05AM +0100, Stefan Pfetzing wrote:
> > Hello,
> > 
> > I think i possibly foun a Bug in the Linux Kernel 2.4.0-test11.
> > I patched the kernel with the bttv driver 7.49 but nothing else.
> > My system was up for 5 1/2 days and than it crashed.
> > [ page_alloc: BUG at line 84 ]
> 
> That's interesting. Could you double check that you run 2.4.0-test11
> and not 2.4.0-test12preX? There has been at least one reports of this
> very bug and two others that look related. However, it looked like a
> test12-pre[34] problem - until now.
> 
no please believe me it IS 2.4.0-test11 
uname -a:
Linux server 2.4.0-test11 #3 Tue Nov 28 21:15:01 CET 2000 i586 unknow

> > [ ... ]
> > If i forgot anything (kernel config or anything else please mail me.
> 
> The compiler version you are using is always an interesting data point.
> But I doubt that this is the problem here.

the gcc is version 2.95.2
> 
>       Gruesse  Christian
> 
cu

dreamind

p.s.:please reply ALSO to my private address because I am NOT on the mailing-list.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
