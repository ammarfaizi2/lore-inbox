Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264797AbSLBEvR>; Sun, 1 Dec 2002 23:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264798AbSLBEvR>; Sun, 1 Dec 2002 23:51:17 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:53380 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S264797AbSLBEvQ>;
	Sun, 1 Dec 2002 23:51:16 -0500
Date: Mon, 2 Dec 2002 15:57:29 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "David S. Miller" <davem@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       anton@samba.org, ak@muc.de, davidm@hpl.hp.com, schwidefsky@de.ibm.com,
       ralf@gnu.org, willy@debian.org
Subject: Re: [PATCH] Start of compat32.h (again)
Message-Id: <20021202155729.55949b10.sfr@canb.auug.org.au>
In-Reply-To: <1038804400.4411.4.camel@rth.ninka.net>
References: <Pine.LNX.4.44.0212011047440.12964-100000@home.transmeta.com>
	<1038804400.4411.4.camel@rth.ninka.net>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 01 Dec 2002 20:46:40 -0800 "David S. Miller" <davem@redhat.com> wrote:
>
> On Sun, 2002-12-01 at 10:54, Linus Torvalds wrote:
> > But if the file is in kernel/xxxx, it 
> > will be noticed - at least as well as it would be if it was uglifying 
> > regular files with #ifdef's.
> 
> Ok, this I accept.

So, does this mean you are happy if I produce patches with kernel/compat.c
in them rather than code #ifdef'ed into the mainline? This, of course,
begs the question of whether it should all go into kernel/compat.c or
should there be an fs/compat.c, mm/compat.c ...

At the moment, I just want to get something that we all agree on past
Linus and into his tree.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
