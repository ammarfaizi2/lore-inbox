Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWAXVAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWAXVAd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 16:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbWAXVAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 16:00:33 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:53679 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750707AbWAXVAb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 16:00:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cSflhgkRaocG9ai05KjjYFcpQL36xpa0gLHCmnB8f3HkD22Ty8C3rVH1vBbupKjEq0gUF1myboFGtNJugJ3WDln9bLpi7j54JY0eMvXYpyRGc6LUeWJj1hm5Xlwp9U3t+tDxRHLy/xIh7NwVaw1ZZwIzPRRfBIkXNSRCqkbgr5c=
Message-ID: <6bffcb0e0601241300xd0b8d8dt@mail.gmail.com>
Date: Tue, 24 Jan 2006 22:00:26 +0100
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] kstopmachine has legit preempt_enable_no_resched (was: 2.6.15-rt12 bugs)
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1138126262.6695.29.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6bffcb0e0601230521l59b8360et@mail.gmail.com>
	 <1138065822.6695.6.camel@localhost.localdomain>
	 <6bffcb0e0601240533h3ba1a01ci@mail.gmail.com>
	 <1138112388.6695.26.camel@localhost.localdomain>
	 <6bffcb0e0601240737u3e77245g@mail.gmail.com>
	 <1138126262.6695.29.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/06, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Tue, 2006-01-24 at 16:37 +0100, Michal Piotrowski wrote:
[snip]
> > It's very hard to track down, because earlier versions of -rt ware too
> > buggy for me and most of them doesn't compile/boot.
>
> The 2.6.14-rtX series was pretty stable. How early did you go back?

To 2.6.15-rt1 - it doesn't compile (ipv6 module). 2.6.15-rt2 gives me
wonderful series of oops/warnings/badness on boot ;).

I will try 2.6.14-rtX.

Regards,
Michal Piotrowski
