Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbVBAFGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbVBAFGw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 00:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbVBAFGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 00:06:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51603 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261546AbVBAFGu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 00:06:50 -0500
Date: Mon, 31 Jan 2005 21:06:35 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Peter Osterlund <petero2@telia.com>, vojtech@suse.cz,
       linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: Touchpad problems with 2.6.11-rc2
Message-ID: <20050131210635.3c582934@localhost.localdomain>
In-Reply-To: <200501312240.35776.dtor_core@ameritech.net>
References: <20050123190109.3d082021@localhost.localdomain>
	<m3acqr895h.fsf@telia.com>
	<20050131151549.26f437b0@localhost.localdomain>
	<200501312240.35776.dtor_core@ameritech.net>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2005 22:40:35 -0500, Dmitry Torokhov <dtor_core@ameritech.net> wrote:

> > Suddenly, touchpad motions started to cause wild movements in it became
> > impossible to do anything due to a focus loss (of course, I had plenty of
> > modified files open :-)

> > psmouse.c: TouchPad at isa0060/serio1/input0 lost sync at byte 3
> > psmouse.c: TouchPad at isa0060/serio1/input0 - driver resynched.
> > psmouse.c: TouchPad at isa0060/serio1/input0 lost sync at byte 3
> > psmouse.c: TouchPad at isa0060/serio1/input0 lost sync at byte 1
> > psmouse.c: TouchPad at isa0060/serio1/input0 lost sync at byte 1
> > psmouse.c: TouchPad at isa0060/serio1/input0 - driver resynched.

> 1. Have you tried using external PS/2 mouse?
> 2. Have you plugged/unplugged into a port replicator?

I have Dell Latitude D600, which does not have an external PS/2 port.

But actually, I was caught away from home, working from a library, so I did
not have either PS/2 or USB mouse. I moved the cursor persistently for a
few minutes until I managed to raise a window in such way that it got the
focus, then I saved all files and closed all windows from the keyboard,
so no harm done, no problem.

The kernel was running without resetafter set, unfortunately.

If you have a patch which prints offending data from pktbuffer, I can
run that next time.

Have a great day,
-- Pete
