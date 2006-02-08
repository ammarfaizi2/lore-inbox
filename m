Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030391AbWBHFOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030391AbWBHFOL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 00:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030390AbWBHFOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 00:14:11 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:25544 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030389AbWBHFOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 00:14:09 -0500
Date: Tue, 7 Feb 2006 21:13:58 -0800
From: Paul Jackson <pj@sgi.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       akpm@osdl.org, ck@vds.kolivas.org
Subject: Re: [PATCH] mm: implement swap prefetching
Message-Id: <20060207211358.8b970343.pj@sgi.com>
In-Reply-To: <200602081606.19656.kernel@kolivas.org>
References: <200602071028.30721.kernel@kolivas.org>
	<200602071502.41456.kernel@kolivas.org>
	<20060207204655.f1c69875.pj@sgi.com>
	<200602081606.19656.kernel@kolivas.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con wrote:
> > If you don't do that, then consider disabling this thing entirely
> > if CONFIG_NUMA is enabled.  This swap prefetching sounds like it
> > could be a loose canon ball in a NUMA box.
> 
> That's probably a less satisfactory option since NUMA isn't that rare with the 
> light numa of commodity hardware.

You're right -- my suggestion was not a good one.

I expect that the main distros are or will be shipping their stock PC
kernel with NUMA enabled.  Most of these kernels end up on exactly the
kind of system that is the target audience for swap prefetching.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
