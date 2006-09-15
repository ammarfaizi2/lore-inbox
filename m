Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWIOPBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWIOPBf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 11:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbWIOPBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 11:01:34 -0400
Received: from [81.2.110.250] ([81.2.110.250]:46983 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932074AbWIOPBe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 11:01:34 -0400
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: karim@opersys.com
Cc: Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
       Roman Zippel <zippel@linux-m68k.org>, Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
In-Reply-To: <450ABE08.2060107@opersys.com>
References: <20060914181557.GA22469@elte.hu> <4509A54C.1050905@opersys.com>
	 <yq08xkleb9h.fsf@jaguar.mkp.net> <450A9EC9.9080307@opersys.com>
	 <20060915132052.GA7843@localhost.usen.ad.jp>
	 <Pine.LNX.4.64.0609151535030.6761@scrub.home>
	 <20060915135709.GB8723@localhost.usen.ad.jp> <450AB5F9.8040501@opersys.com>
	 <450AB506.30802@sgi.com> <450AB957.2050206@opersys.com>
	 <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 15 Sep 2006 16:24:23 +0100
Message-Id: <1158333863.29932.91.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-09-15 am 10:51 -0400, ysgrifennodd Karim Yaghmour:
> The static tracepoints we maintained were *the* solution for a great

I think you mean "a" solution. You've not proved there are no others.

> deal many people. As a maintainer I had two choices with those who
> were not content:
> a- Maintain their tracepoints for them -- not happening.
> b- Suggest they contribute to helping getting a generic tracing
>   infrastructure into the kernel and then make their case on the
>   lkml as to the pertinence of their instrumentation.

b has been done, its called kprobes. We just need better tools for the
dynamic probes.

> choice of tracepoints. Those who were using ltt for its designated
> purpose -- allowing normal users and developers to get an accurate
> view of the behavior of their system -- were very happy with it.

and you can maintain "Karim's probe list" which is the dynamic probe set
which matches your old static probes, only of course its now much more
flexible.

