Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262573AbVAJWvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262573AbVAJWvH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 17:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262575AbVAJWu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 17:50:56 -0500
Received: from baythorne.infradead.org ([81.187.226.107]:46276 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S262571AbVAJWtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 17:49:46 -0500
Subject: Re: [2.6 patch] remove SPF-using wbsd lists from MAINTAINERS
From: David Woodhouse <dwmw2@infradead.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20050110190809.A10365@flint.arm.linux.org.uk>
References: <20050110184307.GB2903@stusta.de>
	 <20050110190809.A10365@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Mon, 10 Jan 2005 22:49:36 +0000
Message-Id: <1105397376.15749.53.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-10 at 19:08 +0000, Russell King wrote:
> > IMHO lists rejecting emails based on some non-standard extension 
> > don't belong into MAINTAINERS.
> 
> I assume as you removed Pierre Ossman's email address as well that
> you apply the same argument to peoples email addresses?

That would seem an appropriate thing to do. SPF is not compatible with
SMTP email as we know it today; it would requires the whole world to
upgrade to make its flawed assumptions come true. We should not list
email addresses in MAINTAINERS which are afflicted by it.

For what it's worth, I recently changed all instances of one of my
personal email addresses in the kernel, for precisely the same reason --
it's SPF-afflicted, and hence has no business being present in a form
which cause people to expect that it's a normal, compatible email
address.

-- 
dwmw2


