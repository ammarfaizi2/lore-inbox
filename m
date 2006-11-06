Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753920AbWKFXRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920AbWKFXRw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 18:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753921AbWKFXRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 18:17:52 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:27583 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1753920AbWKFXRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 18:17:51 -0500
Date: Mon, 6 Nov 2006 23:17:49 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       Theodore Tso <tytso@mit.edu>
Subject: Re: [RFC/PATCH] - revert generic_fillattr stat->blksize to PAGE_CACHE_SIZE
Message-ID: <20061106231749.GB29711@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Eric Sandeen <sandeen@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Theodore Tso <tytso@mit.edu>
References: <454FAE0A.3070409@redhat.com> <20061106230547.GA29711@infradead.org> <454FC20F.8040206@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454FC20F.8040206@redhat.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2006 at 05:15:27PM -0600, Eric Sandeen wrote:
> > I agree with the conclusion, but the patch is incomplete.  You went down
> > all the way to find out what the fileystems do in this messages, so add
> > the hunks to override the defaults for non-standard filesystems to the
> > patch aswell to restore the pre-inode diet state.
> 
> Well, agreed.  I put 80% or more back to pre-patch state, but not all.
> :)  So it's less broken with my patch than without, so at least it's
> moving forward.  So... Ted's patches get in w/o fixing up all the other
> filesystems (left as an exercise to the patch reader) but mine can't? :)

It's because no reviwer noticed the breakage Ted put in ;-)  I think if
you really refused to do the remaining 20% we can try to pressured Ted to
do it and if that doesn't work I'll just do it myself because I'll be
tired of arguing at that point.. 
