Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263714AbTJCOb2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 10:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263735AbTJCOb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 10:31:28 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:58867 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S263714AbTJCOb0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 10:31:26 -0400
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: Herbert Poetzl <herbert@13thfloor.at>,
       Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: Can't X be elemenated?
Date: Fri, 3 Oct 2003 09:30:47 -0500
X-Mailer: KMail [version 1.2]
Cc: kartikey bhatt <kartik_me@hotmail.com>, linux-kernel@vger.kernel.org
References: <Law11-F67ATnLE7P95L00001388@hotmail.com> <3F7BE886.8070401@aitel.hist.no> <20031002181821.GB2816@DUK2.13thfloor.at>
In-Reply-To: <20031002181821.GB2816@DUK2.13thfloor.at>
MIME-Version: 1.0
Message-Id: <03100309304700.22916@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 October 2003 13:18, Herbert Poetzl wrote:
> On Thu, Oct 02, 2003 at 10:57:42AM +0200, Helge Hafting wrote:
> > kartikey bhatt wrote:
> > >hey everyone who have joined this thread, my fundamental question have
> > > got out of scope. I mean to say
> > >
> > >1. Kernel level support for graphics device drivers.
> > >2. On top of that, one can develop complete lightweight GUI.
> > >3. Maybe kernel can provide support for event handling.
> > >
> > >and I still stick to my opinion that graphics card is a computer
> > > resource that needs to be managed by OS   rather than 3rd party
> > > developers.
> >
> > The card is managed by the os - X has to ask the kernel nicely to get it.
> > (Try starting another X server inside an xterm and see how
> > that is refused.)
>
> X :2 (not refused ...)

Thats because X asked nicely, and was given another vertual terminal, and
started server #2... By default it attempts to start 0; and that is refused.

Specifying a different server number will permit it to be run, if there are
available VTs.

You should be able to run at least 7, if they don't have login prompts on
them.
