Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263769AbUIVLiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbUIVLiJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 07:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264704AbUIVLiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 07:38:09 -0400
Received: from chaos.analogic.com ([204.178.40.224]:36224 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263769AbUIVLiF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 07:38:05 -0400
Date: Wed, 22 Sep 2004 07:36:47 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Marc Ballarin <Ballarin.Marc@gmx.de>, Linus Torvalds <torvalds@osdl.org>,
       netfilter-devel@lists.netfilter.org,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] Warn people that ipchains and ipfwadm are going away.
In-Reply-To: <1095803902.1942.211.camel@bach>
Message-ID: <Pine.LNX.4.53.0409220735080.2066@chaos.analogic.com>
References: <1095721742.5886.128.camel@bach>  <20040921143613.2dc78e2f.Ballarin.Marc@gmx.de>
 <1095803902.1942.211.camel@bach>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Sep 2004, Rusty Russell wrote:

> On Tue, 2004-09-21 at 22:36, Marc Ballarin wrote:
> > On Tue, 21 Sep 2004 09:09:02 +1000
> > "Rusty Russell (IBM)" <rusty@au1.ibm.com> wrote:
> >
> > > Name: Warn that ipchains and ipfwadm are going away
> > > Status: Trivial
> > > Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> >
> > Isn't a compile-time warning a bit "soft"? Especially when compilation of
> > a kernel easily produces > 100 warnings, as it does right now.
>
> Sure, but you have to start somewhere.  Next step will be #error.  Then
> finally remove the whole thing (I don't want to remove the whole thing
> to start with, since that would create a silent failure).
>
> Cheers,
> Rusty.
> --

What replaces the firewall stuff? It can't just "go away"!

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.

