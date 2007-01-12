Return-Path: <linux-kernel-owner+w=401wt.eu-S1751571AbXALCOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbXALCOa (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 21:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751572AbXALCOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 21:14:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:57168 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751565AbXALCO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 21:14:29 -0500
Date: Fri, 12 Jan 2007 03:14:21 +0100
From: Nick Piggin <npiggin@suse.de>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas@tungstengraphics.com>
Cc: Dave Airlie <airlied@gmail.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Replace nopage() / nopfn() with fault()
Message-ID: <20070112021421.GA28341@wotan.suse.de>
References: <45A3AE70.603@tungstengraphics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45A3AE70.603@tungstengraphics.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2007 at 04:02:08PM +0100, Thomas Hellström wrote:
> Nick,
> 
> We're working to slowly get the new DRM memory manager into the 
> mainstream kernel.
> This means we have a need for the page fault handler patch you wrote 
> some time ago.
> I guess we could take the no_pfn() route, but that would need a check 
> for racing
> unmap_mapping_range(), and other problems may arise.
> 
> What is the current status and plans for inclusion of the fault() code?

Hi Thomas,

fault should have gone in already, but the ordering of my patchset was
a little bit unfortunate :P

I will submit them to Andrew later today.

Nick

