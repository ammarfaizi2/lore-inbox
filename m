Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263117AbUFFIkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUFFIkT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 04:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbUFFIkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 04:40:19 -0400
Received: from [213.146.154.40] ([213.146.154.40]:8384 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263117AbUFFIjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 04:39:25 -0400
Date: Sun, 6 Jun 2004 09:39:24 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mike McCormack <mike@codeweavers.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: WINE + NX (No eXecute) support for x86, 2.6.7-rc2-bk2
Message-ID: <20040606083924.GA6664@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mike McCormack <mike@codeweavers.com>, mingo@elte.hu,
	linux-kernel@vger.kernel.org
References: <40C2B51C.9030203@codeweavers.com> <20040606073241.GA6214@infradead.org> <40C2E045.8090708@codeweavers.com> <20040606081021.GA6463@infradead.org> <40C2E5DC.8000109@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C2E5DC.8000109@codeweavers.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06, 2004 at 06:37:32PM +0900, Mike McCormack wrote:
> 
> Christoph Hellwig wrote:
> 
> >Huh?  binfmts do work on all linux architectures unchanged.  What you do
> >on other operating systems is up to you.  And btw, netbsd already has
> >binfmt_pecoff, you could certainly make use of that, too.
> 
> Working on only two platforms is not really what I'd call portable.

Linux itself is portable so a linux driver also is portable.  IF you care
for multiple OSes you need to do additional work of course.  Which isn't
the end of the world either.

> True, we are relying on undocumented assumptions.  On the other hand, 
> there's plenty of programs that rely on undocumented assumptions. 
> Binary compatability to me means that the same binary will work even 
> when the underlying system changes... is there a caveat that I missed?

And there's plenty of programs that break because of that.  Wine is now
one of those.  You can either cludge around your brokenness even more or
try to get it fixed.  Your choice.

