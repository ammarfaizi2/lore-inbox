Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261749AbUKUSNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbUKUSNk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 13:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbUKUSNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 13:13:39 -0500
Received: from math.ut.ee ([193.40.5.125]:16576 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261770AbUKUSNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 13:13:34 -0500
Date: Sun, 21 Nov 2004 19:50:46 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: matthieu castet <castet.matthieu@free.fr>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>, Adam Belay <ambx1@neo.rr.com>,
       "Li, Shaohua" <shaohua.li@intel.com>
Subject: Re: [PATCH] smsc-ircc2: Add PnP support.
In-Reply-To: <419F136B.8010308@free.fr>
Message-ID: <Pine.SOC.4.61.0411211949260.23880@math.ut.ee>
References: <E1CVAfT-0002n9-Rn@rhn.tartu-labor> <419E16E5.1000601@free.fr>
 <419E17FF.1000503@free.fr> <Pine.SOC.4.61.0411191822030.9059@math.ut.ee>
 <419E2D2B.4020804@free.fr> <Pine.SOC.4.61.0411191934070.29328@math.ut.ee>
 <419E3B7A.4000904@free.fr> <Pine.SOC.4.61.0411200102580.12992@math.ut.ee>
 <419F136B.8010308@free.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok, I have catch the problem : the pnpacpi parser supposed that are no 
> resource after EndDependentFn.
>
> Could you try this patch with pnpacpi?

Yes, it gives full options (and resources after "auto"). But smsc-ircc2 
still does not load even after "activate" with pnpacpi. It loads with 
pnpbios after auto and activate.

-- 
Meelis Roos (mroos@linux.ee)
