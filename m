Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbVLGKUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbVLGKUf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 05:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbVLGKUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 05:20:35 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:53981 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750776AbVLGKUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 05:20:34 -0500
Date: Wed, 7 Dec 2005 11:20:48 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: tglx@linutronix.de, zippel@linux-m68k.org, linux-kernel@vger.kernel.org,
       rostedt@goodmis.org, johnstul@us.ibm.com
Subject: Re: [patch 00/21] hrtimer - High-resolution timer subsystem
Message-ID: <20051207102048.GA26608@elte.hu>
References: <20051206000126.589223000@tglx.tec.linutronix.de> <Pine.LNX.4.61.0512061628050.1610@scrub.home> <1133908082.16302.93.camel@tglx.tec.linutronix.de> <20051207013122.3f514718.akpm@osdl.org> <20051207101137.GA25796@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051207101137.GA25796@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.6 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> once we take 'mass change of timer_list to ktimeout' out of the possible 
> things to do, we've only got these secondary possibilities:
> 
> 	'struct timer_list, struct ktimer'
> 	'struct timer_list, struct ptimer'
> 	'struct timer_list, struct hrtimer'
> 
> and having eliminated the first option due to being impractical to pull 
> off, [...]

(correction: due to being confusing.)

	Ingo
