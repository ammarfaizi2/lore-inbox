Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263101AbUFFInp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbUFFInp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 04:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263147AbUFFIno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 04:43:44 -0400
Received: from [213.146.154.40] ([213.146.154.40]:11456 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263101AbUFFIn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 04:43:29 -0400
Date: Sun, 6 Jun 2004 09:43:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@infradead.org>,
       Mike McCormack <mike@codeweavers.com>, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: WINE + NX (No eXecute) support for x86, 2.6.7-rc2-bk2
Message-ID: <20040606084326.GA6716@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mike McCormack <mike@codeweavers.com>, mingo@elte.hu,
	linux-kernel@vger.kernel.org
References: <40C2B51C.9030203@codeweavers.com> <20040606073241.GA6214@infradead.org> <40C2E045.8090708@codeweavers.com> <20040606081021.GA6463@infradead.org> <40C2E5DC.8000109@codeweavers.com> <20040606083924.GA6664@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040606083924.GA6664@infradead.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06, 2004 at 09:39:24AM +0100, Christoph Hellwig wrote:
> > True, we are relying on undocumented assumptions.  On the other hand, 
> > there's plenty of programs that rely on undocumented assumptions. 
> > Binary compatability to me means that the same binary will work even 
> > when the underlying system changes... is there a caveat that I missed?
> 
> And there's plenty of programs that break because of that.  Wine is now
> one of those.  You can either cludge around your brokenness even more or
> try to get it fixed.  Your choice.

And btw, if you'd have read the whole thread you'd have seen that I argued
against mergign the randomization and address space layout changes into
2.6, and such changes during stable series are bad.  But your still much
better of getting your code fixed properly, and thus pretty much means
havign your own binary format handler in the kernel that sets up the address
space in a windows compatible way.

> 
---end quoted text---
