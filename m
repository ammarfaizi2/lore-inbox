Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbULXQ2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbULXQ2E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 11:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbULXQ2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 11:28:04 -0500
Received: from gprs215-38.eurotel.cz ([160.218.215.38]:38528 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261287AbULXQ2A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 11:28:00 -0500
Date: Fri, 24 Dec 2004 17:27:45 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@osdl.org, linux-ia64@vger.kernel.org, torvalds@osdl.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Prezeroing V2 [2/4]: add second parameter to clear_page() for all arches
Message-ID: <20041224162745.GA1178@elf.ucw.cz>
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com> <41C20E3E.3070209@yahoo.com.au> <Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0412231119540.31791@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0412231132170.31791@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0412231133130.31791@schroedinger.engr.sgi.com> <20041224083337.GA1043@openzaurus.ucw.cz> <Pine.LNX.4.58.0412240818030.6505@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0412240818030.6505@schroedinger.engr.sgi.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > o Extend clear_page to take an order parameter for all architectures.
> > >
> >
> > I believe you sould leave clear_page() as is, and introduce
> > clear_pages() with two arguments.
> 
> Did that in V1 and Andi Kleen complained about it.

I do not know what Andi said, but having clear_page clearing two
page*s* seems wrong to me.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
