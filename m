Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932512AbWGZIHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbWGZIHB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 04:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbWGZIHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 04:07:01 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:32149 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932512AbWGZIHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 04:07:00 -0400
Date: Wed, 26 Jul 2006 09:06:56 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Josh Triplett <josht@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       nfs@lists.sourceforge.net, Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: [NFS] [PATCH] [nfsd] Add lock annotations to e_start and e_stop
Message-ID: <20060726080656.GA28346@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Josh Triplett <josht@us.ibm.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, nfs@lists.sourceforge.net,
	Neil Brown <neilb@cse.unsw.edu.au>
References: <1153840824.12517.9.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153840824.12517.9.camel@josh-work.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 08:20:24AM -0700, Josh Triplett wrote:
> e_start acquires svc_export_cache.hash_lock, and e_stop releases it.  Add lock
> annotations to these two functions so that sparse can check callers for lock
> pairing, and so that sparse will not complain about these functions since they
> intentionally use locks in this manner.
> 
> Signed-off-by: Josh Triplett <josh@freedesktop.org>

The Signed-off-by: line doesn't match the from line of this mail.  Is that
any problem or fine in general?

