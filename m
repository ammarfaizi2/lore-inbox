Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129047AbQJ3L0R>; Mon, 30 Oct 2000 06:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129414AbQJ3L0H>; Mon, 30 Oct 2000 06:26:07 -0500
Received: from oe43.law11.hotmail.com ([64.4.16.15]:40457 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S129410AbQJ3LZ6>;
	Mon, 30 Oct 2000 06:25:58 -0500
X-Originating-IP: [24.164.154.68]
From: "Linux Kernel Developer" <linux_developer@hotmail.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <4309.972694843@ocs3.ocs-net> <20001029232347.D4EB081F9@halfway.linuxcare.com.au> <20001030050821.B9175@wire.cadcamlab.org>
Subject: Recommended compiler? - Re: [patch] kernel/module.c (plus gratuitous rant)
Date: Mon, 30 Oct 2000 06:19:16 -0500
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Message-ID: <OE43voFOAmEaJswFCHO000004ac@hotmail.com>
X-OriginalArrivalTime: 30 Oct 2000 11:25:52.0891 (UTC) FILETIME=[29A054B0:01C04264]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So which is the recommended compiler for each kernel version 2.2.x,
2.4.x(pre?) nowadays?  I've pretty much kept gcc 2.7.2.3 around just for
compiling the kernel however now I hear you need egcs to compile 2.4?  I
don't mind keeping 2.7.2.3 around in its own installation directory just for
the purpose of doing kernel work however from a previous post I've now got
the impression that egcs has become the recommended compiler?  If I'm going
to keep a secondary compiler around (outside of gcc 2.95.2 which I still
hear is no good for kernel compiles) just for kernel work I'd prefer to use
my disk space on the recommended one.

>
> [Rusty]
> > > CC=gcc-2723 make 2.0 kernel
> > > CC=gcc-2723 make 2.2 kernel
> > > CC=egcs make 2.4 kernel
> >
> > No, environment doesn't override make variables by default.  This
> > works on any shell:
> >
> > make CC=egcs <targets>
>
> If you're going to get pedantic, that won't work either -- since the
> makefiles in kernels 2.0 and 2.2 expect $(CC) to include some compiler
> flags.  This was fixed somewhere in 2.3.3x.
>
> Peter
> -


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
