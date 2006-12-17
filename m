Return-Path: <linux-kernel-owner+w=401wt.eu-S1752407AbWLQKyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407AbWLQKyU (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 05:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752406AbWLQKyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 05:54:20 -0500
Received: from vervifontaine.sonytel.be ([80.88.33.193]:38214 "EHLO
	vervifontaine.sonycom.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752398AbWLQKyT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 05:54:19 -0500
Date: Sun, 17 Dec 2006 11:54:17 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
 for 2.6.19]
In-Reply-To: <Pine.LNX.4.61.0612141815100.12730@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.62.0612171153310.27120@pademelon.sonytel.be>
References: <4580E37F.8000305@mbligh.org> <003801c71f45$45d722c0$6721100a@nuitysystems.com>
 <20061214111439.11bed930@localhost.localdomain> <200612141231.17331.hjk@linutronix.de>
 <20061214124241.44347df6@localhost.localdomain>  <Pine.LNX.4.61.0612141354410.6223@yvahk01.tjqt.qr>
 <1166101830.27217.1037.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.61.0612141815100.12730@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584337861-1734303025-1166352857=:27120"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-1734303025-1166352857=:27120
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 14 Dec 2006, Jan Engelhardt wrote:
> On Dec 14 2006 14:10, Arjan van de Ven wrote:
> >On Thu, 2006-12-14 at 13:55 +0100, Jan Engelhardt wrote:
> >> >On Thu, 14 Dec 2006 12:31:16 +0100
> >> >Hans-Jürgen Koch wrote:
> >> >
> >> >You think its any easier to debug because the code now runs in ring 3 but
> >> >accessing I/O space.
> >> 
> >> A NULL fault won't oops the system,
> >
> >.. except when the userspace driver crashes as a result and then the hw
> >still crashes the hw (for example via an irq storm or by tying the PCI
> >bus or .. )
> 
> hw crashes the hw? Anyway, yes it might happen, the more with non-NULL pointers
> (dangling references f.ex.)
> However, if the userspace part is dead, no one acknowledges the irq, hence an
> irq storm (if not caused by writing bogus stuff into registers) should not
> happen.

Shared level IRQ?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
---584337861-1734303025-1166352857=:27120--
