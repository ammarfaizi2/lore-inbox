Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269671AbUJGVZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269671AbUJGVZv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 17:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267904AbUJGVVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 17:21:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:16621 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269775AbUJGVUV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 17:20:21 -0400
Date: Thu, 7 Oct 2004 14:20:19 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: kswapd in tight loop 2.6.9-rc3-bk-recent
Message-ID: <20041007142019.D2441@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is this known?  Just came back from lunch, so I've no clue what kicked it
off.  Profile below. (2.6.9-rc3-bk from yesterday, pending updates don't
appear to touch vmscan or mm/ in general).

CPU: AMD64 processors, speed 1994.35 MHz (estimated)
Counted CPU_CLK_UNHALTED events (Cycles outside of halt state) with a
unit mask
of 0x00 (No unit mask) count 100000
samples  %        symbol name
2410135  53.4092  balance_pgdat
1328186  29.4329  shrink_zone
555121   12.3016  shrink_slab
84942     1.8823  __read_page_state
40770     0.9035  timer_interrupt
...

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
