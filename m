Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbWIPCai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbWIPCai (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 22:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbWIPCai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 22:30:38 -0400
Received: from opersys.com ([64.40.108.71]:49678 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S932381AbWIPCah (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 22:30:37 -0400
Message-ID: <450B669E.4060401@opersys.com>
Date: Fri, 15 Sep 2006 22:51:10 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Jose R. Santos" <jrs@us.ibm.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       tglx@linutronix.de, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060915111644.c857b2cf.akpm@osdl.org> <20060915181907.GB17581@elte.hu> <Pine.LNX.4.64.0609152111030.6761@scrub.home> <20060915200559.GB30459@elte.hu> <20060915202233.GA23318@Krystal> <450B164B.7090404@us.ibm.com> <20060915220345.GC12789@elte.hu> <450B29FB.7000301@opersys.com> <20060915224338.GA22126@elte.hu> <450B382C.9070202@opersys.com> <20060915235317.GA29929@elte.hu>
In-Reply-To: <20060915235317.GA29929@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
>  nor do i reject all of LTT: as i said before i like the tools, and i
>  think its collection of trace events should be turned into systemtap
>  markups and scripts. Furthermore, it's ringbuffer implementation looks
>  better. So as far as the user is concerned, LTT could (and should) live
>  on with full capabilities, but with this crutial difference in how it
>  interfaces to the kernel source code.

The interface to the kernel source code can be worked on. I hope my
other email has demonstrated that.

> i.e. could you try to just give SystemTap a chance and attempt to 
> integrate a portion of LTT with it ... that shares more of the 
> infrastructure and we'd obviously only need "one" markup variant, and 
> would have full markup (removal-) flexibility. I'll try to help djprobes 
> as much as possible. Hm?

Preface: I have absolutely nothing against SystemTap. I did have a
bone with the way it was developed (behind closed-doors practically),
but I told the SystemTap people about this and end of story, we
moved on and I've had many enjoyable discussions with the SystemTap
team since. I just have a feeling that part of the team is proceeding
as if ltt was dead and buried. They'd like to interface with us --
at least I think -- but nobody dares to touch ltt with a 10foot
poll because it's a political hot-potato i.e. for all they care, ltt
could be a liability for SystemTap because of all the fuss about it
amongst kernel developers. But that's my take, I could be entirely
wrong.

Now, on a technical level, SystemTap cannot currently be a substitute
for what the ltt patch provides, especially in terms of performance.
Maybe one day it will be a substitute, with djprobe and other stuff,
but it isn't *now*. Nevertheless, I'm all for encouraging a movement
in a common direction. And in that regard I think that there is
consensus both amongst the SystemTap team and within the ltt team
-- at least I think, for having a common markers interface. This is
something we can definitely build on. Hopefully dispelling some of
the ltt fud and gathering some positive mantra for the ltt effort
on lkml can help ease people's fears about the possibility of
rubbing the kernel developers the wrong way.

Karim
-- 
President  / Opersys Inc.
Embedded Linux Training and Expertise
www.opersys.com  /  1.866.677.4546
