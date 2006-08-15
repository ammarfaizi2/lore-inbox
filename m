Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbWHODSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbWHODSM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 23:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752080AbWHODSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 23:18:12 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:39851 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1750957AbWHODSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 23:18:11 -0400
Date: Mon, 14 Aug 2006 23:17:33 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Matt Mackall <mpm@selenic.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net,
       Joern Engel <joern@wohnheim.fh-wedel.de>
Subject: Re: [PATCH] UML - support checkstack
Message-ID: <20060815031733.GA7089@ccure.user-mode-linux.org>
References: <200608091815.k79IFQVB005310@ccure.user-mode-linux.org> <20060810020922.GO6908@waste.org> <20060810042216.GA7754@ccure.user-mode-linux.org> <20060810164548.GS6908@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060810164548.GS6908@waste.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2006 at 11:45:48AM -0500, Matt Mackall wrote:
> > SUBARCH has a different meaning here.  For UML, it's the underlying,
> > host, architecture, not a variant architecture like Voyager.
> 
> Right, so it sounds like this breaks Voyager. Which I think means we
> ought to pass ARCH and SUBARCH and do the right thing inside
> checkstack.

There is no use of the symbol SUBARCH in arch/i386.  While this may be
jarring to people who know and love Voyager, it doesn't break
anything.

We could do what you suggest, but that sounds unnecessary.

I'd rather either
	leave things as they are
	rename SUBARCH

				Jeff
