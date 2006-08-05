Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161305AbWHEL5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161305AbWHEL5p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 07:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161306AbWHEL5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 07:57:45 -0400
Received: from cantor2.suse.de ([195.135.220.15]:32438 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161305AbWHEL5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 07:57:45 -0400
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: A proposal - binary
Date: Sat, 5 Aug 2006 13:57:09 +0200
User-Agent: KMail/1.9.3
Cc: Zachary Amsden <zach@vmware.com>, Chris Wright <chrisw@sous-sol.org>,
       Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       James.Bottomley@steeleye.com, pazke@donpac.ru
References: <44D1CC7D.4010600@vmware.com> <200608050001.52535.ak@suse.de> <20060805104735.GS25692@stusta.de>
In-Reply-To: <20060805104735.GS25692@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608051357.09432.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Has anyone measured the performance impact of rutime CLOCK_TICK_RATE 
> switching (since this will no longer allow some compile time 
> optimizations in jiffies.h)?

SUSE shipped a kernel briefly that had runtime switchable jiffies
and there were some benchmarks done and they didn't show noticeable
slowdown.

But with hr timers it should be pretty much obsolete anyways.

-Andi

