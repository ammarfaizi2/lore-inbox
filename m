Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286324AbRLJRbh>; Mon, 10 Dec 2001 12:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286325AbRLJRb1>; Mon, 10 Dec 2001 12:31:27 -0500
Received: from mpdr0.detroit.mi.ameritech.net ([206.141.239.206]:20402 "EHLO
	mailhost.det.ameritech.net") by vger.kernel.org with ESMTP
	id <S286324AbRLJRbS>; Mon, 10 Dec 2001 12:31:18 -0500
Date: Mon, 10 Dec 2001 12:29:12 -0500 (EST)
From: volodya@mindspring.com
Reply-To: volodya@mindspring.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: mm question
In-Reply-To: <E16DU29-0002fl-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.20.0112101226500.17940-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 10 Dec 2001, Alan Cox wrote:

> > I don't want to move them - I just want to collect all that are free and
> > then try to free some more. 
> 
> How will you free them, you don't know who owns them. 

I think you misunderstood me - this allocation happens in response to the
system call _not_ in an interrupt handler. So it is ok to wait - as long
as needed. I was thinking of calling page swapper or something and perhaps
going after I/O buffers first. 

                               Vladimir Dergachev

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

