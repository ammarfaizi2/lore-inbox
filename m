Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267517AbTGWKgq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 06:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267576AbTGWKgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 06:36:45 -0400
Received: from pizda.ninka.net ([216.101.162.242]:7569 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S267517AbTGWKgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 06:36:43 -0400
Date: Wed, 23 Jul 2003 03:48:22 -0700
From: "David S. Miller" <davem@redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: a.marsman@aYniK.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre7: are security issues solved?
Message-Id: <20030723034822.148d8f30.davem@redhat.com>
In-Reply-To: <20030723103901.GA2425@gondor.apana.org.au>
References: <Pine.LNX.4.44.0307212234390.3580-100000@localhost.localdomain>
	<E19fGMZ-0000Zm-00@gondolin.me.apana.org.au>
	<20030723033505.145db6b8.davem@redhat.com>
	<20030723103901.GA2425@gondor.apana.org.au>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jul 2003 20:39:01 +1000
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> On Wed, Jul 23, 2003 at 03:35:05AM -0700, David S. Miller wrote:
> > On Wed, 23 Jul 2003 19:56:47 +1000
> > Herbert Xu <herbert@gondor.apana.org.au> wrote:
> > If I know your password is 7 characters I have a smaller
> > space of passwords to search to just brute-force it.
> 
> Yes but can't you do the same thing with /proc/interrupts or
> /proc/net/dev? Why are we singling out the serial driver?

With the serial procfs thing, we know exactly that it is
characters.

With interrupts and network device statistics, we cannot make
such assumptions making attacks using these facilities much
less likely to be feasible.
