Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbWBWRkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWBWRkp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 12:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWBWRko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 12:40:44 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:50666 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932342AbWBWRko
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 12:40:44 -0500
Date: Thu, 23 Feb 2006 09:40:24 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: Dave Hansen <haveblue@us.ibm.com>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH 4/7] ppc64 - Specify amount of kernel memory at boot time
Message-ID: <20060223174024.GB5699@w-mikek2.ibm.com>
References: <20060217141552.7621.74444.sendpatchset@skynet.csn.ul.ie> <20060217141712.7621.49906.sendpatchset@skynet.csn.ul.ie> <1140196618.21383.112.camel@localhost.localdomain> <Pine.LNX.4.64.0602211445160.4335@skynet.skynet.ie> <1140543359.8693.32.camel@localhost.localdomain> <Pine.LNX.4.64.0602221625100.2801@skynet.skynet.ie> <1140712969.8697.33.camel@localhost.localdomain> <Pine.LNX.4.64.0602231646530.24093@skynet.skynet.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602231646530.24093@skynet.skynet.ie>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 05:19:19PM +0000, Mel Gorman wrote:
> On Thu, 23 Feb 2006, Dave Hansen wrote:
> 
> >On Wed, 2006-02-22 at 16:43 +0000, Mel Gorman wrote:
> >>Is this a bit clearer? It's built and boot tested on one ppc64 machine. I
> >>am having trouble finding a ppc64 machine that *has* memory holes to be
> >>100% sure it's ok.
> >
> >Yeah, it looks that way.  If you need a machine, see Mike Kravetz.  I
> >think he was working on a way to automate creating memory holes.
> >
> 
> Will do. If there is an automatic way of creating holes, I'll write it 
> into the current "compare two running kernels" testing script.

I don't realy have an automatic way to create holes.  Just turns out that
the system I was working with was good at creating them itself.

I've sliced and diced (made lots of partitioning changes) the system
recently and am still working on getting everything working right.
When I get everything working again, I'll give the patch set a try.

-- 
Mike
