Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265192AbUD3SPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265192AbUD3SPt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 14:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265195AbUD3SPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 14:15:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:24478 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265192AbUD3SPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 14:15:47 -0400
Date: Fri, 30 Apr 2004 11:15:43 -0700
From: Chris Wright <chrisw@osdl.org>
To: Shailabh <nagar@watson.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, Rik van Riel <riel@redhat.com>,
       Erik Jacobson <erikj@subway.americas.sgi.com>,
       Paul Jackson <pj@sgi.com>, chrisw@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Process Aggregates (PAGG) support for the 2.6 kernel
Message-ID: <20040430111543.X21045@build.pdx.osdl.net>
References: <20040430071750.A8515@infradead.org> <Pine.LNX.4.44.0404300853230.6976-100000@chimarrao.boston.redhat.com> <20040430140611.A11636@infradead.org> <40929297.2030903@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <40929297.2030903@watson.ibm.com>; from nagar@watson.ibm.com on Fri, Apr 30, 2004 at 01:53:27PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Shailabh (nagar@watson.ibm.com) wrote:
> In CKRM, the premise is that the privileged user defines the way 
> processes get grouped and could do so in a way that leads to rapid 
> changes in group membership. So having group control/monitoring 
> policies implemented as an externally loaded module (not talking of 
> scheduler modifications as modules, which is a no-no)  is not a 
> palatable option.

Yes, this is why I looked at the PAGG job module.  I was looking for how
it might have mucked (externally) with scheduler.  At any rate, I found
all the primitives for joining/leaving/defining groups here which I'd
have expected closer to core.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
