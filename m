Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbWFSVSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWFSVSF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 17:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964898AbWFSVSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 17:18:05 -0400
Received: from xenotime.net ([66.160.160.81]:8590 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964896AbWFSVSE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 17:18:04 -0400
Date: Mon, 19 Jun 2006 14:20:50 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
Subject: Re: [PATCH] ktime/hrtimer: fix kernel-doc comments
Message-Id: <20060619142050.c4765cef.rdunlap@xenotime.net>
In-Reply-To: <1150751733.6780.3.camel@localhost.localdomain>
References: <20060619130948.6ea3998c.rdunlap@xenotime.net>
	<1150750822.29299.86.camel@localhost.localdomain>
	<20060619141127.abdfdac0.rdunlap@xenotime.net>
	<1150751733.6780.3.camel@localhost.localdomain>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2006 23:15:33 +0200 Thomas Gleixner wrote:

> On Mon, 2006-06-19 at 14:11 -0700, Randy.Dunlap wrote:
> > > My personal preference is to keep that line, as it makes it easier to
> > > read. But as always: de gustibus non est disputandum :)
> > 
> > Feel free to send patches for scripts/kernel-doc instead.  :)
> 
> Yeah, Russell King pointed me to the nano-howto 2 minutes ago. Not
> reading docs is always backfiring at some point. :(
> 
> Seriously, is it hard to fix ? I'm not good with perl, so its likely
> that I would make more mess than fixups.

I don't know for sure.  I have looked at it a bit and
it's messy code IMHO.  Might be easier/better just to rewrite
the function (comment) header parsing.

Andrew also wants the short function description to be able to be
more than one line.  That could/should be incorporated at the same time.

OTOH, it's a defined doc. language and these files contain errors...

---
~Randy

PS: finally fixed Ingo's email address.
