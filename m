Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbVKTOpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbVKTOpy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 09:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbVKTOpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 09:45:54 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:5587 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751225AbVKTOpx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 09:45:53 -0500
Date: Sun, 20 Nov 2005 06:45:31 -0800
From: Paul Jackson <pj@sgi.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: linux-mm@kvack.org, mingo@elte.hu, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au, lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] Re: [PATCH 1/5] Light Fragmentation Avoidance V20:
 001_antidefrag_flags
Message-Id: <20051120064531.7e7b4771.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.58.0511160135080.8470@skynet>
References: <20051115164946.21980.2026.sendpatchset@skynet.csn.ul.ie>
	<20051115164952.21980.3852.sendpatchset@skynet.csn.ul.ie>
	<20051115150054.606ce0df.pj@sgi.com>
	<Pine.LNX.4.58.0511160135080.8470@skynet>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel wrote:
> +#define __GFP_EASYRCLM   ((__force gfp_t)0x80000u)
> 
> Comment to right removed because the comment above the declaration covers
> everything.

(repeating myself) 
> How about fitting the style (casts, just one line) of the other flags,
> so that these added six lines become instead just the one line:

There is a consistent layout, one-per-line, to the other __GFP_*
flags.  The information content of the extra five lines you use for
the __GFP_EASYRCLM flag does not warrant upsetting that layout, in
my view.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
