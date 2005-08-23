Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030229AbVHZTmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbVHZTmD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 15:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030230AbVHZTmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 15:42:02 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:37760 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1030229AbVHZTmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 15:42:00 -0400
Date: Tue, 23 Aug 2005 16:57:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH] fix whitespace handling on sysfs attributes
Message-ID: <20050823145752.GA846@openzaurus.ucw.cz>
References: <9e473391050823064469eb78a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e473391050823064469eb78a2@mail.gmail.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The first version of this patch didn't allow for the request firmware
> case which does multiple parsing passes on the parameter. This was
> discussed in the thread '2.6.13-rc6-mm1'

I still thing this is very wrong to do. sysfs should not try to outguess users.



-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

