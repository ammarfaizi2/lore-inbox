Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbUCUU6B (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 15:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbUCUU6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 15:58:01 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:16280 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261273AbUCUU57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 15:57:59 -0500
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
From: David Woodhouse <dwmw2@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, rmk@arm.linux.org.uk,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
In-Reply-To: <20040321204931.A11519@infradead.org>
References: <20040320133025.GH9009@dualathlon.random>
	 <20040320144022.GC2045@holomorphy.com>
	 <20040320150621.GO9009@dualathlon.random>
	 <20040320121345.2a80e6a0.akpm@osdl.org>
	 <20040320205053.GJ2045@holomorphy.com>
	 <20040320222639.K6726@flint.arm.linux.org.uk>
	 <20040320224500.GP2045@holomorphy.com>
	 <1079901914.17681.317.camel@imladris.demon.co.uk>
	 <20040321204931.A11519@infradead.org>
Content-Type: text/plain
Message-Id: <1079902670.17681.324.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Sun, 21 Mar 2004 20:57:50 +0000
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-03-21 at 20:49 +0000, Christoph Hellwig wrote:
> And what exactly is a PFN without associated struct page supposed to mean?

It's something you can put into a PTE, and that's about it. Which unless
I'm misunderstanding ALSA/rmk's requirements, should be enough.

-- 
dwmw2


