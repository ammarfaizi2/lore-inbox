Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261747AbUKUSSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbUKUSSo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 13:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbUKUSRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 13:17:46 -0500
Received: from postfix4-1.free.fr ([213.228.0.62]:47241 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S261747AbUKUSQV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 13:16:21 -0500
Message-ID: <41A0DB78.2010807@free.fr>
Date: Sun, 21 Nov 2004 19:16:24 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>, Adam Belay <ambx1@neo.rr.com>,
       "Li, Shaohua" <shaohua.li@intel.com>
Subject: Re: [PATCH] smsc-ircc2: Add PnP support.
References: <E1CVAfT-0002n9-Rn@rhn.tartu-labor> <419E16E5.1000601@free.fr> <419E17FF.1000503@free.fr> <Pine.SOC.4.61.0411191822030.9059@math.ut.ee> <419E2D2B.4020804@free.fr> <Pine.SOC.4.61.0411191934070.29328@math.ut.ee> <419E3B7A.4000904@free.fr> <Pine.SOC.4.61.0411200102580.12992@math.ut.ee> <419F136B.8010308@free.fr> <Pine.SOC.4.61.0411211949260.23880@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0411211949260.23880@math.ut.ee>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Meelis Roos wrote:
>> Ok, I have catch the problem : the pnpacpi parser supposed that are no 
>> resource after EndDependentFn.
>>
>> Could you try this patch with pnpacpi?
> 
> 
> Yes, it gives full options (and resources after "auto"). But smsc-ircc2 
> still does not load even after "activate" with pnpacpi. It loads with 
> pnpbios after auto and activate.
> 
thanks

Could I have the log from smsc-ircc2 when it failed with pnpacpi ?

regards

Matthieu
