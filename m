Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263191AbUE1OTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263191AbUE1OTn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 10:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263199AbUE1OTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 10:19:43 -0400
Received: from [213.146.154.40] ([213.146.154.40]:61878 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263191AbUE1OTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 10:19:40 -0400
Date: Fri, 28 May 2004 15:19:39 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Erik Jacobson <erikj@subway.americas.sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Process Aggregates (PAGG) update for 2.6.6
Message-ID: <20040528141939.GA28626@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Erik Jacobson <erikj@subway.americas.sgi.com>,
	linux-kernel@vger.kernel.org
References: <Pine.SGI.4.53.0405270907220.636588@subway.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SGI.4.53.0405270907220.636588@subway.americas.sgi.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2004 at 09:15:36AM -0500, Erik Jacobson wrote:
> Hi there.
> 
> Attached is a fresh PAGG patch for the 2.6.6 kernel.
> 
> This patch implements the LKML feedback received so far (with very few
> exceptions).
> 
> I would be happy to post the inescapable jobs patch (a user of PAGG) as well.
> It can be found here (along with pagg):
> 
> http://oss.sgi.com/projects/pagg/

Looks nice to me.  Can you fix up the comments a little to use kernel-doc
style for function/structure defintion block comments and remove the useless
Description: for the top-of-the-file comments?

Also didn't we agree on making the export _GPL?

And after all that we have a nice hookin mechanism without users, so where
are the modules layering ontop of pagg hiding? ;-)
