Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964872AbWAQW5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbWAQW5X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 17:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWAQW5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 17:57:23 -0500
Received: from cantor2.suse.de ([195.135.220.15]:42917 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932492AbWAQW5W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 17:57:22 -0500
From: Neil Brown <neilb@suse.de>
To: Phillip Susi <psusi@cfl.rr.com>
Date: Wed, 18 Jan 2006 09:57:08 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17357.30276.327186.496018@cse.unsw.edu.au>
Cc: Michael Tokarev <mjt@tls.msk.ru>, sander@humilis.net,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [PATCH 000 of 5] md: Introduction
In-Reply-To: message from Phillip Susi on Tuesday January 17
References: <20060117174531.27739.patches@notabene>
	<43CCA80B.4020603@tls.msk.ru>
	<20060117095019.GA27262@localhost.localdomain>
	<43CCD453.9070900@tls.msk.ru>
	<43CD71FA.4090908@cfl.rr.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday January 17, psusi@cfl.rr.com wrote:
>                                                                  I was 
> also under the impression that md was going to be phased out and 
> replaced by the device mapper.

I wonder where this sort of idea comes from....

Obviously individual distributions are free to support or not support
whatever bits of code they like.  And developers are free to add
duplicate functionality to the kernel (I believe someone is working on
a raid5 target for dm).  But that doesn't mean that anything is going
to be 'phased out'.

md and dm, while similar, are quite different.  They can both
comfortably co-exist even if they have similar functionality.
What I expect will happen (in line with what normally happens in
Linux) is that both will continue to evolve as long as there is
interest and developer support.  They will quite possibly borrow ideas
from each other where that is relevant.  Parts of one may lose
support and eventually die (as md/multipath is on the way to doing)
but there is no wholesale 'phasing out' going to happen in either
direction. 

NeilBrown
