Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbVHQGGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbVHQGGv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 02:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbVHQGGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 02:06:51 -0400
Received: from xenotime.net ([66.160.160.81]:31423 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750874AbVHQGGu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 02:06:50 -0400
Date: Tue, 16 Aug 2005 23:06:48 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, sudoyang@gmail.com
Subject: Re: compiling only one module in kernel version 2.6?
Message-Id: <20050816230648.7c43fe02.rdunlap@xenotime.net>
In-Reply-To: <1124258090.5764.109.camel@localhost.localdomain>
References: <4f52331f050816190957cec081@mail.gmail.com>
	<1124248729.5764.70.camel@localhost.localdomain>
	<20050816224101.295806c8.rdunlap@xenotime.net>
	<1124257739.5764.107.camel@localhost.localdomain>
	<1124258090.5764.109.camel@localhost.localdomain>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Aug 2005 01:54:50 -0400 Steven Rostedt wrote:

> On Wed, 2005-08-17 at 01:48 -0400, Steven Rostedt wrote:
> > On Tue, 2005-08-16 at 22:41 -0700, Randy.Dunlap wrote:
> > > 
> > > Sam only added make .ko build support very recently,
> > > so it could easily depend on what kernel verison Fong is using.
> > 
> > That could very well explain it. I'm doing this on 2.6.13-rc6-rt6
> > (2.6.13-rc6 with Ingo's rt6 patch applied).  So I really do have a
> > recent kernel.
> > 
> 
> I just did this on a 2.6.9 vanilla kernel, and it still worked. How
> "recent" did Sam do this?

2.6.9 did not handle "make one_module.ko" (for me on x86).

2005-july-08:
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=155ad605b3c9c5874ff068f23c6ea8537190e0a8

---
~Randy
