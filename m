Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965065AbVIAHdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965065AbVIAHdk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 03:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965075AbVIAHdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 03:33:40 -0400
Received: from math.ut.ee ([193.40.36.2]:54967 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S965065AbVIAHdj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 03:33:39 -0400
Date: Thu, 1 Sep 2005 10:33:12 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Nigel Cunningham <ncunningham@cyclades.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Eric W.Biederman" <ebiederm@xmission.com>,
       Len Brown <len.brown@intel.com>
Subject: Re: reboot vs poweroff (was: Linux 2.6.13)
In-Reply-To: <1125557333.12996.76.camel@localhost>
Message-ID: <Pine.SOC.4.61.0509011030430.3232@math.ut.ee>
References: <20050901062406.EBA5613D5B@rhn.tartu-labor> <1125557333.12996.76.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've since found that in the suspend2 code, I was working around this
> problem before by not calling the prepare method. I've just today
> modified the Suspend code so that it calls prepare for all of the
> powerdown methods and everything is working fine without reverting the
> patch. I guess this is your better fix if you're a suspend2 user. If
> not, are there other circumstances in which you're seeing the computer
> fail to powerdown?

It's OK then - I'm not using any suspend and I had a problem that my 
machine powered down instead of reboot. The patch that went into 2.6.13 
after rc7 fixed it for me. So the current tree is OK for me and if it's 
OK for you too after suspend2 changes then this case can probably be 
closed.

-- 
Meelis Roos (mroos@linux.ee)
