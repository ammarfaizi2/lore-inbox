Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbVJQJl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbVJQJl5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 05:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbVJQJl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 05:41:56 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:57034 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932233AbVJQJlx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 05:41:53 -0400
Date: Mon, 17 Oct 2005 11:41:53 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, George Anzinger <george@mvista.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       johnstul@us.ibm.com, paulmck@us.ibm.com,
       Christoph Hellwig <hch@infradead.org>, oleg@tv-sign.ru,
       tim.bird@am.sony.com
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
Message-ID: <20051017094153.GA9091@elte.hu>
References: <1128168344.15115.496.camel@tglx.tec.linutronix.de> <Pine.LNX.4.61.0510100213480.3728@scrub.home> <1129016558.1728.285.camel@tglx.tec.linutronix.de> <Pine.LNX.4.61.0510130004330.3728@scrub.home> <434DA06C.7050801@mvista.com> <Pine.LNX.4.61.0510150143500.1386@scrub.home> <1129490809.1728.874.camel@tglx.tec.linutronix.de> <Pine.LNX.4.61.0510170021050.1386@scrub.home> <20051017075917.GA4827@elte.hu> <Pine.LNX.4.61.0510171054430.1386@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0510171054430.1386@scrub.home>
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


* Roman Zippel <zippel@linux-m68k.org> wrote:

> > the moment you express yourself via patches we'll know that 1) you 
> > understand what we have done so far 2) you have useful ideas of what 
> > should be done differently 3) you have the coder capability to implement 
> > and test those ideas. Patches wont be ignored, i can assure you. Get the 
> > patches rolling!
> 
> This "shut up and show code" attitude is sometimes quite funny, but 
> it's no real threat to me. I hoped to avoid this and solve this more 
> civilized. Of course I'll understand the issues better afterwards, but 
> you could as easily just tell me. [...]

if a dozen mails werent enough then one more probably wont make a 
difference, especially with your last mail calling Thomas's behavior 
"childish" - when all he did was to try to explain his reasons to you as 
patiently as possible! Thomas is not obliged to teach you or bear with 
you - it is his own free choice. (But if you want to discuss this 
personal angle any further please take the public lists (and other 
people) off the Cc: list, it's getting very off-topic.)

Thomas's stuff is now fully integrated into the -rt tree and it works 
excellently. I have measured a 12 usecs worst-case HR timer-delivery 
latency (using cyclictest). _That_ is the thing i care about.

> [...] It will waste my time, I could spend on other projects and it 
> will put Andrew in the unfortunate position to decide, which patch to 
> accept. [...]

yes, please, put Andrew (and me too) into that unfortunate position!  
Please, pretty please, get on with the patches!

	Ingo
