Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265941AbUAKRV6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 12:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265942AbUAKRV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 12:21:57 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:52424 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265941AbUAKRVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 12:21:55 -0500
Date: Sun, 11 Jan 2004 18:23:36 +0100 (CET)
From: =?ISO-8859-1?Q?Gunter_K=F6nigsmann?= <gunter@peterpall.de>
Reply-To: =?ISO-8859-1?Q?Gunter_K=F6nigsmann?= <gunter.koenigsmann@gmx.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
cc: Gunter =?iso-8859-1?q?K=F6nigsmann?= <gunter@peterpall.de>,
       linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
       Peter Berg Larsen <pebl@math.ku.dk>
Subject: Re: Synaptics Touchpad workaround for strange behavior after Sync
 loss (With Patch). (fwd)
In-Reply-To: <200401111138.49858.dtor_core@ameritech.net>
Message-ID: <Pine.LNX.4.53.0401111821410.1813@calcula.uni-erlangen.de>
References: <Pine.LNX.4.53.0401111652510.1271@calcula.uni-erlangen.de>
 <200401111138.49858.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:6f0b4d165b4faec4675b8267e0f72da4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Last mail from me for this theme:

The kernel version without Your patches gets sync losses even when I use
the i8042.nomux=1 parameter.

Yours,

	Gunter.

On Today, Dmitry Torokhov wrote:

>From: Dmitry Torokhov <dtor_core@ameritech.net>
>Date: Sun, 11 Jan 2004 11:38:49 -0500
>To: Gunter Königsmann <gunter.koenigsmann@gmx.de>,
>     Gunter Königsmann <gunter@peterpall.de>
>Delivered-To: GMX delivery to gunter.koenigsmann@gmx.de
>Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
>     Peter Berg Larsen <pebl@math.ku.dk>
>Subject: Re: Synaptics Touchpad workaround for strange behavior after Sync
>    loss (With Patch). (fwd)
>
>On Sunday 11 January 2004 11:27 am, Gunter Königsmann wrote:
>> Strike! Helps.
>>
>> No more warnings, no more bad clicks, and a *real* smooth movement.
>>
>
>Great!
>
>Could you tell us what kind of laptop you have (manufacturer/model)
>so other people would not have such pain as you had with it?
>
>> Never thought, a touchpad can work *this* well... ;-)
>>
>> Anyway, I still get those 4 lines  on leaving X, but don't know, if it
>> is an error of the kernel, anyway, and doesn't do anything bad exept of
>> warning me:
>>
>> atkbd.c: Unknown key released (translated set 2, code 0x7a on
>> isa0060/serio0). atkbd.c: Unknown key released (translated set 2, code
>> 0x7a on isa0060/serio0). atkbd.c: Unknown key released (translated set
>> 2, code 0x7a on isa0060/serio0). atkbd.c: Unknown key released
>> (translated set 2, code 0x7a on isa0060/serio0).
>
>I believe Vojtech said that it's because X on startup tries to talk to the
>keyboard controller directly, nothing to worry about... But I might be
>mistaken.
>
>>
>>
>> Yours,
>>
>> 	Gunter.
>
>Dmitry
>
>

-- 
If today is the first day of the rest of your life, what the hell was yesterday?
	---fortune(6)
