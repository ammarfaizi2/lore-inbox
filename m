Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbUHMLbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbUHMLbo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 07:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbUHMLbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 07:31:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:36540 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262106AbUHMLa6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 07:30:58 -0400
X-Authenticated: #4399952
Date: Fri, 13 Aug 2004 13:41:01 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc4-O7
Message-Id: <20040813134101.06568416@mango.fruits.de>
In-Reply-To: <20040813104817.GI8135@elte.hu>
References: <20040726083537.GA24948@elte.hu>
	<1090832436.6936.105.camel@mindpipe>
	<20040726124059.GA14005@elte.hu>
	<20040726204720.GA26561@elte.hu>
	<20040729222657.GA10449@elte.hu>
	<20040801193043.GA20277@elte.hu>
	<20040809104649.GA13299@elte.hu>
	<20040810132654.GA28915@elte.hu>
	<20040812235116.GA27838@elte.hu>
	<1092382825.3450.19.camel@mindpipe>
	<20040813104817.GI8135@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Aug 2004 12:48:17 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> in -O7 i've added a runtime flag to disable/enable tracing without
> having to recompile the kernel:
> 
>  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc4-O7

I have one question: Are kernel frame pointers required for the latency
traces? I had frame pointers on in my kernel config but wonder if they
are nessecary or if i can save the cycles and kb [i'm not too big on
kernel internals, so forgive the possibly stupid question]?..

The other thing i wanted to say is: way to go man!! These patches rock
my linux audio world. A big thank you from me and [probably] the whole
linux audio community for the work you put into this!

Compiling O7 right now with traces enabled, so i'll send a trace soon
about the ca 300 us latencies i see.

Flo

-- 
Palimm Palimm!
http://affenbande.org/~tapas/

