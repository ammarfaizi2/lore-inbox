Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317312AbSHHDWx>; Wed, 7 Aug 2002 23:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317328AbSHHDWx>; Wed, 7 Aug 2002 23:22:53 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:14059 "EHLO
	lists.samba.org") by vger.kernel.org with ESMTP id <S317312AbSHHDWw>;
	Wed, 7 Aug 2002 23:22:52 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] PATCH 2.5: kconfig missing OBSOLETE (1_3) 
In-reply-to: Your message of "Wed, 07 Aug 2002 13:59:14 -0400."
             <3D515FF2.3000009@mandrakesoft.com> 
Date: Thu, 08 Aug 2002 12:44:24 +1000
Message-Id: <20020808032825.E52AA4170@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3D515FF2.3000009@mandrakesoft.com> you write:
> >        if [ "$CONFIG_OBSOLETE" = "y" ]; then
> > -         tristate '    FMV-181/182/183/184 support' CONFIG_FMV18X
> > +         tristate '    FMV-181/182/183/184 support (OBSOLETE)' CONFIG_FMV18X
> why bother?
> 
> CONFIG_OBSOLETE is not something people can select in 'make config'.

At the moment that is true.  But someone who still wants the driver
can hack it into their own .config, and they should be warned for
consistency.

Of course, a *policy* on depending on CONFIG_OBSOLETE would be nice,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
