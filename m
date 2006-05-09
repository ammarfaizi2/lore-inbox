Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbWEIUDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbWEIUDM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 16:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbWEIUDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 16:03:12 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:30927 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751057AbWEIUDL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 16:03:11 -0400
Date: Tue, 9 May 2006 16:03:01 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>, Morton Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH 1/6] kconfigurable resources core changes
Message-ID: <20060509200301.GA15891@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060505172847.GC6450@in.ibm.com> <2C184B1B-9F70-4175-B90B-A1CC5741A6DE@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2C184B1B-9F70-4175-B90B-A1CC5741A6DE@kernel.crashing.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 02:33:48PM -0500, Kumar Gala wrote:
> 
> On May 5, 2006, at 12:28 PM, Vivek Goyal wrote:
> 
> >
> >
> >o Core changes for Kconfigurable memory and IO resources. By  
> >default resources
> >  are 64bit until chosen to be 32bit.
> >
> >o Last time I posted the patches for 64bit memory resources but it  
> >raised
> >  the concerns regarding code bloat on 32bit systems who use 32 bit
> >  resources.
> >
> >o This patch-set allows resources to be kconfigurable.
> >
> >o I have done cross compilation on i386, x86_64, ppc, powerpc,  
> >sparc, sparc64
> >  ia64 and alpha.
> >
> >Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
> >---
> 
> [snip]
> 
> I didn't think the bloat was a big issue based on the numbers you  
> reported.  I'd still prefer to see us just move to a 64-bit resource  
> on all systems.

I had also thought that bloat was not a big issue but Andrew thinks
otherwise. Here is the link to the thread.

http://marc.theaimsgroup.com/?l=linux-kernel&m=114626907106986&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=114635425606186&w=2

In the latest patches, 64bit resources are default but one can force
these to be 32bit.

Thanks
Vivek
