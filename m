Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282200AbRK2Apd>; Wed, 28 Nov 2001 19:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282240AbRK2Ap1>; Wed, 28 Nov 2001 19:45:27 -0500
Received: from www.transvirtual.com ([206.14.214.140]:3853 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S282228AbRK2Ao6>; Wed, 28 Nov 2001 19:44:58 -0500
Date: Wed, 28 Nov 2001 16:44:38 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [PATCH] vc_tty addition
In-Reply-To: <E169FR1-0006jZ-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10111281644030.4098-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > accessing /dev/console only effects the first console in the list instead
> > of all of them. If this is true then that means /dev/consoel can exist
> > without /dev/tty which could be a good thing.
> 
> Currently the "console" doesn't need to include a tty device - if its only
> being hit with printk output. 

Then should we make TTY console aka /dev/console support a option?


