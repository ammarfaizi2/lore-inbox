Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272135AbRIENtG>; Wed, 5 Sep 2001 09:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272175AbRIENsz>; Wed, 5 Sep 2001 09:48:55 -0400
Received: from [145.254.154.249] ([145.254.154.249]:3823 "HELO schottelius.org")
	by vger.kernel.org with SMTP id <S272135AbRIENsp>;
	Wed, 5 Sep 2001 09:48:45 -0400
Message-ID: <3B962D05.F24DED64@pcsystems.de>
Date: Wed, 05 Sep 2001 15:47:49 +0200
From: Nico Schottelius <nicos@pcsystems.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Mares <mj@ucw.cz>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: problem: pc_keyb.h
In-Reply-To: <3B8FE42B.23804609@pcsystems.de> <20010831213050.A3217@albireo.ucw.cz> <3B929F72.28BAF955@pcsystems.de> <20010905104008.I751@ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

okay, convinced.
It wasn't possible to use gpm with 2.0 kernels
anymore, if pc_keyb.h was included.
So i copied the relevant parts to our header file

This will appear in gpm-1.19.5.

Nico

Martin Mares wrote:

> Hello!
>
> > Martin, can't you add the line I sent in the last mail ?
> > This would make it possible to include
> > pc_keyb.h into many programs directly.
>
> Please don't do that, user space programs depending on a particular version
> of kernel headers have already created a horrible mess, so outside the cases
> where you need to share a definition of some kernel<->userspace interface,
> kernel headers really shouldn't be used outside the kernel.
>
>                                 Have a nice fortnight
> --
> Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
> Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
> Don't take life too seriously
> -- you'll never get out of it alive.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



