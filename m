Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266200AbUGARnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266200AbUGARnj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 13:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266198AbUGARnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 13:43:39 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:7303 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S266200AbUGARnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 13:43:31 -0400
Date: Thu, 1 Jul 2004 10:43:21 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PARISC list <parisc-linux@lists.parisc-linux.org>
Subject: Re: [parisc-linux] Re: [PATCH] Fix the cpumask rewrite
Message-ID: <20040701174321.GA27586@taniwha.stupidest.org>
References: <1088266111.1943.15.camel@mulgrave> <Pine.LNX.4.58.0406260924570.14449@ppc970.osdl.org> <20040626221802.GA12296@taniwha.stupidest.org> <Pine.LNX.4.58.0406261536590.16079@ppc970.osdl.org> <1088290477.3790.2.camel@localhost.localdomain> <20040627000541.GA13325@taniwha.stupidest.org> <1088347046.26753.3.camel@localhost.localdomain> <20040701133308.GQ698@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040701133308.GQ698@openzaurus.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2004 at 03:33:08PM +0200, Pavel Machek wrote:

> Plus some get_jiffies api for stuff like printk ratelimit would be
> needed, right?

*Some* things willl need special consideration, but most of the users
of jiffies right now could use a more high-level API.

I'm toying with the idea right now of have per-CPU xtime and deriving
jiffies from that in places too.


  --cw
