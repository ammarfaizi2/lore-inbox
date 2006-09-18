Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965594AbWIRI6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965594AbWIRI6M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 04:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965598AbWIRI6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 04:58:12 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:33725 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965594AbWIRI6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 04:58:11 -0400
Message-ID: <450E5F6D.8070000@sgi.com>
Date: Mon, 18 Sep 2006 10:57:17 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: karim@opersys.com
Cc: Ingo Molnar <mingo@elte.hu>, Roman Zippel <zippel@linux-m68k.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu>	<Pine.LNX.4.64.0609141537120.6762@scrub.home>	<20060914135548.GA24393@elte.hu>	<Pine.LNX.4.64.0609141623570.6761@scrub.home>	<20060914171320.GB1105@elte.hu>	<Pine.LNX.4.64.0609141935080.6761@scrub.home>	<20060914181557.GA22469@elte.hu> <4509A54C.1050905@opersys.com> <yq08xkleb9h.fsf@jaguar.mkp.net> <450A9EC9.9080307@opersys.com> <450A9D4B.1030901@sgi.com> <450AB408.8020904@opersys.com> <450AB90C.9000403@sgi.com> <450AC2FA.70203@opersys.com> <450BD4C7.8030000@sgi.com> <450C1821.5010709@opersys.com>
In-Reply-To: <450C1821.5010709@opersys.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour wrote:
> It is for some. And please stop repeating the syscall path stuff. It can
> be solved elegantly. The fact that it hasn't up to this point is only an
> excuse to keep working harder on it. There is, in fact, no reason that
> the solution may not just be a combination of static markup and dynamic
> modification.

You just don't want to listen, this is *not* a question of a modifiable
table or not. It's a question of *how* code needs to be added to the
syscall path, we both know why a modifiable table is not going to
happen. How do you plan to handle vdso based syscalls with LTT?

>> In fact, the users who wish to trace data in self-compiled kernels are a
>> tiny subset of the potential userbase for this stuff which is primarily
>> useful to developers .... which in terms makes your argument about debug
>> tracepoints irrelevant since you are turning all the tracepoints into
>> debug tracepoints :)
> 
> How many embedded Linux projects did you personally work on?

You know what, I give up. Your primary interest seems to be in attacking
people personally because they didn't start out jumping up and down
clapping their hands in support of your pet project. Even if I wanted to
I couldn't tell you about the number of different projects I have
worked, partly because I can't remember half of them, partly because of
contract limitation, and most importantly because I do not need to
justify my experience to you.

Jes

