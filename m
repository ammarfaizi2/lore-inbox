Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbWHQGbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWHQGbs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 02:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWHQGbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 02:31:48 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:37320 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751180AbWHQGbr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 02:31:47 -0400
Date: Thu, 17 Aug 2006 16:31:10 +1000
From: Nathan Scott <nathans@sgi.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, xfs-masters@oss.sgi.com, xfs@oss.sgi.com
Subject: Re: [PATCH] XFS: remove pointless conditional testing 'nmp' vs NULL in fs/xfs/xfs_rtalloc.c::xfs_growfs_rt()
Message-ID: <20060817163109.A2792453@wobbly.melbourne.sgi.com>
References: <200608130016.51136.jesper.juhl@gmail.com> <20060814110942.C2698880@wobbly.melbourne.sgi.com> <9a8748490608140025w3257f315jcceccf05d200437f@mail.gmail.com> <200608162244.19957.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200608162244.19957.jesper.juhl@gmail.com>; from jesper.juhl@gmail.com on Wed, Aug 16, 2006 at 10:44:19PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 10:44:19PM +0200, Jesper Juhl wrote:
> On Monday 14 August 2006 09:25, Jesper Juhl wrote:
> > On 14/08/06, Nathan Scott <nathans@sgi.com> wrote:
> > > On Sun, Aug 13, 2006 at 12:16:50AM +0200, Jesper Juhl wrote:
> > >
> > > > This patch gets rid of the pointless check.
> > >
> > > Hmm, seems like code churn that makes the code slightly less
> > > obvious, but thats just me... I'd prefer a tested patch that
> > > implements the above suggestion, to be honest. :)
> > >
> > Ok, I'll see what I can come up with.
> > 
> 
> How this?
> 
> Compile tested only since I'm at home and don't have any XFS filesystems to
> play with atm.

It looks good.  I've tested it, and it works fine - I'll merge it
into my tree shortly.  Thanks for following up on this.

cheers.

-- 
Nathan
