Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751780AbWCNBWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbWCNBWT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 20:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751955AbWCNBWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 20:22:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:29931 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751780AbWCNBWS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 20:22:18 -0500
From: Neil Brown <neilb@suse.de>
To: Lee Revell <rlrevell@joe-job.com>
Date: Tue, 14 Mar 2006 12:20:56 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17430.6776.641993.684122@cse.unsw.edu.au>
Cc: Joshua Kugler <joshua.kugler@uaf.edu>, linux-kernel@vger.kernel.org,
       sah@coraid.com
Subject: Re: OOM kiler/load problems with RAID/LVM and AoE
In-Reply-To: message from Lee Revell on Monday March 13
References: <200603131602.03886.joshua.kugler@uaf.edu>
	<1142298998.13256.76.camel@mindpipe>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday March 13, rlrevell@joe-job.com wrote:
> On Mon, 2006-03-13 at 16:02 -0900, Joshua Kugler wrote:
> > Kernel: Linux community.dist-ed.uaf.edu 2.6.12-14mdksmp #1 SMP Tue Dec
> > 20 
> 
> You'll have to try the latest kernel, 2.6.15.x or the latest 2.6.16
> release candidate.
> 

... and you'll probably find the 2G limit on raid1s have been removed
(certainly in the 2.6.16, not sure about 2.6.15). You'll need mdadm
2.3.

NeilBrown
