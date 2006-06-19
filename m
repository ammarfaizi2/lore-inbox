Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbWFSV3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWFSV3n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 17:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWFSV3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 17:29:43 -0400
Received: from www.osadl.org ([213.239.205.134]:12975 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932308AbWFSV3n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 17:29:43 -0400
Subject: Re: [PATCH] ktime/hrtimer: fix kernel-doc comments
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
In-Reply-To: <20060619142050.c4765cef.rdunlap@xenotime.net>
References: <20060619130948.6ea3998c.rdunlap@xenotime.net>
	 <1150750822.29299.86.camel@localhost.localdomain>
	 <20060619141127.abdfdac0.rdunlap@xenotime.net>
	 <1150751733.6780.3.camel@localhost.localdomain>
	 <20060619142050.c4765cef.rdunlap@xenotime.net>
Content-Type: text/plain
Date: Mon, 19 Jun 2006 23:30:57 +0200
Message-Id: <1150752657.6780.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-19 at 14:20 -0700, Randy.Dunlap wrote:
> > Seriously, is it hard to fix ? I'm not good with perl, so its likely
> > that I would make more mess than fixups.
> 
> I don't know for sure.  I have looked at it a bit and
> it's messy code IMHO.  Might be easier/better just to rewrite
> the function (comment) header parsing.

I would do that, but I have no idea how to mix python into perl :)

> Andrew also wants the short function description to be able to be
> more than one line.  That could/should be incorporated at the same time.

That would be a really nice feature.

> OTOH, it's a defined doc. language and these files contain errors...

No objections, but it would be cool if some perl experts would remove
those restrictions before the patches finally hit mainline.

	tglx


