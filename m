Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130870AbRAOUZx>; Mon, 15 Jan 2001 15:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131308AbRAOUZn>; Mon, 15 Jan 2001 15:25:43 -0500
Received: from zeus.kernel.org ([209.10.41.242]:962 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130870AbRAOUZg>;
	Mon, 15 Jan 2001 15:25:36 -0500
Date: Mon, 15 Jan 2001 15:37:37 -0500 (EST)
From: Chris Meadors <clubneon@hereintown.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Delay in authentication.gy
In-Reply-To: <E14FkM5-0005Rv-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.31.0101151533480.19435-100000@rc.priv.hereintown.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2001, Alan Cox wrote:

> And have identical bad problems with auth failures. Right now I've given up
> trying to make 2.4 and YP mix because my RH setup assumes NIS auth will fail
> fast during boot up scripts and it doesnt.
>
> Unfortunately for the quickfix folks, Dave is right about needing to sort it,
> and that means someone has to sort glibc to use the new interfaces

I just compiled glibc 2.2.1 against the 2.4.0 kernel headers today.  I
went to the local console to login.  I was expecting to go get a coffee
after typing my password, but was pleasantly surprised to see the prompt
waiting for me in no time at all.

So the newest glibc seems to have the problem fixed for me now.

-Chris
-- 
Two penguins were walking on an iceberg.  The first penguin said to the
second, "you look like you are wearing a tuxedo."  The second penguin
said, "I might be..."                         --David Lynch, Twin Peaks

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
