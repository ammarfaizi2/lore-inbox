Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbWBMVLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbWBMVLV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 16:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbWBMVLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 16:11:21 -0500
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:20730 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S964873AbWBMVLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 16:11:20 -0500
X-Mailer: exmh version 2.7.0 04/02/2003 (gentoo 2.7.0) with nmh-1.1
To: Ryan Richter <ryan@tau.solarneutrino.net>
cc: linux-kernel@vger.kernel.org, anders@latitude.mynet.no-ip.org
Subject: Re: Random reboots 
In-reply-to: <20060213210435.GC16566@tau.solarneutrino.net> 
References: <20060213210435.GC16566@tau.solarneutrino.net>
Comments: In-reply-to Ryan Richter <ryan@tau.solarneutrino.net>
   message dated "Mon, 13 Feb 2006 16:04:35 -0500."
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 13 Feb 2006 22:10:43 +0100
From: anders@latitude.mynet.no-ip.org
Message-Id: <20060213211044.066CE5E401E@latitude.mynet.no-ip.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ryan@tau.solarneutrino.net said:
> Ever since upgrading our file server from 2.6.11.3 to 2.6.14+, it has been
> experiencing random reboots about every 2-3 weeks.  I'm pretty certain it's a
> kernel issue: it shares a UPS with a few other machines, so it's not the
> power.  We had uptimes of ~6 months with 2.6.11.3, and I've run memtest86
> overnight since adding some memory a few months ago, so I don't suspect
> hardware trouble.  We've had 5 of these reboots now, so it's a repeatable
> problem, albeit on an agonizing timescale for testing. 

Any chance you're running spamassassin on that box? I've seen similar issues 
lately and, comparing /var/log/messages with crontab, have concluded that 
sa-learn sometimes kills the box when run by cron. It seems so odd that I 
haven't found the guts to ask about it figuring that I should do some more 
test myself, but I don't have much else to go on...

/Anders

