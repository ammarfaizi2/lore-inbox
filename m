Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265457AbUAKQjA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 11:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265840AbUAKQjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 11:39:00 -0500
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:27311 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265457AbUAKQi4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 11:38:56 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Gunter =?iso-8859-1?q?K=F6nigsmann?= <gunter.koenigsmann@gmx.de>,
       Gunter =?iso-8859-1?q?K=F6nigsmann?= <gunter@peterpall.de>
Subject: Re: Synaptics Touchpad workaround for strange behavior after Sync loss (With Patch). (fwd)
Date: Sun, 11 Jan 2004 11:38:49 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
       Peter Berg Larsen <pebl@math.ku.dk>
References: <Pine.LNX.4.53.0401111652510.1271@calcula.uni-erlangen.de>
In-Reply-To: <Pine.LNX.4.53.0401111652510.1271@calcula.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200401111138.49858.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 January 2004 11:27 am, Gunter Königsmann wrote:
> Strike! Helps.
>
> No more warnings, no more bad clicks, and a *real* smooth movement.
>

Great!

Could you tell us what kind of laptop you have (manufacturer/model)
so other people would not have such pain as you had with it? 

> Never thought, a touchpad can work *this* well... ;-)
>
> Anyway, I still get those 4 lines  on leaving X, but don't know, if it
> is an error of the kernel, anyway, and doesn't do anything bad exept of
> warning me:
>
> atkbd.c: Unknown key released (translated set 2, code 0x7a on
> isa0060/serio0). atkbd.c: Unknown key released (translated set 2, code
> 0x7a on isa0060/serio0). atkbd.c: Unknown key released (translated set
> 2, code 0x7a on isa0060/serio0). atkbd.c: Unknown key released
> (translated set 2, code 0x7a on isa0060/serio0).

I believe Vojtech said that it's because X on startup tries to talk to the
keyboard controller directly, nothing to worry about... But I might be
mistaken.

>
>
> Yours,
>
> 	Gunter.

Dmitry
