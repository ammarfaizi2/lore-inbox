Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbTEQV5K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 17:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbTEQV5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 17:57:10 -0400
Received: from CPE-65-29-137-188.wi.rr.com ([65.29.137.188]:33774 "EHLO
	supa.0xd6.org") by vger.kernel.org with ESMTP id S261872AbTEQV5J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 17:57:09 -0400
Date: Sat, 17 May 2003 17:09:12 -0500
From: Paul Mundt <lethal@linux-sh.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Dreamcast framebuffer updates.
Message-ID: <20030517220912.GA16800@linux-sh.org>
References: <20030517215102.A21395@infradead.org> <Pine.LNX.4.44.0305172159090.21274-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305172159090.21274-100000@phoenix.infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 17, 2003 at 09:59:35PM +0100, James Simmons wrote:
> > >  #ifdef CONFIG_MTRR
> > > -  #include <asm/mtrr.h>
> > > +#include <asm/mtrr.h>
> > >  #endif
> > 
> > how can CONFIG_MTRR ever be set for sh?
> 
> Paul ???   Is it possible? 
> 
No, its not possible. Things were originally written with generic pvr2
hardware in mind (including PVR2 PCI boards like the Neon 250).
Unfortunately I don't have any of that hardware, so these days its all
SH specific. As such, the MTRR stuff can be removed without any
problems.

