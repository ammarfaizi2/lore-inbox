Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264853AbUD2V1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264853AbUD2V1W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 17:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264970AbUD2VYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 17:24:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28823 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264738AbUD2VU4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 17:20:56 -0400
Date: Thu, 29 Apr 2004 17:20:38 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Erik Jacobson <erikj@subway.americas.sgi.com>
cc: Christoph Hellwig <hch@lst.de>, Paul Jackson <pj@sgi.com>,
       <chrisw@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Process Aggregates (PAGG) support for the 2.6 kernel
In-Reply-To: <Pine.SGI.4.53.0404291447220.732952@subway.americas.sgi.com>
Message-ID: <Pine.LNX.4.44.0404291719400.9152-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Apr 2004, Erik Jacobson wrote:

> If you're saying there really is zero chance even if I implement all the
> suggestions and have things that use it, I guess I'll just have to live
> with that (what's my other choice? :).

I suspect there's a rather good chance of merging a common
PAGG/CKRM infrastructure, since they pretty much do the same
thing at the core and they both have different functionality
implemented on top of the core process grouping.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

