Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbVITSAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbVITSAc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 14:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbVITSAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 14:00:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4000 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964785AbVITSAb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 14:00:31 -0400
Date: Tue, 20 Sep 2005 10:59:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: rmk+lkml@arm.linux.org.uk, penberg@cs.Helsinki.FI, viro@ftp.linux.org.uk,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: p = kmalloc(sizeof(*p), )
Message-Id: <20050920105939.3c9c5e39.akpm@osdl.org>
In-Reply-To: <1127239361.7763.3.camel@localhost.localdomain>
References: <20050918100627.GA16007@flint.arm.linux.org.uk>
	<84144f0205092004187f86840c@mail.gmail.com>
	<20050920114003.GA31025@flint.arm.linux.org.uk>
	<Pine.LNX.4.58.0509201501440.9304@sbz-30.cs.Helsinki.FI>
	<20050920123149.GA29112@flint.arm.linux.org.uk>
	<20050920101128.70fec697.akpm@osdl.org>
	<1127239361.7763.3.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> On Maw, 2005-09-20 at 10:11 -0700, Andrew Morton wrote:
> > Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > >
> > >  Since some of the other major contributors to the kernel appear to
> > >  also disagree with the statement, I think that the entry in
> > >  CodingStyle must be removed.
> > 
> > Nobody has put forward a decent reason for doing so.  
> 
> I've seen five decent reasons so far. Which of the reasons on the thread
> do you disagree with and why ?
> 

umm, the three reasons which you deleted from the mail to which you're
replying?

> "I want to grep for
> initialisations" is pretty pointless because a) it won't catch everything
> anyway and b) most structures are allocated and initialised at a single
> place and many of those which aren't should probably be converted to do
> that anyway.
>
> The broader point is that you're trying to optimise for the wrong thing. 
> We should optimise for those who read code, not for those who write it.
>

If you look back, your five reasons tend to address modifiability, not
readability.

