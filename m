Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264750AbUF1HCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264750AbUF1HCN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 03:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264762AbUF1HCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 03:02:13 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:7573 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S264750AbUF1HCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 03:02:11 -0400
Date: Mon, 28 Jun 2004 00:02:05 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [parisc-linux] Re: [PATCH] Fix the cpumask rewrite
Message-ID: <20040628070205.GA4743@taniwha.stupidest.org>
References: <Pine.LNX.4.58.0406260924570.14449@ppc970.osdl.org> <20040626221802.GA12296@taniwha.stupidest.org> <Pine.LNX.4.58.0406261536590.16079@ppc970.osdl.org> <1088290477.3790.2.camel@localhost.localdomain> <20040627000541.GA13325@taniwha.stupidest.org> <pan.2004.06.27.12.00.03.857572@smurf.noris.de> <20040627224115.GA22532@taniwha.stupidest.org> <20040628012407.GC4648@kiste> <20040628054227.GB4025@taniwha.stupidest.org> <20040628065506.GA5557@kiste>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040628065506.GA5557@kiste>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2004 at 08:55:08AM +0200, Matthias Urlichs wrote:

> However, going over 5000 jiffies usages and re-doing all of them
> doesn't happen overnight, and I do suspect that some people want
> their embedded clockless systems to run Linux 2.4 or 2.6, rather
> than 2.8...

Such (embedded) hardware uses a very small percentage of the drivers
we have in the tree, changing them as required seems quite sane and
manageable in 2.7.x time-frame.

I also do see why clock-less has to be embedded only, I suspect maybe
the s390 could make use of this too?  (Think of lots of mostly-idle
Linux instances under VM).

And, it's a 'new feature' so if people need to upgrade, then Life is
tough.  How sad.


  --cw
