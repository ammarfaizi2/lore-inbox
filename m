Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262051AbVAYSZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbVAYSZH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 13:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbVAYSZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 13:25:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:54996 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262051AbVAYSYy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 13:24:54 -0500
Date: Tue, 25 Jan 2005 10:24:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Bryce Harrington <bryce@osdl.org>
Cc: chrisw@osdl.org, rddunlap@osdl.org, dev@osdl.org,
       stp-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       hanrahat@osdl.org
Subject: Re: [torvalds@osdl.org: Re: Memory leak in 2.6.11-rc1?]
Message-Id: <20050125102419.07d20ae5.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.33.0501250938540.11739-100000@osdlab.pdx.osdl.net>
References: <20050124231828.0e369d7c.akpm@osdl.org>
	<Pine.LNX.4.33.0501250938540.11739-100000@osdlab.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryce Harrington <bryce@osdl.org> wrote:
>
> On Mon, 24 Jan 2005, Andrew Morton wrote:
> > Bryce Harrington <bryce@osdl.org> wrote:
> > >
> > > There is a new behavior, though.  Now the test is hanging indefinitely
> > >  on the nptl01 test.  I am assuming that since it passed the spot that it
> > >  had failed before, that this is an unrelated issue.
> >
> > I'm finding that nptl01 somtimes gets stuck and sometimes works OK.  Try
> > running it by hand a few times.
> >
> > It could be an application bug or a kernel bug.
> 
> Okay, so it doesn't sound like anything to be worried about.
> 

Well no.  If we're sure that kernel changes caused this new behaviour then
that's a problem.
