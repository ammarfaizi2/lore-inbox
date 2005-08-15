Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965031AbVHOXfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965031AbVHOXfc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 19:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbVHOXfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 19:35:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:54947 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965031AbVHOXfb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 19:35:31 -0400
Date: Tue, 16 Aug 2005 01:35:30 +0200
From: Andi Kleen <ak@suse.de>
To: David Lang <david.lang@digitalinsight.com>
Cc: Andi Kleen <ak@suse.de>, zach@vmware.com, akpm@osdl.org, chrisw@osdl.org,
       linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
Subject: Re: [PATCH 0/6] i386 virtualization patches, Set 3
Message-ID: <20050815233529.GG20749@wotan.suse.de>
References: <200508152258.j7FMw9p8005295@zach-dev.vmware.com> <20050815232400.GV27628@wotan.suse.de> <Pine.LNX.4.62.0508151626290.24315@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0508151626290.24315@qynat.qvtvafvgr.pbz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> you are forgetting about the embedded market, there 386 cpu (or things 
> that look like 386 cpu's) are still available.

They cannot use it much though because the code is obviously  in so 
bad shape. Perhaps they have all FPUs ? Ok given LDT usage 
is rare, but still there are probably lots of other bugs 
in that unmaintained code too.

-Andi
