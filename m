Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271405AbTHHPfM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 11:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271408AbTHHPfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 11:35:12 -0400
Received: from chaos.analogic.com ([204.178.40.224]:6784 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S271405AbTHHPfE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 11:35:04 -0400
Date: Fri, 8 Aug 2003 11:34:31 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Timothy Miller <miller@techsource.com>
cc: Jasper Spaans <jasper@vs19.net>, Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Change all occurrences of 'flavour' to 'flavor'
In-Reply-To: <3F33BF33.8070601@techsource.com>
Message-ID: <Pine.LNX.4.53.0308081127160.502@chaos>
References: <20030807180032.GA16957@spaans.vs19.net>
 <Pine.LNX.4.53.0308072139320.12875@montezuma.mastecende.com>
 <20030808065230.GA5996@spaans.vs19.net> <3F33BF33.8070601@techsource.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Aug 2003, Timothy Miller wrote:

>
>
> Jasper Spaans wrote:
> > On Thu, Aug 07, 2003 at 09:42:37PM -0400, Zwane Mwaikambo wrote:
> >
> >
> >>>It changes all occurrences of 'flavour' to 'flavor' in the complete tree;
> >>>I've just comiled all affected files (that is, the config resulting from
> >>>make allyesconfig minus already broken stuff) succesfully on i386.
> >>
> >>Arrrgh! You can't be serious!
> >
> >
> > Yes, I am bloody serious; this patch might look purely cosmetic at first
> > sight.. yet, there's a technical reason for at least one part of it. Grep
> > and see the horror:
> >
> > $ egrep -ni 'flavou?r' fs/nfs/inode.c
> > [snip]
> > 1357:	rpc_authflavor_t authflavour;
> > [snip]
>
>
> Ah, for a moment, I was worried that someone was talking about text in
> comments.
>
> Yes, when it comes to spelling of words in variable and type names, I
> think it would be a good idea to be consistent.
>
> What is Linus's preferred spelling?  Let's use that.
>

It's a little past April Fool's day. What are you guys
smoking? Next, you'll want to change all the 'i's to
'y's and add 'ing'.

Certainly one might want to change:

	int TheVariableThatWillBeUsedAsACounter;

to..
	int i;

However, changing the spelling of a variable name is
absurd no matter how you look at it.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.

