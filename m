Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267840AbUH2Nva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267840AbUH2Nva (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 09:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267835AbUH2Nva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 09:51:30 -0400
Received: from the-village.bc.nu ([81.2.110.252]:52608 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267840AbUH2Nuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 09:50:40 -0400
Subject: Re: 1GB/2GB/3GB User Space Splitting Patch 2.6.8.1 (PSEUDO SPAM)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Roland Dreier <roland@topspin.com>, jmerkey@comcast.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jmerkey@drdos.com
In-Reply-To: <20040826044954.GP2793@holomorphy.com>
References: <082620040421.9849.412D655C000690BA000026792200735446970A059D0A0306@comcast.net>
	 <20040826043318.GO2793@holomorphy.com> <52isb6bj64.fsf@topspin.com>
	 <20040826044954.GP2793@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093783694.27899.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 29 Aug 2004 13:48:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-08-26 at 05:49, William Lee Irwin III wrote:
> On Wed, Aug 25, 2004 at 09:46:43PM -0700, Roland Dreier wrote:
> > Agreed, but I do like running with PAGE_OFFSET == 0xB0000000 on my
> > main box, which has 1 GB of RAM.  I can avoid highmem and still use
> > the last 128 MB of RAM.  It takes me about 3 seconds to edit
> > <asm/page.h> when I build a new kernel so I'm not arguing for merging
> > this, though.
> 
> Though asinine, the ABI spec is set in stone.

Lots of Linux configuration options build you systems that don't meet
some specifications. "Intentionally violate a stupid spec to get work
done" is a good option 8)

