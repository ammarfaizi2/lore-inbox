Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965085AbWHYFlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965085AbWHYFlY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 01:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965184AbWHYFlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 01:41:24 -0400
Received: from mx1.suse.de ([195.135.220.2]:62926 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965085AbWHYFlX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 01:41:23 -0400
From: Neil Brown <neilb@suse.de>
To: Andrzej Szymanski <szymans@agh.edu.pl>,
       Miquel van Smoorenburg <miquels@cistron.nl>,
       linux-kernel@vger.kernel.org
Date: Fri, 25 Aug 2006 15:41:15 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17646.36219.417129.477853@cse.unsw.edu.au>
Subject: Re: Strange write starvation on 2.6.17 (and other) kernels
In-Reply-To: message from Neil Brown on Tuesday August 22
References: <44E0A69C.5030103@agh.edu.pl>
	<ec19r7$uba$1@news.cistron.nl>
	<17641.3304.948174.971955@cse.unsw.edu.au>
	<44E9A9C0.6000405@agh.edu.pl>
	<17642.46325.818963.951269@cse.unsw.edu.au>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday August 22, neilb@suse.de wrote:
> 
> In my various experimenting the one thing that was effective in
> improving the fairness was to make Linux impose write throttling more
> often.

I might have found something else too....

Were you using ext3?

If you, can you try mounting with  data=writeback
and see if that makes any difference to the fairness?

Thanks,
NeilBrown
