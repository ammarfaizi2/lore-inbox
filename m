Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267239AbUF0AFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267239AbUF0AFs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 20:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267240AbUF0AFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 20:05:48 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:30379 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S267239AbUF0AFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 20:05:47 -0400
Date: Sat, 26 Jun 2004 17:05:41 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PARISC list <parisc-linux@lists.parisc-linux.org>
Subject: Re: [parisc-linux] Re: [PATCH] Fix the cpumask rewrite
Message-ID: <20040627000541.GA13325@taniwha.stupidest.org>
References: <1088266111.1943.15.camel@mulgrave> <Pine.LNX.4.58.0406260924570.14449@ppc970.osdl.org> <20040626221802.GA12296@taniwha.stupidest.org> <Pine.LNX.4.58.0406261536590.16079@ppc970.osdl.org> <1088290477.3790.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1088290477.3790.2.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2004 at 11:54:38PM +0100, Alan Cox wrote:

> For most uses jiffies should die. If drivers could not access jiffies
> except by a (possibly trivial) helper then it would be a huge step
> closer to being able to run embedded linux without a continually running
> timer.

I'm all for that, except last I counted there are about 5000 users of
jiffies.  What do you suggest as a replacement API?



  --cw
