Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264060AbRFERq6>; Tue, 5 Jun 2001 13:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264061AbRFERqi>; Tue, 5 Jun 2001 13:46:38 -0400
Received: from 24.68.61.66.on.wave.home.com ([24.68.61.66]:11780 "HELO
	sh0n.net") by vger.kernel.org with SMTP id <S264060AbRFERq3>;
	Tue, 5 Jun 2001 13:46:29 -0400
Date: Tue, 5 Jun 2001 13:47:06 -0400 (EDT)
From: Shawn Starr <spstarr@sh0n.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: George Bonser <george@gator.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.6-pre1 unresolved symbols
In-Reply-To: <3B1CFB31.ABC11036@mandrakesoft.com>
Message-ID: <Pine.LNX.4.30.0106051347001.513-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks, Patch applied.

On Tue, 5 Jun 2001, Jeff Garzik wrote:

> Shawn Starr wrote:
> >
> > I have noticed unresolves symbols for the netfilter modules. this occurs
> > durning depmod -a.
>
> Note they are the same unresolved symbol.
>
> Ingo Molnar has posted a patch for this, entitled
> 	[patch] softirq-2.4.6-B4
>
> or you can edit kernel/ksyms.c yourself, and add the lines
>
> 	EXPORT_SYMBOL(do_softirq);
> 	EXPORT_SYMBOL(tasklet_schedule);
> 	EXPORT_SYMBOL(tasklet_hi_schedule);
>
> --
> Jeff Garzik      | An expert is one who knows more and more about
> Building 1024    | less and less until he knows absolutely everything
> MandrakeSoft     | about nothing.
>
>

