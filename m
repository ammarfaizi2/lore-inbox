Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbWC3OUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWC3OUM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 09:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWC3OUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 09:20:11 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:50587 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932220AbWC3OUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 09:20:10 -0500
Date: Thu, 30 Mar 2006 15:20:04 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       torvalds@osdl.org
Subject: Re: [PATCH] splice support #2
Message-ID: <20060330142004.GA11934@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, Jens Axboe <axboe@suse.de>,
	linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
References: <20060330100630.GT13476@suse.de> <20060330120055.GA10402@elte.hu> <20060330120512.GX13476@suse.de> <20060330121030.GA14621@elte.hu> <20060330121638.GA13476@suse.de> <20060330123805.GA18726@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060330123805.GA18726@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 02:38:05PM +0200, Ingo Molnar wrote:
> ok :) I think this code should be merged into v2.6.17 - it's very clean 
> and unintrusive.

no.  there's a reason we have a staging area in -mm.  Especially for things
introducing a new user ABI.  Give it a few weeks exposure in which a few
things will change for sure instead of rushing it into a release.

