Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbVCCCGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVCCCGF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 21:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVCCCGC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 21:06:02 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:48849 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261336AbVCCB73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 20:59:29 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 3 Mar 2005 12:59:20 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16934.28536.137910.735002@cse.unsw.edu.au>
Cc: Dave Jones <davej@redhat.com>, davem@davemloft.net, jgarzik@pobox.com,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
In-Reply-To: message from Andrew Morton on Wednesday March 2
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
	<42264F6C.8030508@pobox.com>
	<20050302162312.06e22e70.akpm@osdl.org>
	<42265A6F.8030609@pobox.com>
	<20050302165830.0a74b85c.davem@davemloft.net>
	<20050303011151.GJ10124@redhat.com>
	<20050302172049.72a0037f.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday March 2, akpm@osdl.org wrote:
> Dave Jones <davej@redhat.com> wrote:
> >
> > So what was broken with the 2.6.8.1 type of 'hotfix kernel' release ?
> 
> That's an alternative, of course.
> 
> But that _is_ a branch, and does need active forward- and (mainly)
> backward-porting work.
> 
> There's nothing wrong with it per-se, but it becomes a "stabilised version
> of the kernel.org tree" or even a "production version of the kernel.org
> tree".  In other words it's somewhere on the line between the mainline
> kernel.org tree and a distribution.  How far along that line should it
> be positioned?

I think there is a case for the "community" providing the most
"stable" kernel that it (reasonably) can without depending on
"distributions" to do that.

One reason is that (some) distributions are known to have released
kernels with quite broken and unreviewed patches, or with new
functionality that never ends up appearing in main-line for whatever
reason.   
Further, it would surely be useful for all distributions to have one
central place that 'stablising' patches appear so they can
pick-and-choose from them rather than each keeping their own
independent set.

For the kernel, I am the "distribution" for my employer and I choose
which kernel to use, with which patches.  I really don't want to hunt
around for all those stablisation patches, or sift through the patches
in 2.6.X+1-pre to find things to apply to 2.6.X.  I would be really
happy there was a central place where maintainers can put suitably
reviewed "important bug fix"es for recent releases, and from where
kernel maintainers for any distribution (official or not) could pull
them. 

Having said that, I am not in a position to offer my services to
maintain such a really-stable kernel branch, so I'll just cope with
whatever is provided.

NeilBrown
