Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272529AbTHAGtT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 02:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275119AbTHAGtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 02:49:19 -0400
Received: from dp.samba.org ([66.70.73.150]:59586 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S272529AbTHAGtQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 02:49:16 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Willy Tarreau <willy@w.ods.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: module-init-tools don't support gzipped modules. 
In-reply-to: Your message of "Thu, 31 Jul 2003 16:33:50 +0200."
             <20030731143350.GA30865@alpha.home.local> 
Date: Fri, 01 Aug 2003 16:30:44 +1000
Message-Id: <20030801064916.3F45B2C2B2@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030731143350.GA30865@alpha.home.local> you write:
> On Thu, Jul 31, 2003 at 11:06:35AM +1000, Keith Owens wrote:
> > On Thu, 31 Jul 2003 02:46:23 +1000, 
> > Rusty Russell <rusty@rustcorp.com.au> wrote:
> > >I don't want to require zlib, though.  The modutils I have (Debian)
> > >doesn't support it, either.
> > 
> > Really?  modutils 2.4: ./configure --enable-zlib
> 
> Ok, here is a patch against module-init-tools-0.9.13-pre that I ported from
> modutils. I haven't tested it yet since I don't have any 2.6 kernel right here.
> But at least it compiles with and without zlib.

OK, I'll work from this patch: I'll probably pull out a separate
"snarf file" function and use that for all these cases, to ensure
there's only one #ifdef though.

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
