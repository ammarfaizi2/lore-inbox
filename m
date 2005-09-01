Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbVIAMth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbVIAMth (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 08:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbVIAMth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 08:49:37 -0400
Received: from [203.171.93.254] ([203.171.93.254]:39905 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S1750744AbVIAMth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 08:49:37 -0400
Subject: Re: reboot vs poweroff (was: Linux 2.6.13)
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pierre Ossman <drzeus-list@drzeus.cx>, Pavel Machek <pavel@ucw.cz>
Cc: Meelis Roos <mroos@linux.ee>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Eric W.Biederman" <ebiederm@xmission.com>,
       Len Brown <len.brown@intel.com>
In-Reply-To: <4316F4E3.4030302@drzeus.cx>
References: <20050901062406.EBA5613D5B@rhn.tartu-labor>
	 <1125557333.12996.76.camel@localhost>
	 <Pine.SOC.4.61.0509011030430.3232@math.ut.ee>  <4316F4E3.4030302@drzeus.cx>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1125578897.4785.23.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 01 Sep 2005 22:48:17 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-01 at 22:32, Pierre Ossman wrote:
> Meelis Roos wrote:
> > 
> > It's OK then - I'm not using any suspend and I had a problem that my
> > machine powered down instead of reboot. The patch that went into 2.6.13
> > after rc7 fixed it for me. So the current tree is OK for me and if it's
> > OK for you too after suspend2 changes then this case can probably be
> > closed.
> > 
> 
> I'm still having problems with this patch. Both swsusp and swsusp2 are
> affected. Perhaps the fix Nigel did needs to be done to swsusp aswell?

Yes, it does need modifying. I'll leave it to Pavel to do that though as
he's more familiar with the intricacies of that code than I am.

Regards,

Nigel

> Bugzilla entry:
> 
> http://bugme.osdl.org/show_bug.cgi?id=4320
> 
> Rgds
> Pierre
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.

