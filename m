Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267465AbUBSCBJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 21:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267467AbUBSCBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 21:01:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:46314 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267465AbUBSCAQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 21:00:16 -0500
Date: Wed, 18 Feb 2004 17:52:40 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Wakko Warner <wakko@animx.eu.org>
Cc: harald.dunkel@t-online.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.2: "-" or "_", thats the question
Message-Id: <20040218175240.46fbd285.rddunlap@osdl.org>
In-Reply-To: <20040218122523.A17548@animx.eu.org>
References: <402A887D.7030408@t-online.de>
	<402EDBA8.4070102@lovecn.org>
	<402F42DE.5090308@t-online.de>
	<20040217184132.541a5a76.rusty@rustcorp.com.au>
	<20040217202839.A16590@animx.eu.org>
	<40332666.60703@t-online.de>
	<20040218122523.A17548@animx.eu.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Feb 2004 12:25:23 -0500 Wakko Warner <wakko@animx.eu.org> wrote:

| When I first noticed that [eou]hci_hcd was loaded I figured all modules were
| using _ now.  When I was playing with alsa it never clicked in about the -
| and _.  I see now that it's _ in /proc/modules.
| 
| [OT] why is the usb drivers named with -hcd at the end anyway?

Because some USB drivers are for USB devices (no -hcd at end)
and some of them are USB host controller drivers (HCDs), not for
USB devices per se.  It's just a simple differeniation.

--
~Randy
