Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262957AbUCRVAe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 16:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbUCRVAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 16:00:34 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:6276 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S262957AbUCRVAP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 16:00:15 -0500
Date: Thu, 18 Mar 2004 22:01:28 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Christian Guggenberger 
	<Christian.Guggenberger@physik.uni-regensburg.de>
Cc: Peter Williams <peterw@aurema.com>, linux-kernel@vger.kernel.org
Subject: Re: XFree86 seems to be being wrongly accused of doing the wrong thing
Message-ID: <20040318210128.GB4430@ucw.cz>
References: <1079593351.1830.12.camel@bonnie79> <40594ADE.2020804@aurema.com> <1079594175.1830.22.camel@bonnie79> <4059565E.4020007@aurema.com> <20040318091630.A2591@pc9391.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040318091630.A2591@pc9391.uni-regensburg.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 09:16:30AM +0100, Christian Guggenberger wrote:

> >>>I repeat.  These messages are appearing when XFree86 is NOT running so 
> >>>there is no way that it can be the cause of them.

> >>yeah, sorry. After reading your previous mail I realized it, too.
> >>If you have some spare time, you could boot with init=/bin/bash and then
> >>start every boot script step by step to see which one is causing these
> >>kernel messages.

> >OK.  As requested, I just did a boot with init=/bin/bash and the bad news 
> >is that the messages appeared before bash started.  So I think that 
> >confirms my suspicion that they occur before any of the start scripts are 
> >invoked?

> [cc'ed linux-kernel again]
> Yeah, I do think so.

Ok. If it appeats with init=/bin/bash and you're not running kbdrate in
your bashrc or profile, then this is likely a kernel or hardware
problem.

Can you please #define DEBUG in drivers/input/serio/i8042.c, recompile,
boot with init=/bin/bash, and then send me the resulting 'dmesg'?
Thanks.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
