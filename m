Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262655AbVAQAxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbVAQAxj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 19:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262659AbVAQAxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 19:53:39 -0500
Received: from unthought.net ([212.97.129.88]:59327 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S262655AbVAQAxf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 19:53:35 -0500
Date: Mon, 17 Jan 2005 01:53:34 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Nathan Scott <nathans@sgi.com>
Cc: David Greaves <david@dgreaves.com>, Christoph Hellwig <hch@infradead.org>,
       Jan Kasprzak <kas@fi.muni.cz>, linux-kernel@vger.kernel.org,
       kruty@fi.muni.cz
Subject: Re: XFS: inode with st_mode == 0
Message-ID: <20050117005334.GF347@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Nathan Scott <nathans@sgi.com>, David Greaves <david@dgreaves.com>,
	Christoph Hellwig <hch@infradead.org>, Jan Kasprzak <kas@fi.muni.cz>,
	linux-kernel@vger.kernel.org, kruty@fi.muni.cz
References: <20041209125918.GO9994@fi.muni.cz> <20041209135322.GK347@unthought.net> <20041209215414.GA21503@infradead.org> <20041221184304.GF16913@fi.muni.cz> <20041222084158.GG347@unthought.net> <20041222182344.GB14586@infradead.org> <41E80C1F.3070905@dgreaves.com> <20050114182308.GE347@unthought.net> <20050115130908.A1336757@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050115130908.A1336757@wobbly.melbourne.sgi.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2005 at 01:09:08PM +1100, Nathan Scott wrote:
...
> > AFAIK the best you can do is to get the most recent XFS kernel from
> > SGI's CVS (this one is based on 2.6.10).
> 
> The -mm tree also has these fixes; we'll get them merged into
> mainline soon.

Okeydokey - good

> 
> > If you run that kernel, then most of the former problems will be gone;
> > *) I only have one undeletable directory on my system - so it seems that
> > this error is no longer common   ;)
> 
> You may need to run xfs_repair to clean that up..?  Or does
> the problem persist after a repair?

I'm running Debian Woody - the xfs_check/xfs_repair there didn't seem to
find anything last I tried. I have not re-checked for this last problem
though.

I figured I might need to run the CVS version of xfs tools, and, well,
me being busy and all, I thought I'd just leave the 'delete_me'
directory hanging until some time I got more time on my hands  ;)

-- 

 / jakob

