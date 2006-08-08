Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751031AbWHHCFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbWHHCFS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 22:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWHHCFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 22:05:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:37597 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751031AbWHHCFQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 22:05:16 -0400
From: Andi Kleen <ak@suse.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH 0/9] Replace some ARCH_HAS_XYZZY
Date: Tue, 8 Aug 2006 04:05:11 +0200
User-Agent: KMail/1.9.3
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       torvalds <torvalds@osdl.org>
References: <20060807141328.4d9c2a72.rdunlap@xenotime.net>
In-Reply-To: <20060807141328.4d9c2a72.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608080405.11111.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 August 2006 23:13, Randy.Dunlap wrote:
> On Mon, 3 Jul 2006 10:13:12 -0700 (PDT) Linus Torvalds wrote:
> 
> [snip]
> 
> > The whole "ARCH_HAS_XYZZY" is nothing but crap. It's totally unreadable, 
> ...
> > WE SHOULD GET RID OF ARCH_HAS_XYZZY. It's a disease.
> 
> Using Kconfig symbols for some of them seems more appropriate to me,

IMHO that's no better.

Instead one should add dummy inlines/macros or asm-generic dummy inlines/macros
to all the architectures.

-Andi
