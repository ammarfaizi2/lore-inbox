Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266512AbUGKHrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266512AbUGKHrw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 03:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266513AbUGKHrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 03:47:52 -0400
Received: from witte.sonytel.be ([80.88.33.193]:18077 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266512AbUGKHru (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 03:47:50 -0400
Date: Sun, 11 Jul 2004 09:46:45 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrew Morton <akpm@osdl.org>
cc: Dmitry Torokhov <dtor_core@ameritech.net>, karim@opersys.com,
       akropel1@rochester.rr.com,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Tim Bird <tim.bird@am.sony.com>, celinux-dev@tree.celinuxforum.org,
       tpoynor@mvista.com
Subject: Re: [PATCH] preset loops_per_jiffy for faster booting
In-Reply-To: <20040710222702.3718842e.akpm@osdl.org>
Message-ID: <Pine.GSO.4.58.0407110945010.3013@waterleaf.sonytel.be>
References: <40EEF10F.1030404@am.sony.com> <200407102351.05059.dtor_core@ameritech.net>
 <40F0C8E8.2060908@opersys.com> <200407110019.14558.dtor_core@ameritech.net>
 <20040710222702.3718842e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jul 2004, Andrew Morton wrote:
> Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> >
> > I am no longer question presence of the code in the kernel, I just don't like
> >  the message...
>
> yup, we shouldn't have the friendly message.

Just add the appropriate KERN_*, so it's not displayed by default, and people
who want it can look it up in syslog.

Or what about a sysfs entry people can cat?

The alternative is to cat /proc/cpuinfo and grab a calculcator...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
