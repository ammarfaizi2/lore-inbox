Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbUKDPyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbUKDPyj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 10:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262242AbUKDPyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 10:54:39 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:59590 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261189AbUKDPyh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 10:54:37 -0500
Subject: Re: truncate issues in 2.6.10-rc1-mm2 ?
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Nathan Scott <nathans@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041103232815.GA7478@frodo>
References: <1099518398.21024.24.camel@dyn318077bld.beaverton.ibm.com>
	 <20041103142928.609a9c64.akpm@osdl.org>  <20041103232815.GA7478@frodo>
Content-Type: text/plain
Organization: 
Message-Id: <1099582837.23725.1.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 Nov 2004 07:40:38 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't have a reproducible case either. Just randomly happens,
once in a while - requiring a force reboot of the machine.

Thanks,
Badari

On Wed, 2004-11-03 at 15:28, Nathan Scott wrote:
> On Wed, Nov 03, 2004 at 02:29:28PM -0800, Andrew Morton wrote:
> > Badari Pulavarty <pbadari@us.ibm.com> wrote:
> > >
> > > I seem to be running into truncate issues on 2.6.10-rc1-mm2.
> > > Kernel compile hangs. Here is the sysrq-t output for the
> > > process. Do you know ?
> > 
> > Beats me.  If we can find a workload which reproduces it in a sane amount
> > of time I can do a binary search.
> 
> I have also had a report of this on a very recent SLES9 updates
> kernel, from looking through the patches the SUSE folks have and
> those in the -mm, the invalidate_inode_pages2 patch is in both
> so it could be the cause, but thats just a guess so far (patch
> name in -mm is invalidate_inode_pages-mmap-coherency-fix.patch).
> 
> I don't have a reproducible test case yet either.
> 
> cheers.

