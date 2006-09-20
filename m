Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751541AbWITOSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbWITOSN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 10:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751545AbWITOSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 10:18:13 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:38058 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751541AbWITOSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 10:18:12 -0400
Message-ID: <45114D5F.7090105@sgi.com>
Date: Wed, 20 Sep 2006 16:17:03 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: Martin Bligh <mbligh@mbligh.org>
Cc: karim@opersys.com, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de,
       Paul Mundt <lethal@linux-sh.org>, Roman Zippel <zippel@linux-m68k.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060915132052.GA7843@localhost.usen.ad.jp>	<Pine.LNX.4.64.0609151535030.6761@scrub.home>	<20060915135709.GB8723@localhost.usen.ad.jp>	<450AB5F9.8040501@opersys.com>	<450AB506.30802@sgi.com>	<450AB957.2050206@opersys.com>	<20060915142836.GA9288@localhost.usen.ad.jp>	<450ABE08.2060107@opersys.com>	<1158332447.5724.423.camel@localhost.localdomain>	<20060915111644.c857b2cf.akpm@osdl.org>	<20060915181907.GB17581@elte.hu> <20060915131317.aaadf568.akpm@osdl.org> <450BCF97.3000901@sgi.com> <450C20C7.30604@opersys.com> <450E5540.4080205@sgi.com> <450ED213.9000603@mbligh.org>
In-Reply-To: <450ED213.9000603@mbligh.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bligh wrote:
>> Everything has performance limitations, you keep running around touting
>> that static is the only thing thats not a problem. Now show us the
>> numbers!
> 
> When comparing two different approaches to a problem, it is unreasonable
> and disingenuous to try to force the onus on the proponents of one
> particular approach to do all the benchmarking for both sides. Everybody
> has to help try to find the correct solution.

Martin,

If you have one side of a discussion stating that the other side's
suggestion is useless for performance reasons, then it is IMHO totally
fair for the second side to ask the first side to back up their
statement with facts. If one wants to get a patch into the kernel,
you also get asked for justication, and if you want to get it into
a vendor kernel, a benchmark proving your patch is not causing any
damage is pretty much standard. Fortunately Mathieu also showed that he
was willing to try and do that.

> This is getting very silly, and unnecessarily abusive. Real problems
> exist on both sides of the fence, which have been discussed ad nauseam.
> If you don't recall them, then go back and read the thread again. The
> question is how to strike a comprimise between two different set of
> problems, which Ingo and Karim actually seemed to be making progress
> on towards the end of the thread.

This got very silly and abuse pretty much from the beginning, at the
very point anyone tried to challenge the justification that was
initially presented with the LTT patches. This isn't how Linux works,
if you want to post a patch, you should be ready to accept public
scrutiny of your design and your actual code. Just because something is
your personal pet project doesn't mean it nobody has the right to
challenge it.

Even after Christoph tried to be the neutral middle-man, we had to see
another three follow-ups of 'I must have the last word' postings :(

As I said in my last posting related to this thread, I had had enough,
I haven't even read all the responses to my posting and I doubt I will.
Instead I went back and starting writing code (unrelated and really
evil code, but in a very different way, and trust me it's making me
very grumpy :)

Fortunately, we at least now have a situation where Mathieu has shown he
is interested in being constructive on the issue and is able to work
with Ingo on the static markers, which I'd like to applaud.

I am optimistic a useful solution will come out of it finally, but I
will rather stay out of it at this point.

Jes
