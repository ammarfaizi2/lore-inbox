Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWC0Fh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWC0Fh1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 00:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbWC0Fh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 00:37:27 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:1984 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750708AbWC0Fh0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 00:37:26 -0500
Date: Mon, 27 Mar 2006 16:33:37 +1100
From: Nathan Scott <nathans@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at fs/direct-io.c:916!
Message-ID: <20060327053337.GB2481@frodo>
References: <20060326230206.06C1EE083AAB@knarzkiste.dyndns.org> <20060326180440.GA4776@charite.de> <20060326184644.GC4776@charite.de> <20060327080811.D753448@wobbly.melbourne.sgi.com> <20060326230358.GG4776@charite.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20060326230358.GG4776@charite.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2006 at 01:03:59AM +0200, Ralf Hildebrandt wrote:
> * Nathan Scott <nathans@sgi.com>:
> 
> > Hmm, there were XFS patches in -mm last week, but they also got
> > merged to mainline last week, not clear whether your git kernel
> > had those changes or not.  I think there's probably some direct
> > I/O (generic) changes in -mm too based on list traffic from the
> > last couple of weeks (I'm an -mm lamer, sorry, couldn't easily
> > tell you exactly what patches those might be) - could you retry
> > with todays git snapshot and see if mainline is affected?  Else
> > we'll need to find and analyse any -mm fs/direct-io.c patches.
> 
> 2.6.16-git12 also fails utterly:

Could you find the inode number where its failing (fsr -v -d) and
send me the xfs_bmap output for that file - use find -inum to get
from an inum to a path for bmap.

thanks.

-- 
Nathan
