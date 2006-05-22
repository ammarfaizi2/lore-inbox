Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbWEVWmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWEVWmq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 18:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWEVWmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 18:42:45 -0400
Received: from ns.suse.de ([195.135.220.2]:38274 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751283AbWEVWmp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 18:42:45 -0400
From: Neil Brown <neilb@suse.de>
To: "Rainer Shiz" <rainer.shiz@gmail.com>
Date: Tue, 23 May 2006 08:42:14 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17522.15942.232530.954548@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RAID Sync Speeds
In-Reply-To: message from Rainer Shiz on Monday May 22
References: <cf5433040605220605t22b6030j701add7d494c83e8@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday May 22, rainer.shiz@gmail.com wrote:
> 
> So Is the 2.6 kernel designed to sync at speeds closer to min than max?
> 

If there is other detectable activity, the sync speed will be kept at
or below the min.
If there no other activity, the sync speed will be kept at or below
the max.

NeilBrown
