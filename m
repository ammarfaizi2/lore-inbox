Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261637AbULZLXC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbULZLXC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 06:23:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbULZLWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 06:22:38 -0500
Received: from smtp.pochta.ru ([81.211.64.6]:48398 "EHLO smtp2.pochta.ru")
	by vger.kernel.org with ESMTP id S261634AbULZLWX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 06:22:23 -0500
X-Author: alamar@mail333.com from hotline4.alkar.net (hotline4.alkar.net [212.86.226.41]) via Free Mail POCHTA.RU
Date: Sun, 26 Dec 2004 13:20:47 +0200
From: Roman Ivanchukov <alamar@mail333.com>
To: Nick Warne <nick@linicks.net>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10 typo in include/linux/netfilter.h
Message-ID: <20041226132047.6ac71b4f@hotline4.alkar.net>
In-Reply-To: <200412261059.57661.nick@linicks.net>
References: <200412260917.38717.nick@linicks.net>
	<20041226023200.1bbf594d.davem@davemloft.net>
	<200412261059.57661.nick@linicks.net>
X-Mailer: Sylpheed-Claws 0.9.13 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Dec 2004 10:59:57 +0000
Nick Warne <nick@linicks.net> wrote:

> > > Line 161
> > >
> > > /* Call setsockopt() */
> > > int nf_setsockopt(struct sock *sk, int pf, int optval, char __user *opt,
> > >                   int len(;  <-------
> >
> > That doesn't exist in the 2.6.10 sources.  Something is
> > up with the source tree you have.  Lots of people would
> > be complaining if this simplistic error were actually
> > in the real 2.6.10 tree.
> 
> Yes, I thought strange, but this is the full tar.bz2 from kernel.org - I 
> downloaded this morning about 2 hours ago.
> 
> http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.10.tar.bz2
> 

I've just downloaded linux-2.6.10.tar.bz2 from kernel.org and there is no such
error in netfilter.h:

/* Call setsockopt() */
int nf_setsockopt(struct sock *sk, int pf, int optval, char __user *opt,
                  int len);


-- 
WBR, Roman

