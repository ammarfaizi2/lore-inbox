Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbTIABWJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 21:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbTIABWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 21:22:09 -0400
Received: from dp.samba.org ([66.70.73.150]:11687 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261380AbTIABWH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 21:22:07 -0400
Date: Mon, 1 Sep 2003 11:18:38 +1000
From: Anton Blanchard <anton@samba.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: bos@serpentine.com, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add documentation for /proc/stat
Message-ID: <20030901011838.GA1381@krispykreme>
References: <1062307148.17532.17.camel@camp4.serpentine.com> <33327.4.4.25.4.1062377579.squirrel@www.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33327.4.4.25.4.1062377579.squirrel@www.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> (stoopid webmail client mangles text above)
> 
> The "intr" line is omitted for PPC64 and ALPHA.
> [#if !defined(CONFIG_PPC64) && !defined(CONFIG_ALPHA)]

On ppc64 we do keep the summary part of the intr line around (vmstat uses
it).

The per irq stuff is omitted, its a bad representation when you have
lots of sparse irqs.

Anton
