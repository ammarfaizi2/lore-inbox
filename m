Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964936AbWIQPkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbWIQPkB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 11:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964943AbWIQPkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 11:40:01 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:46496 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964936AbWIQPkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 11:40:00 -0400
Date: Sun, 17 Sep 2006 17:31:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Frank Ch. Eigler" <fche@redhat.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, Thomas Gleixner <tglx@linutronix.de>,
       karim@opersys.com, Andrew Morton <akpm@osdl.org>,
       Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060917153156.GA26209@elte.hu>
References: <20060915204812.GA6909@elte.hu> <Pine.LNX.4.64.0609152314250.6761@scrub.home> <20060915215112.GB12789@elte.hu> <Pine.LNX.4.64.0609160018110.6761@scrub.home> <20060915231419.GA24731@elte.hu> <Pine.LNX.4.64.0609160139130.6761@scrub.home> <20060916082214.GD6317@elte.hu> <Pine.LNX.4.64.0609161831270.6761@scrub.home> <20060916231407.GA23132@elte.hu> <y0mr6yaefts.fsf@ton.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <y0mr6yaefts.fsf@ton.toronto.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4966]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Frank Ch. Eigler <fche@redhat.com> wrote:

> As for Karim's proposed comment-based markers, I don't have a strong 
> opinion, not being one whose kernel-side code would be marked up one 
> way or the other. [...]

What makes the difference isnt just the format of markup (although i 
fully agree that the least visually intrusive markup format should be 
used for static markers, and the range of possibilities includes 
comment-based markers too), but what makes the differen is:

 the /guarantee/ of a full (comprehensive) set to /static tracers/

The moment we allow a static tracer into the upstream kernel, we make 
that guarantee, implicitly and explicitly. (I've expanded on this line 
of argument in the previous few mails, extensively.)

	Ingo
