Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263400AbTJQLRe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 07:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263402AbTJQLRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 07:17:33 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:13023 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263400AbTJQLRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 07:17:32 -0400
Subject: Re: [Linux-fbdev-devel] Re: FBDEV 2.6.0-test7 updates.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Carlo E. Prelz" <fluido@fluido.as>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20031017111032.GB1639@casa.fluido.as>
References: <20031015162056.018737f1.akpm@osdl.org>
	 <Pine.LNX.4.44.0310160022210.13660-100000@phoenix.infradead.org>
	 <20031016091918.GA1002@casa.fluido.as> <1066298431.1407.119.camel@gaston>
	 <20031016101905.GA7454@casa.fluido.as> <1066300935.646.136.camel@gaston>
	 <20031017100412.GA1639@casa.fluido.as> <1066387778.661.226.camel@gaston>
	 <20031017111032.GB1639@casa.fluido.as>
Content-Type: text/plain
Message-Id: <1066389397.662.228.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 17 Oct 2003 13:16:37 +0200
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: benh@kernel.crashing.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Aha... So, from what you know, is there any possibility (fb, X, X with
> ATI drivers, anything else) to use the video output (or the second
> head) of radeon cards under Linux? And have you tried your drivers
> with 2 cards (one PCI and one AGP)?

I haven't tried with 2 cards, no. It's possible to do dual head
with XFree.

> And in all cases, why is parameter "mode" not working? If I could set
> 1280x1024-32@60 from Lilo, most of my problems would be solved...

I'll check that out. The new module parameter thing isn't that good,
I think I'll revive the old stuff for a while.

Ben.


