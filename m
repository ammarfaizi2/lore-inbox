Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270673AbTHEUpW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 16:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270684AbTHEUpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 16:45:22 -0400
Received: from colin2.muc.de ([193.149.48.15]:41996 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S270673AbTHEUpV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 16:45:21 -0400
Date: 5 Aug 2003 22:45:17 +0200
Date: Tue, 5 Aug 2003 22:45:17 +0200
From: Andi Kleen <ak@colin2.muc.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Arjan van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Export touch_nmi_watchdog
Message-ID: <20030805204517.GB31598@colin2.muc.de>
References: <1060114808.5308.9.camel@laptop.fenrus.com> <Pine.LNX.4.44.0308051324070.2587-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308051324070.2587-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 01:25:09PM -0700, Linus Torvalds wrote:
> 
> On 5 Aug 2003, Arjan van de Ven wrote:
> > 
> > having a more generic/portable "trigger_watchdog" function would be
> > better then, such that ALL watchdogs, and not just the NMI one can hook
> > into this
> 
> Why are we working around broken drivers?

Because they're a hard to ignore reality? 

> 
> I say:
>  - either fix the driver

Would be quite a big project for the fusion driver. It's very big and 
complicated.

Of course I would like to fix it, but I see no chance at all to ever
find enough time to do that properly.

> or
>  - disable the watchdog entirely.

That would be a pity because it is very useful to find other problems.

-Andi

