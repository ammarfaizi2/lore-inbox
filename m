Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130673AbRALSB7>; Fri, 12 Jan 2001 13:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130582AbRALSBt>; Fri, 12 Jan 2001 13:01:49 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:27152 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130027AbRALSBq>; Fri, 12 Jan 2001 13:01:46 -0500
Date: Fri, 12 Jan 2001 09:51:03 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andre Hedrick <andre@linux-ide.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: ide.2.4.1-p3.01112001.patch
In-Reply-To: <Pine.LNX.4.10.10101120054570.32320-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.10.10101120949040.1858-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Jan 2001, Andre Hedrick wrote:
> 
> Scratch that patch it has 2 typos that are in amd74xx.c 
> 
> will do it again..........

I will scratch your new patch too.

I want to see the code to handle the apparent VIA DMA bug. At this point,
preferably by just disabling DMA on VIA chipsets or something like that
(if it has only gotten worse since 2.2.x, I'm not interested in seeing any
experimental patches for it during early 2.4.x).

We've already had one major fs corruption due to this, I want that fixed
_first_.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
