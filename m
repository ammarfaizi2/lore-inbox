Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWETJGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWETJGR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 05:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWETJGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 05:06:17 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:35512 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932176AbWETJGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 05:06:16 -0400
Date: Sat, 20 May 2006 10:06:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] i386: don't consider regparm EXPERIMENTAL anymore
Message-ID: <20060520090614.GA9630@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <20060520025353.GE9486@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060520025353.GE9486@taniwha.stupidest.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2006 at 07:53:53PM -0700, Chris Wedgwood wrote:
>   [This might be a tad premature given recent tail-call fixups?]
> 
> ---
> 
> Drop EXPERIMENTAL status from REGPARM as a lot of people seem to use
> it and it seems to be pretty stable these days.

Just kill the option completely.  It works nicely, generates better code
and we've stopped support for the old, broken compilers not handling it.

