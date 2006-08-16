Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbWHPWsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWHPWsH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 18:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbWHPWsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 18:48:06 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:31657 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932309AbWHPWsE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 18:48:04 -0400
Date: Thu, 17 Aug 2006 08:47:50 +1000
From: Nathan Scott <nathans@sgi.com>
To: Paul Slootman <paul+nospam@wurtel.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-git3 - XFS - BUG: unable to handle kernel NULL pointer dereference at virtual address 00000078
Message-ID: <20060817084750.B2787212@wobbly.melbourne.sgi.com>
References: <3aa654a40608072039r2b5c5a19hbd3e68e4fee40869@mail.gmail.com> <9a8748490608110133v5f973cf6w1af340f59bb229ec@mail.gmail.com> <9a8748490608110325k25c340e2yac925eb226d1fe4f@mail.gmail.com> <20060814120032.E2698880@wobbly.melbourne.sgi.com> <ebv3ji$gls$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <ebv3ji$gls$1@news.cistron.nl>; from paul+nospam@wurtel.net on Wed, Aug 16, 2006 at 12:38:10PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 12:38:10PM +0000, Paul Slootman wrote:
> Nathan Scott  <nathans@sgi.com> wrote:
> >On Fri, Aug 11, 2006 at 12:25:03PM +0200, Jesper Juhl wrote:
> >> I didn't capture all of the xfs_repair output, but I did get this :
> >> ...
> >> Phase 4 - check for duplicate blocks...
> >>         - setting up duplicate extent list...
> >>         - clear lost+found (if it exists) ...
> >>         - clearing existing "lost+found" inode
> >>         - deleting existing "lost+found" entry
> >>         - check for inodes claiming duplicate blocks...
> >>         - agno = 0
> >>         - agno = 1
> >>         - agno = 2
> >>         - agno = 3
> >>         - agno = 4
> >>         - agno = 5
> >>         - agno = 6
> >> LEAFN node level is 1 inode 412035424 bno = 8388608
> >
> >Ooh.  Can you describe this test case you're using?  Something with
> >a bunch of renames in it, obviously, but I'd also like to be able to
> >reproduce locally with the exact data set (file names in particular),
> >if at all possible.
> 
> >From your reaction above I gather that "LEAFN node level is 1 inode ..."
> is a bad thing?
> 
> My filesystem (that crashes under heavy load, while rsyncing to and from
> it) has a lot of these messages when xfs_repair is run.

Do you have a reproducible test case?  Please send a go-to-woe recipe
so I can see the problem first hand... and preferably one that is, er,
slightly simpler than Jesper's case.

thanks.

-- 
Nathan
