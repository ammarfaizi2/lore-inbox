Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268096AbRGVXIK>; Sun, 22 Jul 2001 19:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268097AbRGVXIB>; Sun, 22 Jul 2001 19:08:01 -0400
Received: from Expansa.sns.it ([192.167.206.189]:45574 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S268096AbRGVXHq>;
	Sun, 22 Jul 2001 19:07:46 -0400
Date: Mon, 23 Jul 2001 01:07:49 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: "Alan J. Wylie" <alan.nospam@glaramara.freeserve.co.uk>
cc: <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: ipt_unclean: TCP flags bad: 4
In-Reply-To: <15195.5892.311474.400006@glaramara.freeserve.co.uk>
Message-ID: <Pine.LNX.4.33.0107230106550.1542-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

This is normale behaviour, if with 2.4.7 kernel
this rule acts this way, that means it does work.
are you telling me you see this behavious with kernel 2.4.7?

Luigi

On Sun, 22 Jul 2001, Alan J. Wylie wrote:

> On Sun, 22 Jul 2001 19:51:43 +0200 (CEST), Luigi Genoni <kernel@Expansa.sns.it> said:
>
> > There was a bug introduced with kernel 2.4.6, but it was solved with
> > one of the latest 2.4.7-pre patch, i do not remember which one.
>
> > actually i was happily using tcp_unclean on my production servers,
> > but with 2.4.6 i was forced to avoid it.  I still have to try 2.4.7
> > to see if it works properly.
>
> > If you use a rule like
>
> > iptables -A INPUT -m unlean -j DROP
>                        ^^^^^^
> unclean, unclean <ding> ;-)
>
> > are you still able to connect in/out of your box?
>
> $MYIPTABLES --append INPUT   --match unclean --jump DROP
>
> has been at the start of my rules for a long time. I wasn't seeing
> any *serious* problems browsing the web, etc., but was getting a few
> "unable to connect to host" pages. Some of them went away on refresh,
> but some sites I just couldn't get to. On the other hand, that's
> normal for the Internet.
>
> --
> Alan J. Wylie                        http://www.glaramara.freeserve.co.uk/
> "Perfection [in design] is achieved not when there is nothing left to add,
> but rather when there is nothing left to take away."
>   Antoine de Saint-Exupery
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

