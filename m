Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbVANSXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVANSXZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 13:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbVANSXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 13:23:25 -0500
Received: from unthought.net ([212.97.129.88]:2470 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S261264AbVANSXM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 13:23:12 -0500
Date: Fri, 14 Jan 2005 19:23:09 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: David Greaves <david@dgreaves.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kasprzak <kas@fi.muni.cz>,
       linux-kernel@vger.kernel.org, kruty@fi.muni.cz
Subject: Re: XFS: inode with st_mode == 0
Message-ID: <20050114182308.GE347@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	David Greaves <david@dgreaves.com>,
	Christoph Hellwig <hch@infradead.org>, Jan Kasprzak <kas@fi.muni.cz>,
	linux-kernel@vger.kernel.org, kruty@fi.muni.cz
References: <20041209125918.GO9994@fi.muni.cz> <20041209135322.GK347@unthought.net> <20041209215414.GA21503@infradead.org> <20041221184304.GF16913@fi.muni.cz> <20041222084158.GG347@unthought.net> <20041222182344.GB14586@infradead.org> <41E80C1F.3070905@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E80C1F.3070905@dgreaves.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2005 at 06:14:55PM +0000, David Greaves wrote:
> 
...
> >try XFS CVS (which is at 2.6.9) + the patch below instead of plain 2.6.9,
> >there have been various other fixes in the last months.
> > 
> >
> That not all the changes in XFS CVS have made it to 2.6.10?
> 
> Is there a 2.6.10 patch that I could apply? Or do you have any other 
> suggestions.

AFAIK the best you can do is to get the most recent XFS kernel from
SGI's CVS (this one is based on 2.6.10).

If you run that kernel, then most of the former problems will be gone;
*) I only have one undeletable directory on my system - so it seems that
this error is no longer common   ;)
*) 2.6.10 apparently fixes the knfsd stale handle problem
*) I no longer see the weird directory/file/??? mode problems or random
ownership assignment

So apart from the general well known instability problems that will
occur when you actually start *using* the system, there should be no
major problems running XFS+SMP+NFS on SGI's 2.6.10 based kernel   ;)

-- 

 / jakob

