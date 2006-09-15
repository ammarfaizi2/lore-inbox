Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbWIOVtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbWIOVtZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 17:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbWIOVtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 17:49:25 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:8585 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932302AbWIOVtY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 17:49:24 -0400
Message-ID: <450B1FDD.1050803@us.ibm.com>
Date: Fri, 15 Sep 2006 16:49:17 -0500
From: "Jose R. Santos" <jrs@us.ibm.com>
Reply-To: jrs@us.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de, karim@opersys.com,
       Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060915132052.GA7843@localhost.usen.ad.jp>	<Pine.LNX.4.64.0609151535030.6761@scrub.home>	<20060915135709.GB8723@localhost.usen.ad.jp>	<450AB5F9.8040501@opersys.com>	<450AB506.30802@sgi.com>	<450AB957.2050206@opersys.com>	<20060915142836.GA9288@localhost.usen.ad.jp>	<450ABE08.2060107@opersys.com>	<1158332447.5724.423.camel@localhost.localdomain>	<20060915111644.c857b2cf.akpm@osdl.org>	<20060915181907.GB17581@elte.hu> <20060915131317.aaadf568.akpm@osdl.org>
In-Reply-To: <20060915131317.aaadf568.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Fri, 15 Sep 2006 20:19:07 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
>
> > 
> > * Andrew Morton <akpm@osdl.org> wrote:
> > 
> > > What Karim is sharing with us here (yet again) is the real in-field 
> > > experience of real users (ie: not kernel developers).
> > 
> > well, Jes has that experience and Thomas too.
>
> systemtap and ltt are the only full-scale tracing tools which target
> sysadmins and applciation developers of which I am aware..
>   

IMO, I think SystemTap is to generic of a tool to be considered a 
tracing tool.  LKET and LKST are more comparable with the functionality 
that LTT provides.  LKET is implemented using SystemTap while LKST has 
both a SystemTap and static kernel patch implementation.


> In the bit of text which you snipped I was agreeing with this...
>
> Look, if Karim and Frank (who I assume is a systemtap developer) think that
> we need static tracepoints then I have no reason to disagree with them. 
> What I would propose is that:
>
> a) Those tracepoints be integrated one at a time on well-understood
>    grounds of necessity.  Tracepoints _should_ be added dynamically.  But
>    if there are instances where that's not working and cannot be made to
>    work then OK, in we go.
>   
Agree.  What would be the criteria that justifies having static probe vs 
a dynamic one?

-JRS

