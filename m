Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751516AbWDBXHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbWDBXHO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 19:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbWDBXHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 19:07:14 -0400
Received: from mail.gmx.de ([213.165.64.20]:27608 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751516AbWDBXHM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 19:07:12 -0400
X-Authenticated: #9163084
Date: Mon, 3 Apr 2006 01:07:09 +0200
From: Marko Euth <letterdrop@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Ben Ford <ben@kalifornia.com>
Subject: Re: Who wants to test cracklinux??
Message-Id: <20060403010709.9f611253.letterdrop@gmx.de>
In-Reply-To: <1144017581.3066.34.camel@testmachine>
References: <20060328221223.80753cab.letterdrop@gmx.de>
	<20060328224929.GC5760@elf.ucw.cz>
	<44305193.5080408@kalifornia.com>
	<1144017581.3066.34.camel@testmachine>
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.13; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Apr 2006 00:39:41 +0200
Arjan van de Ven <arjan@infradead.org> wrote:

> On Sun, 2006-04-02 at 15:34 -0700, Ben Ford wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > Pavel Machek wrote:
> > > Hi!
> > >> I've written a small kernel module & shared object for kernel 2.6 to
> > >> enable the following for normal users:
> > >>
> > >> - inb()/outb()... via a wrapper function
> > > ioperm() does that already, no? You mean, you enable it for non-root,
> > > too? That's security hole.
> > 
> > My OS development classes have a lab of machines that run entirely as
> > root just for these reasons.  I think it's valid to allow these
> > operations as non-root in certain situations.  It is better than
> > running *everything* as root, no?

Yes, that's exactly what the whole module is meant for.

> 
> is there any difference? I mean... if you can outb you for all intents
> and purposes are root anyway ;) (like you can overwrite any memory in
> the system etc etc)
> 

Don't you think beeing root is a little bit more
easy than doing everything with outb??? ;))

