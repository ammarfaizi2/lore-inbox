Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266074AbUAKXrX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 18:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266075AbUAKXrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 18:47:23 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:57219 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S266074AbUAKXrV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 18:47:21 -0500
Date: Mon, 12 Jan 2004 00:47:07 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: =?iso-8859-1?B?RnLpZOlyaWMgTC4gVy4=?= Meunier <1@pervalidus.net>
Cc: Murilo Pontes <murilo_pontes@yahoo.com.br>, linux-kernel@vger.kernel.org
Subject: Re: BUG: The key "/ ?" on my abtn2 keyboard is dead with kernel 2.6.1
Message-ID: <20040111234707.GA745@ucw.cz>
References: <200401111545.59290.murilo_pontes@yahoo.com.br> <Pine.LNX.4.58.0401111831070.342@pervalidus.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0401111831070.342@pervalidus.dyndns.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 11, 2004 at 06:35:21PM -0200, Frédéric L. W. Meunier wrote:
> On Sun, 11 Jan 2004, Murilo Pontes wrote:
> 
> >
> > 15:34:36 [root@murilo:/MRX/drivers]#diff -urN linux-2.6.0/drivers/input/keyboard/atkbd.c linux-2.6.1/drivers/input/keyboard/atkbd.c > test.diff
> > 15:35:12 [root@murilo:/MRX/drivers]#wc -l test.diff
> >     387 test.diff
> > -------------> May be wrong?!
> >
> > 15:30:13 [root@murilo:/MRX/drivers]#dmesg | grep serio
> > serio: i8042 AUX port at 0x60,0x64 irq 12
> > input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
> > serio: i8042 KBD port at 0x60,0x64 irq 1
> > input: AT Translated Set 2 keyboard on isa0060/serio0
> > atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
> > atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
> > ----------> Last two lines, is apper each startx startup!!!!
> 
> Also reported by me - see
> http://marc.theaimsgroup.com/?l=linux-kernel&m=107376128814606&w=2
> 
> showkey under 2.4: keycode  89
> 
> But I didn't use startx, only the frame buffer. Maybe why I
> didn't get such "atkbd.c: Unknown key released (translated set
> 2, code 0x7a on isa0060/serio0)." messages ?
> 
> Vojtech: Does "[PATCH] Re: bad scancode for USB keyboard" -
> http://marc.theaimsgroup.com/?l=linux-kernel&m=107384731209938&w=2
> also fix it ?

The scancode 0x7a and backslash problems are completely unrelated.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
