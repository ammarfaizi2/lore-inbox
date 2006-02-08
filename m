Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422892AbWBIRGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422892AbWBIRGb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 12:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965234AbWBIRGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 12:06:31 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:41227 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1422892AbWBIRGa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 12:06:30 -0500
Date: Wed, 8 Feb 2006 21:58:03 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Phillip Susi <psusi@cfl.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: FYI: RAID5 unusably unstable through 2.6.14
Message-ID: <20060208215802.GE2353@ucw.cz>
References: <E1EywcM-0004Oz-IE@laurel.muq.org> <B34375EBA93D2866BECF5995@d216-220-25-20.dynip.modwest.com> <43CD8A19.3010100@cfl.rr.com> <43E2834F.8040009@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E2834F.8040009@tmr.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >If 1 disk has a 1/1000 chance of failure, then
> >2 disks have a (1/1000)^2 chance of double failure, and
> >3 disks have a (1/1000)^2 * 3 chance of double failure
> >4 disks have a (1/1000)^2 * 7 chance of double failure
> 
> After the first drive fails you have no redundancy, the 
> chance of an additional failure is linear to the number 
> of remaining drives.
> 
> Assume:
>   p - probability of a drive failing in unit time
>   n - number of drives
>   F - probability of double failure
> 
> The chance of a single drive failure is n*p. After that 

<pedantic>
Actually it is not. Imagine 100 drives with 10% failure rate each. You
can't have probability of 1000%...
</> 

							Pavel
-- 
Thanks, Sharp!
