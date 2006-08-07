Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWHGP5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWHGP5R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 11:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWHGP5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 11:57:17 -0400
Received: from colin.muc.de ([193.149.48.1]:10246 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S932195AbWHGP5Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 11:57:16 -0400
Date: 7 Aug 2006 17:57:14 +0200
Date: Mon, 7 Aug 2006 17:57:14 +0200
From: Andi Kleen <ak@muc.de>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Dmitry Torokhov <dtor@insightbb.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Turn rdmsr, rdtsc into inline functions, clarify names
Message-ID: <20060807155714.GA3075@muc.de>
References: <1154771262.28257.38.camel@localhost.localdomain> <1154832963.29151.21.camel@localhost.localdomain> <20060806031643.GA43490@muc.de> <200608062243.45129.dtor@insightbb.com> <20060807084850.GA67713@muc.de> <20060807110931.GM27757@suse.cz> <20060807122845.GA85602@muc.de> <20060807124855.GB21003@suse.cz> <20060807125639.GA88155@muc.de> <20060807151957.GA9911@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060807151957.GA9911@rhlx01.fht-esslingen.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That way a driver could use
> 
> 	if (gtod_cpu_cycles_needed <= 500)
> 		gettimeofday();
> 	else
> 		funky_fast_workaround();

Sounds like overengineering to me. I prefer something simple.

> OK, in total we have at least four ways of doing this:

Please don't get carried away with this. I'm really not interested
in any complex solutions here.

-Andi

