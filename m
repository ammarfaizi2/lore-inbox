Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319446AbSH3FyZ>; Fri, 30 Aug 2002 01:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319445AbSH3FyY>; Fri, 30 Aug 2002 01:54:24 -0400
Received: from dp.samba.org ([66.70.73.150]:57534 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319440AbSH3FyY>;
	Fri, 30 Aug 2002 01:54:24 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Christoph Hellwig <hch@lst.de>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] list.h update (resent again) 
In-reply-to: Your message of "Thu, 29 Aug 2002 10:53:24 +0200."
             <20020829105324.A13720@lst.de> 
Date: Fri, 30 Aug 2002 11:42:20 +1000
Message-Id: <20020830005909.2F5542C19B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020829105324.A13720@lst.de> you write:
> On Thu, Aug 29, 2002 at 04:03:58PM +1000, Rusty Russell wrote:
> > Don't apply it (at least, the first part is bad).
> > 
> > Linus, here's my patch to get rid of the usurper list_t in 2.5
> > (against 2.5.32, so might have some rejects).
> 
> U don't think that's a valid reason to delay it.  Ingo added list_t
> for a reason und 2.4 is not the right place to change struct list_head
> to struct list, which sounds good for 2.5.

Ingo's reason was that it made some of his lines fit in 80 cols 8)

Having two names for the same thing is a confusing waste, and "struct
list_head" is the defacto standard.  If you have nothing better to do,
I can suggest plenty of worthwhile projects which could use your skills 8)

Die typedefs, die,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
