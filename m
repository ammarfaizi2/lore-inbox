Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265940AbUAKSIX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 13:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbUAKSIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 13:08:23 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:46561 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265940AbUAKSIW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 13:08:22 -0500
Date: Sun, 11 Jan 2004 19:08:07 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Gunter =?iso-8859-1?Q?K=F6nigsmann?= <gunter.koenigsmann@gmx.de>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       Peter Berg Larsen <pebl@math.ku.dk>
Subject: Re: Synaptics Touchpad workaround for strange behavior after Sync loss (With Patch). (fwd)
Message-ID: <20040111180807.GB30920@ucw.cz>
References: <Pine.LNX.4.53.0401111652510.1271@calcula.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.53.0401111652510.1271@calcula.uni-erlangen.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 11, 2004 at 05:27:16PM +0100, Gunter Königsmann wrote:

> Strike! Helps.
> 
> No more warnings, no more bad clicks, and a *real* smooth movement.
> 
> Never thought, a touchpad can work *this* well... ;-)
> 
> Anyway, I still get those 4 lines  on leaving X, but don't know, if it is
> an error of the kernel, anyway, and doesn't do anything bad exept of
> warning me:
> 
> atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
> atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
> atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
> atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).

It's an XFree86 error. It's accessing the keyboard controller directly
behind the kernel's back. It even could cause the controller to fall out
of MUX mode.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
