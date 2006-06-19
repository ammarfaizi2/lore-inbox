Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964896AbWFSViP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964896AbWFSViP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 17:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbWFSViP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 17:38:15 -0400
Received: from xenotime.net ([66.160.160.81]:7074 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964896AbWFSViO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 17:38:14 -0400
Date: Mon, 19 Jun 2006 14:41:01 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
Subject: Re: [PATCH] ktime/hrtimer: fix kernel-doc comments
Message-Id: <20060619144101.dbe56ef7.rdunlap@xenotime.net>
In-Reply-To: <1150752657.6780.16.camel@localhost.localdomain>
References: <20060619130948.6ea3998c.rdunlap@xenotime.net>
	<1150750822.29299.86.camel@localhost.localdomain>
	<20060619141127.abdfdac0.rdunlap@xenotime.net>
	<1150751733.6780.3.camel@localhost.localdomain>
	<20060619142050.c4765cef.rdunlap@xenotime.net>
	<1150752657.6780.16.camel@localhost.localdomain>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2006 23:30:57 +0200 Thomas Gleixner wrote:

> On Mon, 2006-06-19 at 14:20 -0700, Randy.Dunlap wrote:
> > > Seriously, is it hard to fix ? I'm not good with perl, so its likely
> > > that I would make more mess than fixups.
> > 
> > I don't know for sure.  I have looked at it a bit and
> > it's messy code IMHO.  Might be easier/better just to rewrite
> > the function (comment) header parsing.
> 
> I would do that, but I have no idea how to mix python into perl :)

so rewrite scripts/kernel-doc in python.  ;)

> > Andrew also wants the short function description to be able to be
> > more than one line.  That could/should be incorporated at the same time.
> 
> That would be a really nice feature.

It's just a convenience factor.  There is another way to have a
multi-line function description.

> > OTOH, it's a defined doc. language and these files contain errors...
> 
> No objections, but it would be cool if some perl experts would remove
> those restrictions before the patches finally hit mainline.

I plan to work on it, but it's not super high priority.
Someone else can do the same...


This is just one example of many files that have similar kernel-doc
problems.  I wasn't picking on your files.  :)

---
~Randy
