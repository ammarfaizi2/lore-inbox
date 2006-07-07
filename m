Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbWGGWiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWGGWiM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 18:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWGGWiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 18:38:11 -0400
Received: from ns1.suse.de ([195.135.220.2]:59019 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932364AbWGGWiK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 18:38:10 -0400
From: Neil Brown <neilb@suse.de>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Date: Sat, 8 Jul 2006 08:38:03 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17582.57931.816012.142421@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: Kernel 2.6.17 and RAID5 Grow Problem (critical section backup)
In-Reply-To: message from Justin Piszcz on Friday July 7
References: <Pine.LNX.4.64.0607070830450.2648@p34.internal.lan>
	<Pine.LNX.4.64.0607070845280.2648@p34.internal.lan>
	<Pine.LNX.4.64.0607070849140.3010@p34.internal.lan>
	<Pine.LNX.4.64.0607071037190.5153@p34.internal.lan>
	<17582.55703.209583.446356@cse.unsw.edu.au>
	<Pine.LNX.4.64.0607071814510.8499@p34.internal.lan>
	<17582.57549.204471.855655@cse.unsw.edu.au>
	<Pine.LNX.4.64.0607071832200.8499@p34.internal.lan>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday July 7, jpiszcz@lucidpixels.com wrote:
> 
> I guess one has to wait until the reshape is complete before growing the 
> filesystem..?

Yes.  The extra space isn't available until the reshape has completed
(if it was available earlier, the reshape wouldn't be necessary....)

NeilBrown
