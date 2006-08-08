Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbWHHDFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbWHHDFZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 23:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWHHDFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 23:05:25 -0400
Received: from xenotime.net ([66.160.160.81]:55723 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751225AbWHHDFY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 23:05:24 -0400
Date: Mon, 7 Aug 2006 20:08:04 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andi Kleen <ak@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/9] Replace some ARCH_HAS_XYZZY
Message-Id: <20060807200804.7847e6d0.rdunlap@xenotime.net>
In-Reply-To: <200608080405.11111.ak@suse.de>
References: <20060807141328.4d9c2a72.rdunlap@xenotime.net>
	<200608080405.11111.ak@suse.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Aug 2006 04:05:11 +0200 Andi Kleen wrote:

> On Monday 07 August 2006 23:13, Randy.Dunlap wrote:
> > On Mon, 3 Jul 2006 10:13:12 -0700 (PDT) Linus Torvalds wrote:
> > 
> > [snip]
> > 
> > > The whole "ARCH_HAS_XYZZY" is nothing but crap. It's totally unreadable, 
> > ...
> > > WE SHOULD GET RID OF ARCH_HAS_XYZZY. It's a disease.
> > 
> > Using Kconfig symbols for some of them seems more appropriate to me,
> 
> IMHO that's no better.
> 
> Instead one should add dummy inlines/macros or asm-generic dummy inlines/macros
> to all the architectures.

They are config characteristics (in many cases).  Hiding them in
header files with dummy inlines or with ARCH_HAS_XYZZY is still
hiding them IMO, although the inlines are better than the
ARCH_HAS_XYZZY method.  I prefer to see them in the config space
since I think that's where they belong.

---
~Randy
