Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbVCNA4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVCNA4w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 19:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbVCNA4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 19:56:52 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:2462 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261617AbVCNA4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 19:56:46 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: Mon, 14 Mar 2005 11:56:33 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16948.57665.671437.810184@cse.unsw.edu.au>
Cc: Daniel Jacobowitz <dan@debian.org>, Junfeng Yang <yjf@stanford.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] inconsistent NFS stat cache (NFS on ext3, 2.6.11)
In-Reply-To: message from Trond Myklebust on Sunday March 13
References: <Pine.GSO.4.44.0503120335160.12085-100000@elaine24.Stanford.EDU>
	<1110690267.24123.7.camel@lade.trondhjem.org>
	<20050313200412.GA21521@nevyn.them.org>
	<1110746550.23876.8.camel@lade.trondhjem.org>
	<20050314003512.GA16875@nevyn.them.org>
	<1110761410.30085.13.camel@lade.trondhjem.org>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday March 13, trond.myklebust@fys.uio.no wrote:
> 
> You'll rather want to ask Neil Brown about why subtree_check is still
> the default for knfsd. He is the NFS server maintainer.

Apathy?
No-one has complained loudly enough or long enough or sent me a patch,
and it simply isn't a priority for me.
(a patch would have to provide clear warning to the user of the change
in defaults, such as is currently done for sync/async (and it's
probably time to remove that warning).

Note: this is purely a userspace issue.  nfs-utils sets the default,
not the kernel.

NeilBrown
