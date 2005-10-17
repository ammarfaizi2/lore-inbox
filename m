Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750923AbVJQTsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbVJQTsa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 15:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbVJQTs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 15:48:29 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:50082 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750923AbVJQTs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 15:48:29 -0400
Date: Mon, 17 Oct 2005 21:48:08 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Tim Bird <tim.bird@am.sony.com>
cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       tglx@linutronix.de, george@mvista.com, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com, paulmck@us.ibm.com, hch@infradead.org,
       oleg@tv-sign.ru
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
In-Reply-To: <4353F936.3090406@am.sony.com>
Message-ID: <Pine.LNX.4.61.0510172138210.1386@scrub.home>
References: <Pine.LNX.4.61.0510171948040.1386@scrub.home> <4353F936.3090406@am.sony.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 17 Oct 2005, Tim Bird wrote:

> Maybe for a more experienced kernel person such as
> yourself, this distinction make sense.  But
> "process timer" and "kernel timer" don't carry much
> semantic value for me.  They seem to convey an
> arbitrary expectation of usage patterns.  Maybe
> they match the current usage patterns in the kernel,
> but I'd prefer naming based on functionality or
> behaviour of the API.

Let's say you want to implement a watchdog timer for a driver, which runs 
about every second to do something. Now if you have the choice between 
"timer API" vs. "timeout API" and "kernel timer" vs. "process timer", what 
would you choose based on the name?

bye, Roman
