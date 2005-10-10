Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbVJJV2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbVJJV2S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 17:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbVJJV2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 17:28:18 -0400
Received: from xproxy.gmail.com ([66.249.82.202]:19552 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751258AbVJJV2S convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 17:28:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kces1fJwEHlOsParIwdZ+bsxhxwDVJtR7rBZ9k73WHuFY4puXjKGFZKPuFIVtMhYSuOvmHCKv4/F9//Cvyt8lVGaci6SZYKO1yX8Pb+97LaVOS8rQDhjZc7H339ZznQcdctBV/RXqYLE4IfAOvzwFwQ3ATLVIuYzJ9FzaTEWBSc=
Message-ID: <5bdc1c8b0510101428o475d9dbct2e9bdcc6b46418c9@mail.gmail.com>
Date: Mon, 10 Oct 2005 14:28:17 -0700
From: Mark Knecht <markknecht@gmail.com>
To: Daniel Walker <dwalker@mvista.com>
Subject: Re: Latency data - 2.6.14-rc3-rt13
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Lee Revell <rlrevell@joe-job.com>
In-Reply-To: <5bdc1c8b0510101412n714c4798v1482254f6f8e0386@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b0510101316k23ff64e2i231cdea7f11e8553@mail.gmail.com>
	 <1128977359.18782.199.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <5bdc1c8b0510101412n714c4798v1482254f6f8e0386@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/05, Mark Knecht <markknecht@gmail.com> wrote:
<SNIP>
> > then goto Kernel Hacking and select
> > "Interrupts-off critical section latency timing"
> > Then select "Latency tracing"

Only had to turn on Latency Tracing. The others I had on...

<SNIP>
> >
> > Daniel
>
> Will do. Building now. I'll be back later.
>

Unfortunately I didn't think I'd be back this fast. I built the new
kernel and rebooted. The boot starts, gets down to the point where it
tells me that the preempt debug stuff is on, and then jumps to an
endlessly repeating error message:

init[1]: segfault at ffffffff8010fce0 rip ffffffff8010fce0 rsp
00007fffffcb09b8 error 15

This error repeasts endlessly until I reboot.

Good thing I had another kernel I could boot back into! ;-)

So, something isn't happy. Is this a -rt thing or a kernel issue?

Cheers,
Mark
