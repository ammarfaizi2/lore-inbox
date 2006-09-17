Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964896AbWIQBP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964896AbWIQBP4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 21:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964898AbWIQBP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 21:15:56 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:13492 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964896AbWIQBP4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 21:15:56 -0400
Date: Sun, 17 Sep 2006 03:15:17 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Thomas Gleixner <tglx@linutronix.de>, karim@opersys.com,
       Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
In-Reply-To: <20060916230031.GB20180@elte.hu>
Message-ID: <Pine.LNX.4.64.0609170310580.6761@scrub.home>
References: <1158351780.5724.507.camel@localhost.localdomain>
 <Pine.LNX.4.64.0609152236010.6761@scrub.home> <20060915204812.GA6909@elte.hu>
 <Pine.LNX.4.64.0609152314250.6761@scrub.home> <20060915215112.GB12789@elte.hu>
 <Pine.LNX.4.64.0609160018110.6761@scrub.home> <20060915231419.GA24731@elte.hu>
 <Pine.LNX.4.64.0609160139130.6761@scrub.home> <20060916082214.GD6317@elte.hu>
 <Pine.LNX.4.64.0609161831270.6761@scrub.home> <20060916230031.GB20180@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 17 Sep 2006, Ingo Molnar wrote:

> Lets see the equation of the current situation. On one side you want 
> static tracing but you dont want to implement kprobes on m68k - although 
> you probably could.

You would have a point if would it be just about m68k.

> On the other side there is the main kernel, which, 
> if it ever accepted static tracepoints, could probably never get rid of 
> them.

If they are useful and not hurting anyone, why should we?

bye, Roman
