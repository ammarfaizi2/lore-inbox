Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbRBBVkK>; Fri, 2 Feb 2001 16:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129049AbRBBVkA>; Fri, 2 Feb 2001 16:40:00 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:32201 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129413AbRBBVju>; Fri, 2 Feb 2001 16:39:50 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200102022139.f12LdII21148@devserv.devel.redhat.com>
Subject: Re: [reiserfs-list] Re: ReiserFS Oops (2.4.1, deterministic, symlink
To: john@vmlinux.net (John Morrison)
Date: Fri, 2 Feb 2001 16:39:18 -0500 (EST)
Cc: reiser@namesys.com (Hans Reiser), alan@redhat.com (Alan Cox),
        mason@suse.com (Chris Mason), kas@informatics.muni.cz (Jan Kasprzak),
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
        yura@yura.polnet.botik.ru (Yury Yu. Rupasov)
In-Reply-To: <Pine.LNX.4.30.0102022126300.883-100000@vaio.vmlinux.net> from "John Morrison" at Feb 02, 2001 09:34:12 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It makes sense to refuse to build a piece of the kernel if it break's
> a machine - anything else is a timebomb waiting to explode.
 
The logical conclusion of that is to replace the entire kernel tree with

#error "compiler or program might have a bug. Aborting"

The kernel is NOT some US home appliance festooned with 'do not eat this
furniture' and 'do not expose your laserwrite to naked flame' messages.
The readme says its been tested with egcs-1.1.2 and gcc 2.95.

The same people who can't read documentation will just mail the list with
'it doesnt compile, help' or 'it doesnt compile, you suck' in less enlightened
cases/

Large numbers of people routinely build the kernel with 'unsupported' compilers
notably the pgcc project people and another group you will cause problems for 
- the GCC maintainers. They use the kernel tree as part of the test set for
their kernel, something putting #ifdefs all over it will mean they have to
mess around to fix too.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
