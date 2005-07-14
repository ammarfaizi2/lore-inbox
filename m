Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261728AbVGNVVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbVGNVVm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 17:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263059AbVGNVVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 17:21:42 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:12992 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261728AbVGNVVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 17:21:40 -0400
Date: Thu, 14 Jul 2005 23:04:30 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Doug Warzecha <Douglas_Warzecha@dell.com>
Cc: Chris Wedgwood <cw@f00f.org>, rdunlap@xenotime.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: Add Dell Systems Management Base driver
Message-ID: <20050714210429.GA659@openzaurus.ucw.cz>
References: <20050706001333.GA3569@sysman-doug.us.dell.com> <20050706005320.GA23709@taniwha.stupidest.org> <20050712231729.GA15062@sysman-doug.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050712231729.GA15062@sysman-doug.us.dell.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Please use enter key every 70 chars or so...

> >    > This patch adds the Dell Systems Management Base driver.
> > 
> >    You keep posting this driver without explaining/showing how it's used.
> >    Could you perhaps give some more details here please?
> 
> Here's some more information on the driver and the systems that it supports.  Because the hardware interfaces on those systems and the Dell systems management software that access the interfaces are proprietary, I can't provide specifications for the interfaces or source code for the software.
> 

So... instead of providing nice & standard interface, you invent very ugly interface
that allows your usermode app to band on SMI directly -- because you don't want
to tell us how to drive SMI.

No, sorry. Provide something with standard interface (like lm_sensors use). You'll have to
tell us how to control the hardware. Its temperature sensor; I don't see how that is worh calling
"proprietary"...
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

