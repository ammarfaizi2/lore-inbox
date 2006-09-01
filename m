Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbWIARXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWIARXz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 13:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWIARXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 13:23:55 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:65245 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1750946AbWIARXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 13:23:54 -0400
Date: Fri, 1 Sep 2006 13:23:10 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH 00/22][RFC] Unionfs: Stackable Namespace Unification Filesystem
Message-ID: <20060901172310.GA2622@filer.fsl.cs.sunysb.edu>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu> <20060901115327.80554494.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060901115327.80554494.sfr@canb.auug.org.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2006 at 11:53:27AM +1000, Stephen Rothwell wrote:
> On Thu, 31 Aug 2006 21:35:13 -0400 Josef Sipek <jsipek@cs.sunysb.edu> wrote:
> >
> > This set of patches constitutes Unionfs version 2.0. We are presenting it to
> > be reviewed and considered for inclusion into the kernel.
> 
> Small nit: is it possible to order these patches so that the kernel
> builds at each intermediate point (so we can use git bisect).  The
> easiest way to achieve this would be to do the Kconfig and Makefile
> updates last.

Ideally, when Unionfs is commited into git, the whole thing would be one
commit - what's the point of having half of a filesystem? I reordered the
patches for the next submission so that the Makefile & kconfig one is last.

Thanks,

Josef "Jeff" Sipek.
