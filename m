Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030365AbWGZITj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030365AbWGZITj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 04:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030366AbWGZITj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 04:19:39 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:42399 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030365AbWGZITi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 04:19:38 -0400
Subject: Re: [NFS] [PATCH] [nfsd] Add lock annotations to e_start and e_stop
From: Arjan van de Ven <arjan@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Josh Triplett <josht@us.ibm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, nfs@lists.sourceforge.net,
       Neil Brown <neilb@cse.unsw.edu.au>
In-Reply-To: <20060726080656.GA28346@infradead.org>
References: <1153840824.12517.9.camel@josh-work.beaverton.ibm.com>
	 <20060726080656.GA28346@infradead.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 26 Jul 2006 10:19:35 +0200
Message-Id: <1153901976.3381.1.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-26 at 09:06 +0100, Christoph Hellwig wrote:
> On Tue, Jul 25, 2006 at 08:20:24AM -0700, Josh Triplett wrote:
> > e_start acquires svc_export_cache.hash_lock, and e_stop releases it.  Add lock
> > annotations to these two functions so that sparse can check callers for lock
> > pairing, and so that sparse will not complain about these functions since they
> > intentionally use locks in this manner.
> > 
> > Signed-off-by: Josh Triplett <josh@freedesktop.org>
> 
> The Signed-off-by: line doesn't match the from line of this mail.  Is that
> any problem or fine in general?

As far as I can see it's customary for the SOB line to state the
affiliation of the person, eg the company that wants to own the
copyright on the code. So I'd expect Josh to use his ibm.com account...

Greetings,
   Arjan van de Ven


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

