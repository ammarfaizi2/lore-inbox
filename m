Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbUHUXiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUHUXiP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 19:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbUHUXiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 19:38:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:44942 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261232AbUHUXiN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 19:38:13 -0400
Date: Sat, 21 Aug 2004 16:36:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: John Levon <levon@movementarian.org>
Cc: oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       jbarnes@sgi.com, anton@samba.org, phil.el@wanadoo.fr
Subject: Re: [PATCH] improve OProfile on many-way systems
Message-Id: <20040821163628.10cfa049.akpm@osdl.org>
In-Reply-To: <20040821232206.GC20175@compsoc.man.ac.uk>
References: <20040821192630.GA9501@compsoc.man.ac.uk>
	<20040821135833.6b1774a8.akpm@osdl.org>
	<20040821232206.GC20175@compsoc.man.ac.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Levon <levon@movementarian.org> wrote:
>
>  > how do we know when it has had sufficient testing for its swim upstream?
> 
>  I thought one of the points of the mm tree was to give things some
>  testing first.

Well yes, but it's not magic.

Before merging up a large patch which was lightly tested by its developer
I'd like to now that it was beaten on in an organised manner.  I am not
aware of anyone performing regression tests againt oprofile in any kernel,
let alone -mm.

One of my mental checkpoints before sending a patch to Linus is "has this
been sufficiently tested".  I don't know how to answer that in this case.

In fact I don't know how to answer that in a _lot_ of cases, but if I know
that people are using the feature in anger and we're sufficiently early in
the 2.6.x cycle then I'll assume that regressions will be picked up.  But
again, I'm not confident that oprofile is getting sufficiently frequent use
for this to apply.

Anyway.  My question was mainly a prod in the antonward direction ;)
