Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWEESLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWEESLk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 14:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWEESLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 14:11:39 -0400
Received: from ns1.suse.de ([195.135.220.2]:9363 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751187AbWEESLj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 14:11:39 -0400
Date: Fri, 5 May 2006 11:10:02 -0700
From: Greg KH <gregkh@suse.de>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH 1/6] kconfigurable resources core changes
Message-ID: <20060505181002.GA2715@suse.de>
References: <20060505172847.GC6450@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060505172847.GC6450@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2006 at 01:28:47PM -0400, Vivek Goyal wrote:
> 
> 
> o Core changes for Kconfigurable memory and IO resources. By default resources
>   are 64bit until chosen to be 32bit.
> 
> o Last time I posted the patches for 64bit memory resources but it raised
>   the concerns regarding code bloat on 32bit systems who use 32 bit
>   resources.
> 
> o This patch-set allows resources to be kconfigurable.
> 
> o I have done cross compilation on i386, x86_64, ppc, powerpc, sparc, sparc64
>   ia64 and alpha.
> 
> Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>

So do these replace all of your other patches sitting in my tree right
now?

thanks,

greg k-h
