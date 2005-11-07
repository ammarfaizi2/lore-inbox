Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbVKGBkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbVKGBkd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 20:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbVKGBkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 20:40:33 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:30661 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932396AbVKGBkc (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 20:40:32 -0500
Date: Mon, 7 Nov 2005 01:40:31 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: [patch 5/14] mm: set_page_refs opt
Message-ID: <20051107014031.GB9170@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
References: <436DBAC3.7090902@yahoo.com.au> <436DBCBC.5000906@yahoo.com.au> <436DBCE2.4050502@yahoo.com.au> <436DBD11.8010600@yahoo.com.au> <436DBD31.8060801@yahoo.com.au> <436DBD82.2070500@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436DBD82.2070500@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2005 at 07:23:30PM +1100, Nick Piggin wrote:
> 5/14
> 
> -- 
> SUSE Labs, Novell Inc.
> 

> Inline set_page_refs. Remove mm/internal.h

So why don't you keep the inline function in mm/internal.h?  this isn't
really stuff we want driver writers to use every.

