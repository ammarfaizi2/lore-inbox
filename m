Return-Path: <linux-kernel-owner+w=401wt.eu-S932372AbXADRD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbXADRD2 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 12:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbXADRD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 12:03:28 -0500
Received: from smtp0.osdl.org ([65.172.181.24]:36824 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932375AbXADRD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 12:03:27 -0500
Date: Thu, 4 Jan 2007 09:02:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: suparna@in.ibm.com
Cc: linux-aio@kvack.org, drepper@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, jakub@redhat.com, mingo@elte.hu,
       Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCHSET 1][PATCH 0/6] Filesystem AIO read/write
Message-Id: <20070104090242.44dd8165.akpm@osdl.org>
In-Reply-To: <20070104045621.GA8353@in.ibm.com>
References: <20061227153855.GA25898@in.ibm.com>
	<20061228082308.GA4476@in.ibm.com>
	<20070103141556.82db0e81.akpm@osdl.org>
	<20070104045621.GA8353@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2007 10:26:21 +0530
Suparna Bhattacharya <suparna@in.ibm.com> wrote:

> On Wed, Jan 03, 2007 at 02:15:56PM -0800, Andrew Morton wrote:
> > On Thu, 28 Dec 2006 13:53:08 +0530
> > Suparna Bhattacharya <suparna@in.ibm.com> wrote:
> > 
> > > This patchset implements changes to make filesystem AIO read
> > > and write asynchronous for the non O_DIRECT case.
> > 
> > Unfortunately the unplugging changes in Jen's block tree have trashed these
> > patches to a degree that I'm not confident in my repair attempts.  So I'll
> > drop the fasio patches from -mm.
> 
> I took a quick look and the conflicts seem pretty minor to me, the unplugging
> changes mostly touch nearby code.

Well...  the conflicts (both mechanical and conceptual) are such that a
round of retesting is needed.

> Please let know how you want this fixed up.
>
> >From what I can tell the comments in the unplug patches seem to say that
> it needs more work and testing, so perhaps a separate fixup patch may be
> a better idea rather than make the fsaio patchset dependent on this.

Patches against next -mm would be appreciated, please.  Sorry about that.

I _assume_ Jens is targetting 2.6.21?

