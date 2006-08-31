Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbWHaSGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbWHaSGj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 14:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbWHaSGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 14:06:39 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:34981 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932432AbWHaSGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 14:06:38 -0400
Date: Thu, 31 Aug 2006 11:06:31 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Dave Hansen <haveblue@us.ibm.com>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [RFC][PATCH 3/9] actual generic PAGE_SIZE infrastructure
In-Reply-To: <1157047058.31295.28.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0608311104010.12835@schroedinger.engr.sgi.com>
References: <20060830221604.E7320C0F@localhost.localdomain> 
 <20060830221606.40937644@localhost.localdomain> 
 <Pine.LNX.4.64.0608301658130.5789@schroedinger.engr.sgi.com>
 <1157047058.31295.28.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2006, Dave Hansen wrote:

> > Note that the default pagesize on IA64 is 16K and some important things 
> > would change if a lesser size is selected. I have never run a 4K kernel. 
> > I do not think we can just say that 4KB is okay. There may be other 
> > platforms that have other default page sizes.
> 
> If we can't just say that it is OK, then we should probably disable it
> in Kconfig.  Should we do that?

Well, we cannot disable 4K support for all platforms, so I guess this 
refers only to IA64.

IA64 can certainly be build with 4K support. I am not sure how well user 
space tools play with it. Better leave it selectable unless others on 
linux-ia64 have something to say on the issue.

