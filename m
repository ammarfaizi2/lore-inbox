Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266896AbUHTNTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266896AbUHTNTl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 09:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266917AbUHTNTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 09:19:41 -0400
Received: from zimbo.cs.wm.edu ([128.239.2.64]:45256 "EHLO zimbo.cs.wm.edu")
	by vger.kernel.org with ESMTP id S266896AbUHTNTc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 09:19:32 -0400
Date: Fri, 20 Aug 2004 09:19:31 -0400
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bind Mount Extensions 0.05
Message-ID: <20040820131931.GA4565@escher.cs.wm.edu>
References: <20040818125104.GA12286@MAIL.13thfloor.at> <20040818172855.GC14628@MAIL.13thfloor.at> <20040819002803.GA18304@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040819002803.GA18304@MAIL.13thfloor.at>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> okay, the patch for 2.6.8.1 was updated and should be fine
> now, please let me know if you encounter any issues, as the
> version for 2.6.8.1 is relatively new ...
> 
> http://www.13thfloor.at/patches/patch-2.6.8.1-bme0.05.1.diff

This patch works wonderfully for me (with ext3).

Have you investigated which cases cause MNT_IS_RDONLY to be called
with a NULL vfsmount, and whether any of these cases are meaningful?

Quoting Christoph Hellwig (hch@infradead.org):
> On Wed, Aug 18, 2004 at 02:49:59PM +0100, Jonathan Sambrook wrote:
> > What's the likelyhood/timeframe for this getting into mainline kernels?
> 
> This patch? not at all.  THe feature?  Maybe this year, but as it'll need
> interface changes I'm not sure it's a good idea to do it in 2.6.

What are the interface changes which will improve this patch?

Is waiting until 2.7 unnecessary given the new kernel development model?
Or are the interface changes just that drastic?  :)

thanks,
-serge
