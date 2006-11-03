Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753029AbWKCDwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753029AbWKCDwG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 22:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753035AbWKCDwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 22:52:05 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:17818 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1753029AbWKCDwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 22:52:03 -0500
Date: Thu, 2 Nov 2006 22:51:30 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Mark Williamson <mark.williamson@cl.cam.ac.uk>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Michael Halcrow <mhalcrow@us.ibm.com>, Erez Zadok <ezk@cs.sunysb.edu>,
       Christoph Hellwig <hch@infradead.org>, Al Viro <viro@ftp.linux.org.uk>,
       Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] fsstack: Generic get/set lower object functions
Message-ID: <20061103035130.GC13499@filer.fsl.cs.sunysb.edu>
References: <20061102035928.679.60601.stgit@thor.fsl.cs.sunysb.edu> <1162483565.6299.98.camel@lade.trondhjem.org> <20061103032702.GB13499@filer.fsl.cs.sunysb.edu> <200611030345.51167.mark.williamson@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611030345.51167.mark.williamson@cl.cam.ac.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2006 at 03:45:50AM +0000, Mark Williamson wrote:
> > > Why are you defining all these structs that are just wrapping unions?
> >
> > The reason for the union is simple...
...
> I guess that having a union foo * rather than a struct foo * would be a bit 
> unconventional in the kernel.  The named struct / anonymous union combo does 
> hide the union as merely an implementation detail, which is nice.  Was this 
> your motivation?

That's exactly it. Save space & hide the details.

Josef "Jeff" Sipek.

-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
