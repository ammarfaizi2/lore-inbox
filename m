Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269559AbTHKUBB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 16:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272844AbTHKUBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 16:01:00 -0400
Received: from smtp3.libero.it ([193.70.192.127]:41725 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id S269559AbTHKUAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 16:00:51 -0400
Subject: Re: [PATCH] lirc for 2.5/2.6 kernels - 20030802
From: Flameeyes <dgp85@users.sourceforge.net>
To: Pavel Machek <pavel@suse.cz>
Cc: Christoph Bartelmus <columbus@hit.handshake.de>,
       LIRC list <lirc-list@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>, vojtech@suse.cz
In-Reply-To: <20030811185259.GH2627@elf.ucw.cz>
References: <1059820741.3116.24.camel@laurelin>
	 <20030807214311.GC211@elf.ucw.cz>
	 <1060334463.5037.13.camel@defiant.flameeyes>
	 <20030808231733.GF389@elf.ucw.cz>
	 <8rZ2nqa1z9B@hit-columbus.hit.handshake.de>
	 <20030811124744.GB1733@elf.ucw.cz>
	 <1060607466.5035.8.camel@defiant.flameeyes>
	 <20030811153821.GC2627@elf.ucw.cz>
	 <1060616931.8472.22.camel@defiant.flameeyes>
	 <20030811185259.GH2627@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1060631734.1940.17.camel@defiant.flameeyes>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 11 Aug 2003 22:01:24 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-08-11 at 20:52, Pavel Machek wrote:
> I actually want to "Take a new tv card, plug it into machine, start
> up, use xine", without configuring remote ;-).
Flexibility or easy to use?
We can make a compromise: add some "default" configurations to the
software, so after it's installed, we can probably use our remote
correctly, but permit to anyone to change them.
Building them directly into the kernel deny you to do the thing you
said, I know that some cards with the same name of mine uses another
remote, if we check in the kernel the remote to use for this card, half
of these are unusable.
We must be able to change the method they use...
For example I use 1...9 buttons of my remote in xine as dvd-menu
selectors up/down left/right...

> I think the right way is for application to just use buttons it knows
> about. We already have some multimedia buttons on keyboard and some
> more on remote...
This make the rely to the hardware, and I think an userspace application
(say: a radio card software) that rely on multimedia keyboards need to
know every button of these.
Also, my ps2 keyboard has some extra buttons, but they're broken in the
2.5/2.6 kernel series.

> I believe we should be able to make it work without lircd, but input
> events with received codes is still better than current situation.
sincerely, I think about this after my first try to port lirc to 2.5,
because I wasn't able to compile lircd daemon, but I didn't [don't] know
the kernel as well as it's needed to change this.


Please also note that right now a lot of applications uses lirc_client
library, or have plugins for lirc (installed on my system, for example,
xmms, xine, xawdecode, zapping), lost this compatibility is a big
problem.
-- 
Flameeyes <dgp85@users.sf.net>

