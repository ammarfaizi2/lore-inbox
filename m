Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262164AbVEOJz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbVEOJz0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 05:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262658AbVEOJz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 05:55:26 -0400
Received: from fire.osdl.org ([65.172.181.4]:30629 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262164AbVEOJzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 05:55:16 -0400
Date: Sun, 15 May 2005 02:54:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc4-mm1
Message-Id: <20050515025429.11cda9a2.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0505151142520.2387@dragon.hyggekrogen.localhost>
References: <20050512033100.017958f6.akpm@osdl.org>
	<20050515012051.GJ9304@holomorphy.com>
	<20050514183051.38f97256.akpm@osdl.org>
	<Pine.LNX.4.62.0505151142520.2387@dragon.hyggekrogen.localhost>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <juhl-lkml@dif.dk> wrote:
>
> On Sat, 14 May 2005, Andrew Morton wrote:
> 
> > William Lee Irwin III <wli@holomorphy.com> wrote:
> > >
> > > On Thu, May 12, 2005 at 03:31:00AM -0700, Andrew Morton wrote:
> > >  > +uml-remove-elfh.patch
> > >  > +uml-critical-change-memcpy-to-memmove.patch
> > >  >  UML important updates
> > > 
> > >  uml-remove-elfh looks empty.
> > 
> > Yeah, I couldn't work out a way of generating a patch which removes a
> > zero-length file, so that's there as a reminder to ask Linus to remove the
> > thing by hand.
> > 
> This works :
> 
> --- linux-2.6.12-rc4-mm1-orig/include/asm-um/elf.h	2005-05-14 12:54:27.000000000 +0200
> +++ linux-2.6.12-rc4-mm1/include/asm-um/elf.h	2005-05-15 11:39:28.000000000 +0200
> @@ -0,0 +1 @@
> +
> --- linux-2.6.12-rc4-mm1/include/asm-um/elf.h	2005-05-15 11:39:28.000000000 +0200
> +++ /dev/null	2005-05-15 11:17:24.000000000 +0200
> @@ -1 +0,0 @@
> -

That's cheating, too.  Plus rediffing this patch will make it disappear.
