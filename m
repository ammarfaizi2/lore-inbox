Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbVKJJjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbVKJJjg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 04:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbVKJJjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 04:39:36 -0500
Received: from ns.suse.de ([195.135.220.2]:30123 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750730AbVKJJjg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 04:39:36 -0500
From: Neil Brown <neilb@suse.de>
To: Chris Boot <bootc@bootc.net>
Date: Thu, 10 Nov 2005 20:39:27 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17267.5455.299274.791144@cse.unsw.edu.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-mm1 RAID-1 in D< state
In-Reply-To: message from Chris Boot on Thursday November 10
References: <4371FA5B.6030900@bootc.net>
	<17266.30440.930561.902428@cse.unsw.edu.au>
	<3356B173-1C22-4C46-8CC4-1A08C303C63D@bootc.net>
	<17266.56637.123797.468396@cse.unsw.edu.au>
	<45372A5E-E75A-48F0-982B-A47DCA1B83D4@bootc.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday November 10, bootc@bootc.net wrote:
> 
> Sounds about right but...
> 
> drivers/md/md.c: In function `md_thread':
> drivers/md/md.c:3441: warning: implicit declaration of function  
> `wait_event_timeout_interruptible'

should be
  wait_event_interruptible_timeout

Sorry.
NeilBrown
