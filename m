Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269461AbTHKPuY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 11:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272772AbTHKPsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 11:48:25 -0400
Received: from smtp0.libero.it ([193.70.192.33]:9349 "EHLO smtp0.libero.it")
	by vger.kernel.org with ESMTP id S272748AbTHKPsT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 11:48:19 -0400
Subject: Re: [PATCH] lirc for 2.5/2.6 kernels - 20030802
From: Flameeyes <dgp85@users.sourceforge.net>
To: Pavel Machek <pavel@suse.cz>
Cc: Christoph Bartelmus <columbus@hit.handshake.de>,
       LIRC list <lirc-list@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>, vojtech@suse.cz
In-Reply-To: <20030811153821.GC2627@elf.ucw.cz>
References: <1059820741.3116.24.camel@laurelin>
	 <20030807214311.GC211@elf.ucw.cz>
	 <1060334463.5037.13.camel@defiant.flameeyes>
	 <20030808231733.GF389@elf.ucw.cz>
	 <8rZ2nqa1z9B@hit-columbus.hit.handshake.de>
	 <20030811124744.GB1733@elf.ucw.cz>
	 <1060607466.5035.8.camel@defiant.flameeyes>
	 <20030811153821.GC2627@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1060616931.8472.22.camel@defiant.flameeyes>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 11 Aug 2003 17:48:52 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-08-11 at 17:38, Pavel Machek wrote:
> I guess a) is okay. There are not *so* many remote controls out there.
I think more than one per card model. Other Kworld Card have different
remote than mine, as you can see on my homepage, my lircd.conf isn't one
of the ones in lirc remotes list.

> I guess thats okay; if I want decoder-that-decodes-anything, I need
> one that connects to serial port and has non-trivial configuration.
But I can't take a new tv card, plug it into my machine, start up,
configure the remote, and use xine.

Also, from user apps dev view, I think is more difficult to check for
input events knowing that every remote has different buttons, instead of
configure the .lircrc and use lirc_client for receive directly
software-commands.

We can drop /dev/lirc*, and use input events with received codes, but I
think that lircd is still needed to translate them into userland
commands...
-- 
Flameeyes <dgp85@users.sf.net>

