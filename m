Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265023AbSKNRBU>; Thu, 14 Nov 2002 12:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265039AbSKNRBT>; Thu, 14 Nov 2002 12:01:19 -0500
Received: from dp.samba.org ([66.70.73.150]:39621 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265023AbSKNQ75>;
	Thu, 14 Nov 2002 11:59:57 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, kaos@ocs.com.au,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: Modules in 2.5.47-bk... 
In-reply-to: Your message of "Thu, 14 Nov 2002 10:50:10 -0000."
             <20021114105010.A22135@infradead.org> 
Date: Fri, 15 Nov 2002 04:53:39 +1100
Message-Id: <20021114170651.AD93C2C2E4@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021114105010.A22135@infradead.org> you write:
> On Thu, Nov 14, 2002 at 02:53:50PM +1100, Rusty Russell wrote:
> > The current method is that on "make install" the module-init-tools
> > move the old ones to xxx.old (if they exist), and do a backwards
> > compat check every time they start (and execvp xxx.old on every older
> > kernel).  If it doesn't work for you, please report.
> 
> Which breaks nicely every package manager database.

Yes.  So don't package it like that if you care about backwards
compatibility.

The entire point is that the new code is simple enough that you can
quite simply fix it.  And indeed, someone already has, while you were
whining.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
