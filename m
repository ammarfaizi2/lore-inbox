Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbTIBMes (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 08:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbTIBMes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 08:34:48 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:39099 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S261440AbTIBMeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 08:34:36 -0400
Date: Tue, 2 Sep 2003 14:32:52 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: keyboard - was: Re: Linux 2.6.0-test4
Message-ID: <20030902123252.GC22365@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030831120605.08D6.CHRIS@heathens.co.nz> <20030902080733.GA14380@charite.de> <20030902124717.B1221@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030902124717.B1221@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andries Brouwer <aebr@win.tue.nl>:

> Yesterday's data sufficed, and I suppose the patch I gave solves
> this problem.

Nope. I applied the patch and rebuilt the kernel and rebooted.

Linux version 2.6.0-test4-bk2 (root@hummus2) (gcc version 3.2.3 (Debian)) #1 Tue Sep 2 11:45:23 CEST 2003
shows that the kernel I build this moring is actually running.

Right now, my CTRL key is totally "stuck" on the fbconsole. I can't
release it, not even by switching between the consoles and/or X11.

But now I don't get any messages like the one below (yes, the special
code generating this output is still active...)

> > atkbd.c: Unknown key (set 2, scancode 0x9c, on isa0060/serio0) pressed.
> > i8042 history: e0 d0 1c 9c 2e ae 10 90 e0 50 e0 d0 e0 d0 1c 9c

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
AIM: ralfpostfix
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
* Andries Brouwer <aebr@win.tue.nl>:

> Yesterday's data sufficed, and I suppose the patch I gave solves
> this problem.

Nope. I applied the patch and rebuilt the kernel and rebooted.

Linux version 2.6.0-test4-bk2 (root@hummus2) (gcc version 3.2.3 (Debian)) #1 Tue Sep 2 11:45:23 CEST 2003
shows that the kernel I build this moring is actually running.

Right now, my CTRL key is totally "stuck" on the fbconsole. I can't
release it, not even by switching between the consoles and/or X11.

But now I don't get any messages like the one below (yes, the special
code generating this output is still active...)

> > atkbd.c: Unknown key (set 2, scancode 0x9c, on isa0060/serio0) pressed.
> > i8042 history: e0 d0 1c 9c 2e ae 10 90 e0 50 e0 d0 e0 d0 1c 9c

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
AIM: ralfpostfix
