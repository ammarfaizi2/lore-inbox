Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbUE1Cm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbUE1Cm5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 22:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbUE1Cm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 22:42:57 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:23983 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261913AbUE1Cm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 22:42:56 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Olaf Kirch <okir@suse.de>
Date: Fri, 28 May 2004 12:42:19 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16566.42763.369802.387581@cse.unsw.edu.au>
Cc: linux@horizon.com, akpm@osdl.org, kerndev@sc-software.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6 is crashing repeatedly
In-Reply-To: message from Olaf Kirch on Thursday May 27
References: <20040520060805.1620.qmail@science.horizon.com>
	<20040527112508.24292.qmail@science.horizon.com>
	<16565.53893.357718.79@cse.unsw.edu.au>
	<20040527120616.GK12225@suse.de>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday May 27, okir@suse.de wrote:
> > > This is not true. The dirent offset is a 64bit quantity, so it's quite
> > > possible it will be split across the page boundary. I'm working on a
> > > patch...
> 
> Here's a patch that hopefully fixes this problem. Please give it
> a try and let me know.
> 
> Neil, does this look okay to you?

Yes, it looks fine.

I'll rediff against 2.6.7-rc1-mm1 (there is a small conflict) and send
it to Andrew.

Thanks,
NeilBrown
