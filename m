Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268283AbUI2NnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268283AbUI2NnF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 09:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268447AbUI2Nj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 09:39:59 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:36356 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268372AbUI2Ngq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 09:36:46 -0400
Date: Wed, 29 Sep 2004 14:36:44 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrea Carpani <andrea.carpani@criticalpath.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Adaptec aic79xx driver status
Message-ID: <20040929143644.A12725@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrea Carpani <andrea.carpani@criticalpath.net>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <415AB021.70605@criticalpath.net> <20040929140909.A12373@infradead.org> <415AB9F3.4050803@criticalpath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <415AB9F3.4050803@criticalpath.net>; from andrea.carpani@criticalpath.net on Wed, Sep 29, 2004 at 03:34:43PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2004 at 03:34:43PM +0200, Andrea Carpani wrote:
> Christoph Hellwig wrote:
> 
> > Because it's broken in various ways.  We're working with Adaptec to get
> > the fixes merged but not the bogus parts.  But as Justin didn't cooperate
> > the new engineer in his position has a hard time to untangle the mess, so
> > it'll take a while.
> 
> I'm trying it right now and it looks as if the freeze errors are gone.
> What do you mean by "broken in various ways"? Would it be unwise to use 
> it in a production environment?

we had problem reports for various cards, and lots of problems with error
handling during load and unload.  If it properly loads and unloads for you
and the kernel driver doesn't work just use it.  We hope to have a more
update driver in 2.6.10.
