Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276097AbRKHQlN>; Thu, 8 Nov 2001 11:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276132AbRKHQlE>; Thu, 8 Nov 2001 11:41:04 -0500
Received: from a59178.upc-a.chello.nl ([62.163.59.178]:25867 "EHLO
	www.unternet.org") by vger.kernel.org with ESMTP id <S276097AbRKHQky>;
	Thu, 8 Nov 2001 11:40:54 -0500
Date: Thu, 8 Nov 2001 17:39:19 +0100
From: Frank de Lange <lkml-frank@unternet.org>
To: linux-kernel@vger.kernel.org
Subject: hang with 2.4.14 & vmware 3.0.x, anyone else seen this?
Message-ID: <20011108173919.A9295@unternet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi'all...

 [ disclaimer: yeah, vmware, yeah tainted kernel, yeah yeah ]

It seems 2.4.14 and vmware 3.0.x don't like eachother very much on my SMP (yeah
Abit, yeah yeah I know) box. I've seen several hangs (nothing logged, no
warning, no nothing) using this combination. The same box, running the same
vmware but 2.4.13-ac instead does not complain...

Sooooo.... there seems to be something going on there. As vmware loads its own
kernel modules (licensed under who knows what? The source is available and
hackable), it could be a bug in those modules. Then again, as it does not occur
on the -ac series, it could be in the kernel as well. As there's nothing to be
seen in the logs (it just freezes solid), there's nothing more to report
currently...

Cheers//Frank

-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \ lkml-frank@unternet.org  /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
