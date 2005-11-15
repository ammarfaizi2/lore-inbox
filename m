Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbVKOJSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbVKOJSq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 04:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbVKOJSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 04:18:46 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:62432 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751388AbVKOJSq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 04:18:46 -0500
Date: Tue, 15 Nov 2005 01:18:32 -0800
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Simon.Derr@bull.net, clameter@sgi.com, rohit.seth@intel.com
Subject: Re: [PATCH 03/05] mm rationalize __alloc_pages ALLOC_* flag names
Message-Id: <20051115011832.712d03c8.pj@sgi.com>
In-Reply-To: <4379A399.1080407@yahoo.com.au>
References: <20051114040329.13951.39891.sendpatchset@jackhammer.engr.sgi.com>
	<20051114040353.13951.82602.sendpatchset@jackhammer.engr.sgi.com>
	<4379A399.1080407@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick wrote:
> the downside is that they move away
> from the terminlogy we've been using in the page allocator
> for the past few years.

I was trying to make the names more readable for the rest of us ;).

In the short term, there is seldom a reason to change names,
as it impacts the current experts more than it helps others.

Over a sufficiently long term, everyone is an 'other'.  Most
of the people who will have reason to want to understand this
code over the next five years are not experts in it now.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
