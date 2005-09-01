Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965092AbVIAMdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965092AbVIAMdL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 08:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965093AbVIAMdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 08:33:11 -0400
Received: from [85.8.12.41] ([85.8.12.41]:36505 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S965092AbVIAMdK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 08:33:10 -0400
Message-ID: <4316F4E3.4030302@drzeus.cx>
Date: Thu, 01 Sep 2005 14:32:35 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Meelis Roos <mroos@linux.ee>
CC: Nigel Cunningham <ncunningham@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Eric W.Biederman" <ebiederm@xmission.com>,
       Len Brown <len.brown@intel.com>
Subject: Re: reboot vs poweroff (was: Linux 2.6.13)
References: <20050901062406.EBA5613D5B@rhn.tartu-labor> <1125557333.12996.76.camel@localhost> <Pine.SOC.4.61.0509011030430.3232@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0509011030430.3232@math.ut.ee>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Meelis Roos wrote:
> 
> It's OK then - I'm not using any suspend and I had a problem that my
> machine powered down instead of reboot. The patch that went into 2.6.13
> after rc7 fixed it for me. So the current tree is OK for me and if it's
> OK for you too after suspend2 changes then this case can probably be
> closed.
> 

I'm still having problems with this patch. Both swsusp and swsusp2 are
affected. Perhaps the fix Nigel did needs to be done to swsusp aswell?

Bugzilla entry:

http://bugme.osdl.org/show_bug.cgi?id=4320

Rgds
Pierre
