Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262136AbVAOCMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbVAOCMX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 21:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbVAOCMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 21:12:22 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:31402 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262136AbVAOCMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 21:12:07 -0500
Date: Sat, 15 Jan 2005 13:09:08 +1100
From: Nathan Scott <nathans@sgi.com>
To: Jakob Oestergaard <jakob@unthought.net>,
       David Greaves <david@dgreaves.com>,
       Christoph Hellwig <hch@infradead.org>, Jan Kasprzak <kas@fi.muni.cz>,
       linux-kernel@vger.kernel.org, kruty@fi.muni.cz
Subject: Re: XFS: inode with st_mode == 0
Message-ID: <20050115130908.A1336757@wobbly.melbourne.sgi.com>
References: <20041209125918.GO9994@fi.muni.cz> <20041209135322.GK347@unthought.net> <20041209215414.GA21503@infradead.org> <20041221184304.GF16913@fi.muni.cz> <20041222084158.GG347@unthought.net> <20041222182344.GB14586@infradead.org> <41E80C1F.3070905@dgreaves.com> <20050114182308.GE347@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050114182308.GE347@unthought.net>; from jakob@unthought.net on Fri, Jan 14, 2005 at 07:23:09PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2005 at 07:23:09PM +0100, Jakob Oestergaard wrote:
> > Is there a 2.6.10 patch that I could apply? Or do you have any other 
> > suggestions.
> 
> AFAIK the best you can do is to get the most recent XFS kernel from
> SGI's CVS (this one is based on 2.6.10).

The -mm tree also has these fixes; we'll get them merged into
mainline soon.

> If you run that kernel, then most of the former problems will be gone;
> *) I only have one undeletable directory on my system - so it seems that
> this error is no longer common   ;)

You may need to run xfs_repair to clean that up..?  Or does
the problem persist after a repair?

cheers.

-- 
Nathan
