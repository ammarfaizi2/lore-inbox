Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751849AbWHNFA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849AbWHNFA2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 01:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751847AbWHNFA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 01:00:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:21937 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751846AbWHNFA1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 01:00:27 -0400
From: Andi Kleen <ak@suse.de>
To: Matthew Wilcox <matthew@wil.cx>
Subject: Re: module compiler version check still needed?
Date: Mon, 14 Aug 2006 06:59:49 +0200
User-Agent: KMail/1.9.3
Cc: Keith Owens <kaos@ocs.com.au>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <31645.1155445159@ocs10w.ocs.com.au> <200608132227.24719.ak@suse.de> <20060813221456.GC789@parisc-linux.org>
In-Reply-To: <20060813221456.GC789@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608140659.49462.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 August 2006 00:14, Matthew Wilcox wrote:
> On Sun, Aug 13, 2006 at 10:27:24PM +0200, Andi Kleen wrote:
> > On Sunday 13 August 2006 06:59, Keith Owens wrote:
> > > IA64 still needs the check.  include/asm-ia64/spinlock.h generates
> > > different calls to the out of line spinlock handler, depending on the
> > > version of gcc.
> > 
> > Thanks. But I guess it could be used to MODULE_ARCH_VERMAGIC for ia64 only then.
> > If nobody else complains I will do that.
> 
> Will we remember to add the check back in when we introduce new
> dependencies on compiler versions?

If something breaks it be readded. I see it only as a special
hack for some extraordinary, and hopefully these problems won't happen again.

-Andi
