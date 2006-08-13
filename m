Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751672AbWHMWO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672AbWHMWO7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 18:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751675AbWHMWO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 18:14:58 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:31690 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S1751670AbWHMWO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 18:14:58 -0400
Date: Sun, 13 Aug 2006 16:14:57 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Andi Kleen <ak@suse.de>
Cc: Keith Owens <kaos@ocs.com.au>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: module compiler version check still needed?
Message-ID: <20060813221456.GC789@parisc-linux.org>
References: <31645.1155445159@ocs10w.ocs.com.au> <200608132227.24719.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608132227.24719.ak@suse.de>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2006 at 10:27:24PM +0200, Andi Kleen wrote:
> On Sunday 13 August 2006 06:59, Keith Owens wrote:
> > IA64 still needs the check.  include/asm-ia64/spinlock.h generates
> > different calls to the out of line spinlock handler, depending on the
> > version of gcc.
> 
> Thanks. But I guess it could be used to MODULE_ARCH_VERMAGIC for ia64 only then.
> If nobody else complains I will do that.

Will we remember to add the check back in when we introduce new
dependencies on compiler versions?
