Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132586AbRDAWth>; Sun, 1 Apr 2001 18:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132583AbRDAWt1>; Sun, 1 Apr 2001 18:49:27 -0400
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:19474 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S132574AbRDAWtY>; Sun, 1 Apr 2001 18:49:24 -0400
Date: Sun, 1 Apr 2001 17:48:34 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, lm@bitmover.com,
   linux-kernel@vger.kernel.org
Subject: Re: bug database braindump from the kernel summit
In-Reply-To: <004601c0baf5$8fac4700$5517fea9@local>
Message-ID: <Pine.LNX.3.96.1010401174633.28121d-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Apr 2001, Manfred Spraul wrote:
> From: "Jeff Garzik" <jgarzik@mandrakesoft.com>
> >
> > /proc/pci data alone with every bug report is usually invaluable.
> 
> Even if the bug is a compile error?

In fact, yes.  Having the tuple of: .config, /proc/pci, and compile
error output, you can see additionally if the user is doing something
wrong.

It allows you to fix the user as well as the compile error ;-)


> E.g.
> BUG REPORT (a real one, I didn't have the time yet to post a patch):
> kernel versions: tested with 2.4.2-ac24, afaics 2.4.3 is also affected
> Description:
> Several config options are missing in the 'if' at the end of
> linux/drivers/net/pcmcia/Config.in.
> This means that CONFIG_PCMCIA_NETCARD is not set, and then (iirc) the
> kernel won't link.
> 
> CONFIG_ARCNET_COM20020_CS
> CONFIG_PCMCIA_HERMES
> CONFIG_AIRONET4500_CS
> CONFIG_PCMCIA_IBMTR
> are missing.

noted.

> Obviously too much data doesn't hurt, as long as
> * it's hidden somewhere deep in a database, clearly separated from the
> important parts (if there is an oops: decoded oops, description, how
> easy is it to trigger the bug, steps to reproduce)
> * very easy for the bug reporter to collect.
> * not mandatory.

agreed.

Regards,

	Jeff




