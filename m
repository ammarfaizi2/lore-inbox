Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267545AbSLSGk3>; Thu, 19 Dec 2002 01:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267543AbSLSGk3>; Thu, 19 Dec 2002 01:40:29 -0500
Received: from pby.osdl.jp ([202.221.206.21]:40321 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id <S267553AbSLSGk1>;
	Thu, 19 Dec 2002 01:40:27 -0500
Subject: Re: Freezing.. (was Re: Intel P6 vs P7 system call performance)
From: "Timothy D. Witham" <wookie@osdl.org>
To: Andrew Morton <akpm@digeo.com>
Cc: Alan Cox <alan@redhat.com>, Linus Torvalds <torvalds@transmeta.com>,
       Dave Jones <davej@codemonkey.org.uk>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org
In-Reply-To: <3E016A9F.52A4048@digeo.com>
References: <200212181908.gBIJ82M03155@devserv.devel.redhat.com>
	 <1040276082.1476.30.camel@localhost.localdomain>
	 <3E016A9F.52A4048@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Open Source Development Lab, Inc.
Message-Id: <1040276730.1474.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 18 Dec 2002 21:45:30 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-18 at 22:43, Andrew Morton wrote:
> "Timothy D. Witham" wrote:
> > 
> > Related thought:
> > 
> >   One of the things that we are trying to do is to automate
> > patch testing.
> > 
> >   The PLM (www.osdl.org/plm) takes every patch that it gets
> > and does a quick "Does it compile test".  Right now there
> > are only 4 kernel configuration files that we try but we are
> > going to be adding more.  We could expand this to 100's
> > if needed as it would just be a matter of adding additional
> > hardware to make the compiles go faster in parallel.
> 
> It would be valuable to be able to test that things compile
> cleanly on non-ia32 machines.  And boot, too.
> 
  The way the software is configured it is fairly easy to
add multiple servers (even different instruction sets) that
have the complies farmed out to them.

> That's probably a lot of ongoing work though.

  The largest portion of the work would be keeping
up with the breakages in the trees.

BTW I'm in Japan so my access times are going to be
a little strange.
-- 
Timothy D. Witham - Lab Director - wookie@osdlab.org
Open Source Development Lab Inc - A non-profit corporation
15275 SW Koll Parkway - Suite H - Beaverton OR, 97006
(503)-626-2455 x11 (office)    (503)-702-2871     (cell)
(503)-626-2436     (fax)

