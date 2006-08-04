Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161101AbWHDI2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161101AbWHDI2U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 04:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030209AbWHDI2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 04:28:19 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:9918 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1030199AbWHDI2T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 04:28:19 -0400
Subject: Re: [stable] Next 2.6.17-stable review cycle will be starting in
	about 24	hours
From: Marcel Holtmann <marcel@holtmann.org>
To: Neil Brown <neilb@suse.de>
Cc: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, stable@kernel.org
In-Reply-To: <17618.39572.764990.76181@cse.unsw.edu.au>
References: <20060803074850.GA28301@kroah.com>
	 <1154623652.3905.76.camel@aeonflux.holtmann.net>
	 <20060803170020.GA10784@kroah.com>
	 <17618.39572.764990.76181@cse.unsw.edu.au>
Content-Type: text/plain
Date: Fri, 04 Aug 2006 12:25:08 +0200
Message-Id: <1154687108.3905.92.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

> > > > This is a heads up that the next 2.6.17-stable review cycle will be
> > > > starting in about 24 hours.  I've caught up on all pending -stable
> > > > patches that I know about and placed them in our queue, which can be
> > > > browsed online at:
> > > > 	http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=tree;f=queue-2.6.17
> > > > 
> > > > If anyone sees that this queue is missing something that they feel
> > > > should get into the next 2.6.17-stable release, please let us know at
> > > > stable@kernel.org within the next 24 hours or so.
> > > 
> > > instead of ext3-avoid-triggering-ext3_error-on-bad-nfs-file-handle.patch
> > > it makes more sense to include the revised patches from Neil:
> > > 
> > > http://comments.gmane.org/gmane.linux.kernel/430323
> > > 
> > > It seems that these are not merged upstream, but my understanding was
> > > that they were the best way to fix this. For RHEL4 we are going with
> > > these two patches. 
> > 
> > Hm, I just went with what Neil sent me for inclusion.  Neil, do you want
> > me to change the patches you sent us?
> 
> I think the patch you have is adequate for ext3.  It closes the
> important hole.  I think the extra patch for ext3 in the gmane link
> above is not entirely necessary so I wouldn't push it for stable.
> That doesn't make it a wrong choice for RHEL4 though.
> 
> The ext2 patch, on the other hand, should probably go in to stable.

this actually looks unclean to me. I thought the code duplication in
ext2 and ext3 was the price that you have to pay to avoid any layering
violation. I personally would like to see the upstream patch go into
-stable. However we don't have this upstream at the moment. So what
would you consider sending to Linus?

Regards

Marcel


