Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266513AbUGKHxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266513AbUGKHxs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 03:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266514AbUGKHxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 03:53:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:29664 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266513AbUGKHxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 03:53:47 -0400
Date: Sun, 11 Jul 2004 00:51:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: dtor_core@ameritech.net, karim@opersys.com, akropel1@rochester.rr.com,
       linux-kernel@vger.kernel.org, tim.bird@am.sony.com,
       celinux-dev@tree.celinuxforum.org, tpoynor@mvista.com
Subject: Re: [PATCH] preset loops_per_jiffy for faster booting
Message-Id: <20040711005156.1d6558dd.akpm@osdl.org>
In-Reply-To: <Pine.GSO.4.58.0407110945010.3013@waterleaf.sonytel.be>
References: <40EEF10F.1030404@am.sony.com>
	<200407102351.05059.dtor_core@ameritech.net>
	<40F0C8E8.2060908@opersys.com>
	<200407110019.14558.dtor_core@ameritech.net>
	<20040710222702.3718842e.akpm@osdl.org>
	<Pine.GSO.4.58.0407110945010.3013@waterleaf.sonytel.be>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Sat, 10 Jul 2004, Andrew Morton wrote:
> > Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > >
> > > I am no longer question presence of the code in the kernel, I just don't like
> > >  the message...
> >
> > yup, we shouldn't have the friendly message.
> 
> Just add the appropriate KERN_*, so it's not displayed by default, and people
> who want it can look it up in syslog.

Oh crap, sorry.  I just worked out what the darn printk is for.  Yes, it's
legit.  Let's just print the bogomips and loops_per_jiffy on the same line.

