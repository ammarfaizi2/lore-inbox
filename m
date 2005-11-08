Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965236AbVKHSLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965236AbVKHSLO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 13:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965240AbVKHSLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 13:11:13 -0500
Received: from fmr24.intel.com ([143.183.121.16]:39126 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S965236AbVKHSLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 13:11:12 -0500
Subject: Re: [PATCH]: Cleanup of __alloc_pages
From: Rohit Seth <rohit.seth@intel.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Paul Jackson <pj@sgi.com>, akpm@osdl.org, torvalds@osdl.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <43703EFB.1010103@yahoo.com.au>
References: <20051107174349.A8018@unix-os.sc.intel.com>
	 <20051107175358.62c484a3.akpm@osdl.org>
	 <1131416195.20471.31.camel@akash.sc.intel.com>
	 <43701FC6.5050104@yahoo.com.au> <20051107214420.6d0f6ec4.pj@sgi.com>
	 <43703EFB.1010103@yahoo.com.au>
Content-Type: text/plain
Organization: Intel 
Date: Tue, 08 Nov 2005 10:17:56 -0800
Message-Id: <1131473876.2400.9.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Nov 2005 18:10:55.0087 (UTC) FILETIME=[C2E067F0:01C5E48F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-08 at 17:00 +1100, Nick Piggin wrote:

> 
> > However, I appreciate your preference to separate cleanup from semantic
> > change.  Perhaps this means leaving the ALLOC_CPUSET flag in your
> > cleanup patch, then one of us following on top of that with a patch to
> > simplify and fix the cpuset invocation semantics and a second cleanup
> > patch to remove ALLOC_CPUSET as a separate flag.
> > 
> 
> That would be good. I'll send off a fresh patch with the
> ALLOC_WATERMARKS fixed after Rohit gets around to looking over
> it.
> 

Nick, your changes have really come out good.  Thanks.  I think it is
definitely a good starting point as it maintains all of existing
behavior.

I guess now I can argue about why we should keep the watermark low for
GFP_HIGH ;-)

Paul, sorry for troubling you with those magic numbers again in the
original patch...

-rohit

