Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266978AbTATU2M>; Mon, 20 Jan 2003 15:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266979AbTATU2M>; Mon, 20 Jan 2003 15:28:12 -0500
Received: from quechua.inka.de ([193.197.184.2]:3480 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S266978AbTATU2K>;
	Mon, 20 Jan 2003 15:28:10 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: ANN: LKMB (Linux Kernel Module Builder) version 0.1.16
References: <25160.1042809144@passion.cambridge.redhat.com> <Pine.LNX.4.33L2.0301171857230.25073-100000@vipe.technion.ac.il> <E18a1aZ-0006mL-00@bigred.inka.de> <1042930522.15782.12.camel@laptop.fenrus.com>
Organization: private Linux site, southern Germany
Date: Mon, 20 Jan 2003 21:03:04 +0100
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E18ai8O-00032u-00@bigred.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Whoever invented this /lib/modules/... scheme should have known that
> > it provokes this sort of misunderstandings, not to mention is broken
> > in other ways too.
>
> it was Linus who decreed this to be the standard;)

no matter who decreed it. Even Linus may be wrong sometimes.

> yes, and most of the time you want to compile against the currently
> running kernel, at which point `uname -r` comes in handy; for other
> kernels you just change the path a bit.
> make install and make modules_install make the symlink right already....
> it's a 99% solution, sure, but it's ok for all but a few cases.

And what's exactly wrong with the other 99% solution of putting it in
/usr/src/linux-`uname -r` ? This has exactly the same advantages but
doesn't mix up between development and runtime environment; /usr/src
is clearly where source belongs and /lib/modules is an install target.

Even Linus has finally accepted that the root of the source tree is
best called linux-$VERSION rather than just linux, so this is not an
obstacle either.

Olaf

