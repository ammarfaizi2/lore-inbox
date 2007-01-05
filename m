Return-Path: <linux-kernel-owner+w=401wt.eu-S1030341AbXAEGYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030341AbXAEGYK (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 01:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030353AbXAEGYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 01:24:10 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:51779 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030341AbXAEGYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 01:24:07 -0500
Date: Fri, 5 Jan 2007 11:58:42 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-aio@kvack.org, drepper@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, jakub@redhat.com, mingo@elte.hu,
       Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCHSET 1][PATCH 0/6] Filesystem AIO read/write
Message-ID: <20070105062841.GA2653@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20061227153855.GA25898@in.ibm.com> <20061228082308.GA4476@in.ibm.com> <20070103141556.82db0e81.akpm@osdl.org> <20070104045621.GA8353@in.ibm.com> <20070104090242.44dd8165.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070104090242.44dd8165.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2007 at 09:02:42AM -0800, Andrew Morton wrote:
> On Thu, 4 Jan 2007 10:26:21 +0530
> Suparna Bhattacharya <suparna@in.ibm.com> wrote:
> 
> > On Wed, Jan 03, 2007 at 02:15:56PM -0800, Andrew Morton wrote:
> > > On Thu, 28 Dec 2006 13:53:08 +0530
> > > Suparna Bhattacharya <suparna@in.ibm.com> wrote:
> > >
> > > > This patchset implements changes to make filesystem AIO read
> > > > and write asynchronous for the non O_DIRECT case.
> > >
> > > Unfortunately the unplugging changes in Jen's block tree have trashed these
> > > patches to a degree that I'm not confident in my repair attempts.  So I'll
> > > drop the fasio patches from -mm.
> >
> > I took a quick look and the conflicts seem pretty minor to me, the unplugging
> > changes mostly touch nearby code.
> 
> Well...  the conflicts (both mechanical and conceptual) are such that a
> round of retesting is needed.
> 
> > Please let know how you want this fixed up.
> >
> > >From what I can tell the comments in the unplug patches seem to say that
> > it needs more work and testing, so perhaps a separate fixup patch may be
> > a better idea rather than make the fsaio patchset dependent on this.
> 
> Patches against next -mm would be appreciated, please.  Sorry about that.
> 
> I _assume_ Jens is targetting 2.6.21?

When is the next -mm likely to be out ? 

I was considering regenerating the blk unplug patches against the
fsaio changes instead of the other way around, if Jens were willing to accept
that. But if the next -mm is just around the corner then its not an issue.

Regards
Suparna

> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
> Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

