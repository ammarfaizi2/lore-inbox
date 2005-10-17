Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbVJQUbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbVJQUbz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 16:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbVJQUbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 16:31:55 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:4003 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932279AbVJQUby (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 16:31:54 -0400
Date: Mon, 17 Oct 2005 22:31:28 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Tim Bird <tim.bird@am.sony.com>, Andrew Morton <akpm@osdl.org>,
       tglx@linutronix.de, george@mvista.com, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com, paulmck@us.ibm.com, hch@infradead.org,
       oleg@tv-sign.ru
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
In-Reply-To: <20051017201330.GB8590@elte.hu>
Message-ID: <Pine.LNX.4.61.0510172227010.1386@scrub.home>
References: <Pine.LNX.4.61.0510171948040.1386@scrub.home> <4353F936.3090406@am.sony.com>
 <Pine.LNX.4.61.0510172138210.1386@scrub.home> <20051017201330.GB8590@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 17 Oct 2005, Ingo Molnar wrote:

> why you insist on ktimers being 'process timers'?

Because they are optimized for process usage. OTOH kernel usage is more 
than just "timeouts".

> so to answer your question: it is totally possible for a watchdog 
> mechanism to use ktimers. In fact it would be desirable from a 
> robustness POV too: 

"possible" and "desirable" is still different from "preferable", as they 
involve a higher cost.

> e.g. we dont want a watchdog from being 
> overload-able via too many timeouts in the timer wheel ...

Please explain.

bye, Roman
