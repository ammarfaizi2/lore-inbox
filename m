Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932484AbWHHEYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbWHHEYm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 00:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbWHHEYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 00:24:42 -0400
Received: from xenotime.net ([66.160.160.81]:54469 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932485AbWHHEYl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 00:24:41 -0400
Date: Mon, 7 Aug 2006 21:27:22 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andi Kleen <ak@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/9] Replace some ARCH_HAS_XYZZY
Message-Id: <20060807212722.68e64b17.rdunlap@xenotime.net>
In-Reply-To: <200608080515.10496.ak@suse.de>
References: <20060807141328.4d9c2a72.rdunlap@xenotime.net>
	<200608080405.11111.ak@suse.de>
	<20060807200804.7847e6d0.rdunlap@xenotime.net>
	<200608080515.10496.ak@suse.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Aug 2006 05:15:10 +0200 Andi Kleen wrote:

> 
> > They are config characteristics (in many cases).  Hiding them in
> > header files with dummy inlines or with ARCH_HAS_XYZZY is still
> > hiding them IMO, although the inlines are better than the
> > ARCH_HAS_XYZZY method.  I prefer to see them in the config space
> > since I think that's where they belong.
> 
> That's just a different way to write a #define. You could as 
> well keep the originals then.

yes, except that
1. these aren't buried in random header files
2. these are in the kconfig system & namespace where they belong

---
~Randy
