Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbVHQF6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbVHQF6l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 01:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbVHQF6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 01:58:41 -0400
Received: from mx2.elte.hu ([157.181.151.9]:19860 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750871AbVHQF6k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 01:58:40 -0400
Date: Wed, 17 Aug 2005 07:59:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-rt6
Message-ID: <20050817055922.GA4188@elte.hu>
References: <1124206316.5764.14.camel@localhost.localdomain> <1124207046.5764.17.camel@localhost.localdomain> <1124208507.5764.20.camel@localhost.localdomain> <20050816163202.GA5288@elte.hu> <20050816163730.GA7879@elte.hu> <20050816165247.GA10386@elte.hu> <20050816170805.GA12959@elte.hu> <1124214647.5764.40.camel@localhost.localdomain> <1124215631.5764.43.camel@localhost.localdomain> <1124218245.5764.52.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124218245.5764.52.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Since the change made raw_local_save_flags the same for both 
> PREEMPT_RT and !PREEMPT_RT, I moved it out of the #ifdef altogether.  
> The __raw_local_save_flags already does the type checking (at least 
> for intel).

ok, i've applied this one. Indeed it's pointless to trace the 
local_save_flags API.

	Ingo
