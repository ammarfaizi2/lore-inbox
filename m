Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279603AbRKSATD>; Sun, 18 Nov 2001 19:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281541AbRKSASx>; Sun, 18 Nov 2001 19:18:53 -0500
Received: from w089.z209220022.nyc-ny.dsl.cnc.net ([209.220.22.89]:46864 "HELO
	yucs.org") by vger.kernel.org with SMTP id <S279603AbRKSASr>;
	Sun, 18 Nov 2001 19:18:47 -0500
Subject: replacing the page replacement algo.
From: Shaya Potter <spotter@cs.columbia.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1 (Preview Release)
Date: 18 Nov 2001 19:17:11 -0500
Message-Id: <1006129088.605.2.camel@zaphod>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I wanted to experiment with different algorithms that chose which
page to replace (say on a page fault) what functions would I have to
replace?  or in other words, is there any good place that explains the
code path of how pages are chosen to be swapped out.  For example, by
scheduling, its easy to replace the scheduler because all you need to
deal with is schedule() and possibly add_to/del_from runqueue, with
schedule() being the important function, is there an equivalent function
in 2.4 for choosing pages to swap out?

thanks,

shaya potter

-- 
spotter@{cs.columbia.edu,yucs.org}

