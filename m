Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129181AbRBBVul>; Fri, 2 Feb 2001 16:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129637AbRBBVuY>; Fri, 2 Feb 2001 16:50:24 -0500
Received: from vmlinux.demon.co.uk ([193.237.10.217]:27922 "EHLO vmlinux.net")
	by vger.kernel.org with ESMTP id <S129181AbRBBVuS>;
	Fri, 2 Feb 2001 16:50:18 -0500
Date: Fri, 2 Feb 2001 21:49:59 +0000 (GMT)
From: John Morrison <john@vmlinux.net>
To: Alan Cox <alan@redhat.com>
cc: Hans Reiser <reiser@namesys.com>, Chris Mason <mason@suse.com>,
        Jan Kasprzak <kas@informatics.muni.cz>, <linux-kernel@vger.kernel.org>,
        <reiserfs-list@namesys.com>,
        "Yury Yu. Rupasov" <yura@yura.polnet.botik.ru>
Subject: Re: [reiserfs-list] Re: ReiserFS Oops (2.4.1, deterministic, symlink
In-Reply-To: <200102022139.f12LdII21148@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.30.0102022148260.13975-100000@vmlinux.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Lets not go overboard Alan ;-)


> > It makes sense to refuse to build a piece of the kernel if it break's
> > a machine - anything else is a timebomb waiting to explode.
>
> The logical conclusion of that is to replace the entire kernel tree with
>
> #error "compiler or program might have a bug. Aborting"
>
> The kernel is NOT some US home appliance festooned with 'do not eat this
> furniture' and 'do not expose your laserwrite to naked flame' messages.
> The readme says its been tested with egcs-1.1.2 and gcc 2.95.
>
> The same people who can't read documentation will just mail the list with
> 'it doesnt compile, help' or 'it doesnt compile, you suck' in less enlightened
> cases/
>
> Large numbers of people routinely build the kernel with 'unsupported' compilers
> notably the pgcc project people and another group you will cause problems for
> - the GCC maintainers. They use the kernel tree as part of the test set for
> their kernel, something putting #ifdefs all over it will mean they have to
> mess around to fix too.
>
> Alan
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
