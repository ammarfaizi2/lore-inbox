Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317946AbSHBDMk>; Thu, 1 Aug 2002 23:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317947AbSHBDMk>; Thu, 1 Aug 2002 23:12:40 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13073 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317946AbSHBDMk>; Thu, 1 Aug 2002 23:12:40 -0400
Date: Thu, 1 Aug 2002 20:17:38 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Banai Zoltan <bazooka@emitel.hu>
cc: Alexander Viro <viro@math.psu.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.30
In-Reply-To: <20020802003832.GA439@bazooka.saturnus.vein.hu>
Message-ID: <Pine.LNX.4.44.0208012015291.16391-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 2 Aug 2002, Banai Zoltan wrote:
>
> But it does not boot,( nor does 2.5.24)
> with 2.5.30 it panics at PNP BIOS initalisation,

If the PNP BIOS panic is new (ie it didn't happen in 2.5.24), can you
write down the whole panic (and look up the symbols) and send that one to
Ingo Molnar <mingo@elte.hu>?

That would most likely be due to some of the GDT reorganizations that
happened for 2.5.30 due to the thread-local-storage patches.

		Linus

