Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132575AbRDAXPW>; Sun, 1 Apr 2001 19:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132576AbRDAXPM>; Sun, 1 Apr 2001 19:15:12 -0400
Received: from zeus.kernel.org ([209.10.41.242]:50896 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S132575AbRDAXO7>;
	Sun, 1 Apr 2001 19:14:59 -0400
Date: Sun, 1 Apr 2001 16:01:53 -0700 (PDT)
From: David Lang <dlang@diginsite.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Manfred Spraul <manfred@colorfullife.com>,
   "Albert D. Cahalan" <acahalan@cs.uml.edu>, <lm@bitmover.com>,
   <linux-kernel@vger.kernel.org>
Subject: Re: bug database braindump from the kernel summit
In-Reply-To: <Pine.LNX.3.96.1010401174633.28121d-100000@mandrakesoft.mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0104011559590.25794-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

if we want to get the .config as part of the report then we need to make
it part of the kernel in some standard way (the old /proc/config flamewar)
it's difficult enough sometimes for the sysadmin of a box to know what
kernel is running on it, let alone a bug reporting script.

David Lang

 On Sun, 1 Apr
2001, Jeff Garzik wrote:

> Date: Sun, 1 Apr 2001 17:48:34 -0500 (CDT)
> From: Jeff Garzik <jgarzik@mandrakesoft.com>
> To: Manfred Spraul <manfred@colorfullife.com>
> Cc: Albert D. Cahalan <acahalan@cs.uml.edu>, lm@bitmover.com,
>      linux-kernel@vger.kernel.org
> Subject: Re: bug database braindump from the kernel summit
>
> On Sun, 1 Apr 2001, Manfred Spraul wrote:
> > From: "Jeff Garzik" <jgarzik@mandrakesoft.com>
> > >
> > > /proc/pci data alone with every bug report is usually invaluable.
> >
> > Even if the bug is a compile error?
>
> In fact, yes.  Having the tuple of: .config, /proc/pci, and compile
> error output, you can see additionally if the user is doing something
> wrong.
>
> It allows you to fix the user as well as the compile error ;-)
>
>
> > E.g.
> > BUG REPORT (a real one, I didn't have the time yet to post a patch):
> > kernel versions: tested with 2.4.2-ac24, afaics 2.4.3 is also affected
> > Description:
> > Several config options are missing in the 'if' at the end of
> > linux/drivers/net/pcmcia/Config.in.
> > This means that CONFIG_PCMCIA_NETCARD is not set, and then (iirc) the
> > kernel won't link.
> >
> > CONFIG_ARCNET_COM20020_CS
> > CONFIG_PCMCIA_HERMES
> > CONFIG_AIRONET4500_CS
> > CONFIG_PCMCIA_IBMTR
> > are missing.
>
> noted.
>
> > Obviously too much data doesn't hurt, as long as
> > * it's hidden somewhere deep in a database, clearly separated from the
> > important parts (if there is an oops: decoded oops, description, how
> > easy is it to trigger the bug, steps to reproduce)
> > * very easy for the bug reporter to collect.
> > * not mandatory.
>
> agreed.
>
> Regards,
>
> 	Jeff
>
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

