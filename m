Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965144AbWD0PFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965144AbWD0PFR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 11:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965152AbWD0PFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 11:05:16 -0400
Received: from canuck.infradead.org ([205.233.218.70]:46261 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S965144AbWD0PFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 11:05:15 -0400
Subject: Re: Simple header cleanups
From: David Woodhouse <dwmw2@infradead.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
In-Reply-To: <Pine.LNX.4.64.0604261917270.3701@g5.osdl.org>
References: <1146104023.2885.15.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.64.0604261917270.3701@g5.osdl.org>
Content-Type: text/plain
Date: Thu, 27 Apr 2006 16:05:10 +0100
Message-Id: <1146150310.11909.469.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-26 at 19:18 -0700, Linus Torvalds wrote:
> On Thu, 27 Apr 2006, David Woodhouse wrote:
> >
> > Andrew (or preferably Linus since these are fairly simple and
> > unintrusive bug fixes), please pull from my tree at 
> > git://git.infradead.org/hdrcleanup-2.6.git
> 
> Hmm. Every time we've done this in the past, something has broken, so
> I'd actually _much_ rather wait until early in the 2.6.18 cycle than 
> do it now.

For -mm then please Andrew? Trees are
git://git.infradead.org/hdrcleanup-2.6.git for the header cleanups
and git://git.infradead.org/hdrinstall-2.6.git for the 'make
headers_install'.

This has been compile-tested on ppc, ppc64, x86_64, i686, ia64, s390 and
s390x. The exported headers have been used as the basis for a
glibc-kernheaders package and then to build glibc on the same set of
architectures.

Btw, I note there's no rbtree-git in your 2.6.17-rc2-mm1. Anything I can
do to remedy that? Did I just imagine that you had included it in a
previous -mm?

-- 
dwmw2

