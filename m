Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWIUM2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWIUM2S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 08:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWIUM2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 08:28:18 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:65505 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751155AbWIUM2S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 08:28:18 -0400
Date: Thu, 21 Sep 2006 14:26:26 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Martin Bligh <mbligh@google.com>, "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Markers 0.4 (+dynamic probe loader) for 2.6.17
In-Reply-To: <20060921044603.GA2089@elte.hu>
Message-ID: <Pine.LNX.4.64.0609211418190.6762@scrub.home>
References: <20060920234517.GA29171@Krystal> <20060921044603.GA2089@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 21 Sep 2006, Ingo Molnar wrote:

> It affects all tracers: SystemTap/LKST has to adapt to such a scheme 
> too, because currently there's no markup scheme in the kernel. So this 
> is not something 'against' LTT, but something /for/ a unified landscape 
> of tracers. (and as i mentioned it before, it will be easy for you to 
> offer a simple "LTT speedup patch", which distros and the upstream 
> kernel can consider separately. But it must be /optional/.)

Out of curiosity: How exactly would it hurt this unifiation, if you left 
some of the implementation details simply to the archs?

> So far i have not seen any real arguments against this simple but 
> fundamental upstream requirement which i pointed out for v0.1 already.

It's funny, after reality sets in, I'll get exactly what I asked for in 
the first place, now I only have to figure out a way to do this without 
getting insulted by almost everyone...

bye, Roman
