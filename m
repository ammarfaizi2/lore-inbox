Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263251AbUCNBON (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 20:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263254AbUCNBON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 20:14:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:27582 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263251AbUCNBOJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 20:14:09 -0500
Date: Sat, 13 Mar 2004 17:13:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Woodruff, Robert J" <woody@co.intel.com>
Cc: torvalds@osdl.org, sam@ravnborg.org, greg@kroah.com, miller@techsource.com,
       riel@redhat.com, matti.aarnio@zmailer.org, hch@infradead.org,
       woody@jf.intel.com, linux-kernel@vger.kernel.org, sean.hefty@intel.com,
       jerrie.l.coffman@intel.com, arlin.r.davis@intel.com,
       marcelo.tosatti@cyclades.com
Subject: Re: PATCH - InfiniBand Access Layer (IBAL)
Message-Id: <20040313171349.07349e4a.akpm@osdl.org>
In-Reply-To: <1AC79F16F5C5284499BB9591B33D6F000B6306@orsmsx408.jf.intel.com>
References: <1AC79F16F5C5284499BB9591B33D6F000B6306@orsmsx408.jf.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Woodruff, Robert J" <woody@co.intel.com> wrote:
>
> The Mellanox and Topspin folks along with some people from some of
>  the national labs are trying to start up a website called openib.org,
>  with data bases, email lists, etc. where people can submit code for
>  this "best of breed" stack and discuss it. As long as it is truly 
>  open, the linux community is allowed to participate, and the code
>  is evaluated on it's technical merits, rather than one companies
>  personal
>  agenda, this forum might serve as a way for us to sort through this
>  without
>  taking every issue to lkml. 

That is, of course, an excellent approach.

But beware of being *too* disconnected from the lists@vger.kernel.org.  We
don't want to get in the situation where you pop up with a couple of
person-years' worth of work and other kernel developers have major issues
with it.  Please find a balance - some way of regularly checkpointing.

Also, beware of aiming for a finished product.  We would *much* prefer that
a simple, minimal core, maybe with just a single device driver be merged
into the mainline kernel.  The IBAL developers then proceed to enhance
that, sending regular updates.  Every couple of weeks would suit.

That way everyone else can see the code evolving, and can help, and can
understand.  And other people will fix your bugs for you, and update your
code as kernel-wide changes are implemented.  And we all avoid nasty
surprises and extensive rework.
