Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964953AbWD0GPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964953AbWD0GPY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 02:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964954AbWD0GPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 02:15:24 -0400
Received: from mx1.suse.de ([195.135.220.2]:55228 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964953AbWD0GPX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 02:15:23 -0400
From: Andi Kleen <ak@suse.de>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: Lockless page cache test results
Date: Thu, 27 Apr 2006 08:15:18 +0200
User-Agent: KMail/1.9.1
Cc: "'Jens Axboe'" <axboe@suse.de>, "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       linux-kernel@vger.kernel.org, "'Nick Piggin'" <npiggin@suse.de>,
       "'Andrew Morton'" <akpm@osdl.org>, linux-mm@kvack.org
References: <4t153d$r2dpi@azsmga001.ch.intel.com>
In-Reply-To: <4t153d$r2dpi@azsmga001.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604270815.18575.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 April 2006 07:39, Chen, Kenneth W wrote:
 
> (1) 2P Intel Xeon, 3.4 GHz/HT, 2M L2
> http://kernel-perf.sourceforge.net/splice/2P-3.4Ghz.png
> 
> (2) 4P Intel Xeon, 3.0 GHz/HT, 8M L3
> http://kernel-perf.sourceforge.net/splice/4P-3.0Ghz.png
> 
> (3) 4P Intel Xeon, 3.0 GHz/DC/HT, 2M L2 (per core)
> http://kernel-perf.sourceforge.net/splice/4P-3.0Ghz-DCHT.png
> 
> (4) everything on one graph:
> http://kernel-perf.sourceforge.net/splice/splice.png

Looks like a clear improvement for lockless unless I'm misreading the graphs.
(Can you please use different colors next time?)

-Andi

