Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751588AbVJSWNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbVJSWNF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 18:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbVJSWNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 18:13:05 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:3766 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751588AbVJSWNE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 18:13:04 -0400
Date: Thu, 20 Oct 2005 00:12:28 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Tim Bird <tim.bird@am.sony.com>, Andrew Morton <akpm@osdl.org>,
       tglx@linutronix.de, george@mvista.com, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com, paulmck@us.ibm.com, hch@infradead.org,
       oleg@tv-sign.ru
Subject: Re: kernel/timer.c design (was: Re: ktimers subsystem)
In-Reply-To: <20051019104938.GA30185@elte.hu>
Message-ID: <Pine.LNX.4.61.0510192041580.1386@scrub.home>
References: <Pine.LNX.4.61.0510171948040.1386@scrub.home> <4353F936.3090406@am.sony.com>
 <Pine.LNX.4.61.0510172138210.1386@scrub.home> <20051017201330.GB8590@elte.hu>
 <Pine.LNX.4.61.0510172227010.1386@scrub.home> <20051018084655.GA28933@elte.hu>
 <Pine.LNX.4.61.0510190311140.1386@scrub.home> <20051019104938.GA30185@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 19 Oct 2005, Ingo Molnar wrote:

> > Whether the timer event is delivered or not is completely unimportant, 
> > as at some point the event has to be removed anyway, so that 
> > optimizing a timer for (non)delivery is complete nonsense.
> 
> completely wrong! To explain this, let me first give you an introduction 
> to the design goals and implementation/optimization details of the 
> upstream kernel/timer.c code:

I indeed made a mistake, thanks for pointing it out so elaborately.

I'd like to mention something else here. It's rather bad style to start 
with "completely wrong!" and then continue to gloat with "let me give you 
an introduction", unless you intentionally want to insult me. Usually I 
would just ignore this, as it can happen to anyone, but I can find this 
style too often in your mails lately with the most obvious example of your 
"shut up or show code" comment. You're more busy trying to prove me wrong 
than adressing the actual issue. It never was my intention to discuss the 
kernel timer design (the one in timer.c you describe here), the original 
issue was and still is that "timer API" is a too generic term and you 
actually proved my point by using the terms timer and their timeout values 
very consistently in your description.

It's possible I read this wrong, in that case I apologize already in 
advance, but please rethink the attitude you're showing, otherwise I'll 
reduce our conversion to a minimum. You're certainly have the more 
detailed knowledge in this area, but you don't have to show it off like 
this.

bye, Roman
