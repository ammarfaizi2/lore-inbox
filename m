Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932433AbVLAT5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbVLAT5B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 14:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbVLAT5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 14:57:00 -0500
Received: from solarneutrino.net ([66.199.224.43]:9477 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S932428AbVLAT5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 14:57:00 -0500
Date: Thu, 1 Dec 2005 14:56:57 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kai Makisara <Kai.Makisara@kolumbus.fi>, Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       ryan@tau.solarneutrino.net
Subject: Re: Fw: crash on x86_64 - mm related?
Message-ID: <20051201195657.GB7236@tau.solarneutrino.net>
References: <20051129092432.0f5742f0.akpm@osdl.org> <Pine.LNX.4.63.0512012040390.5777@kai.makisara.local> <Pine.LNX.4.64.0512011136000.3099@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512011136000.3099@g5.osdl.org>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 11:38:20AM -0800, Linus Torvalds wrote:
> 
> 
> On Thu, 1 Dec 2005, Kai Makisara wrote:
> 
> > On Tue, 29 Nov 2005, Andrew Morton wrote:
> > >
> > >  Bad page state at free_hot_cold_page (in process 'taper', page ffff81000260b6f8)
> > > flags:0x010000000000000c mapping:ffff8100355f1dd8 mapcount:2 count:0
> > > Backtrace:
> 
> Ryan, can you test 2.6.15-rc4 and report what it does?
> 
> The "Bad page state" messages may (should) remain, but the crashes should 
> be gone and the machine should hopefully continue functioning fine. And, 
> perhaps more importantly, you should hopefully have a _new_ message about 
> incomplete pfn mappings that should help pinpoint which driver causes 
> this..

Will do, I plan to take this machine down Saturday to run memtest86 for
a while (just to be sure - 2/3 of the RAM is new, but I should be seeing
machine checks if that were the problem, no?) so I'll boot this after that.

Thanks,
-ryan
