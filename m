Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbVAIMrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVAIMrp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 07:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVAIMrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 07:47:45 -0500
Received: from mail.dif.dk ([193.138.115.101]:27802 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261369AbVAIMrn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 07:47:43 -0500
Date: Sun, 9 Jan 2005 13:59:16 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Michal Feix <michal@feix.cz>
Cc: linux-kernel@vger.kernel.org, Tomasz Torcz <zdzichu@irc.pl>
Subject: Re: Conflicts in kernel 2.6 headers and {glibc,Xorg}
In-Reply-To: <41E1170D.6090405@feix.cz>
Message-ID: <Pine.LNX.4.61.0501091356580.3000@dragon.hygekrogen.localhost>
References: <41E0F76D.7080805@feix.cz> <20050109110805.GA8688@irc.pl>
 <41E1170D.6090405@feix.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jan 2005, Michal Feix wrote:

> > > First, I'm not on kernel mailing list so please CC any replies to me.
> > > Thank you.
> > > 
> > > Yesterday I was recompiling my Linux from Scratch distribution for the
> > > first time with Linux kernel 2.6.10 headers as a base for glibc. I've
> > > found, that glibc (and XOrg later on too) won't compile, as there is a
> > > conflict in certain functions or macros that glibc and Kernel headers both
> > > define.
> > 
> > 
> >  Are you using proper kernel headers - from
> > http://ep09.pld-linux.org/~mmazur/linux-libc-headers/ ?
> 
> No, I am not, because I wasn't told to do so. For meny years I always used
> vanilla sources from kernel.org for my /usr/include/... I wasn't told, that it
> is wrong and I still believe, that Linux kernel headers should be fixed by
> including these conflicting macros and functions into __KERNEL__ block
> instead. Or am I missing something?
> 
I think you'll find these links informative : 

http://www.kernelnewbies.org/faq/ 
- read the section entitled "What's going on with the kernel headers ?"

http://uwsg.iu.edu/hypermail/linux/kernel/0007.3/0587.html
- that's Linus' own explanation of the header issue.

http://groups-beta.google.com/group/linux.kernel/msg/9c467432e123860a?q=kernel+headers+user+space+group:linux.kernel&rnum=2
- a bit more from Linus


-- 
Jesper Juhl

