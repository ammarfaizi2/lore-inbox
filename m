Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932806AbVJ3DJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932806AbVJ3DJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 23:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932807AbVJ3DJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 23:09:29 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:30699 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932806AbVJ3DJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 23:09:28 -0400
Date: Sat, 29 Oct 2005 20:09:16 -0700
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: rohit.seth@intel.com, akpm@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Clean up of __alloc_pages
Message-Id: <20051029200916.61a32331.pj@sgi.com>
In-Reply-To: <43643195.9040600@yahoo.com.au>
References: <20051028183326.A28611@unix-os.sc.intel.com>
	<20051029184728.100e3058.pj@sgi.com>
	<4364296E.1080905@yahoo.com.au>
	<20051029192611.79b9c5e7.pj@sgi.com>
	<43643195.9040600@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick wrote:
> See how can_try_harder and gfp_high is used currently. 

Ah - by "current" you meant in Linus's or Andrew's tree,
not as in Seth's current patch.  Since they are booleans,
rather than tri-values, using an enum is overkill.  Ok.

Now I'm one less clue short of understanding.  Thanks.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
