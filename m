Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263805AbUBDJ2m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 04:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266101AbUBDJ2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 04:28:42 -0500
Received: from moutng.kundenserver.de ([212.227.126.184]:54527 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S263805AbUBDJ2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 04:28:38 -0500
Date: Wed, 4 Feb 2004 10:27:39 +0100 (CET)
From: =?ISO-8859-1?Q?Gunter_K=F6nigsmann?= <gunter@peterpall.de>
Reply-To: =?ISO-8859-1?Q?Gunter_K=F6nigsmann?= <gunter.koenigsmann@gmx.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
cc: Gunter =?iso-8859-1?q?K=F6nigsmann?= <gunter@peterpall.de>,
       linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
       Peter Berg Larsen <pebl@math.ku.dk>
Subject: Re: Synaptics Touchpad workaround for strange behavior after Sync
 loss (With Patch). (fwd)
In-Reply-To: <200401111138.49858.dtor_core@ameritech.net>
Message-ID: <Pine.LNX.4.53.0402041017410.857@calcula.uni-erlangen.de>
References: <Pine.LNX.4.53.0401111652510.1271@calcula.uni-erlangen.de>
 <200401111138.49858.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:6f0b4d165b4faec4675b8267e0f72da4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there!

I am the guy with the Siemens Amilo-M Notebook and the Synaptics Touchpad
loosing sync.

I have upgraded to linux-2.6.2, and IT WORKS out of the box! Even without
the 8042.nomux kernel parameter.

In the Changelog there are some of the kernel patches You gave me for 2.6.1,
and loads of ACPI changes. Perhaps You were right, and the power management
interferred with the Multiplexer.


Thanks a lot another time,


	Gunter Königsmann.

On Jan 11, Dmitry Torokhov wrote:

>From: Dmitry Torokhov <dtor_core@ameritech.net>
>Date: Sun, 11 Jan 2004 11:38:49 -0500
>To: Gunter Königsmann <gunter.koenigsmann@gmx.de>,
>     Gunter Königsmann <gunter@peterpall.de>
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

-- 
This Czech walks into police station in 1968 during the Fraternal Assistance.
Czech:  Hey, out there in the street, a Swiss soldier knocked me down and
        took my Russian watch.
Desk Sergeant:  Come again?
Czech:  Right out there in the street, a Swiss soldier knocked me down and
        took my Russian watch.
DS:     You're confused.   Why would there be a Swiss soldier here?  And who
        would want to own a Russian watch?  It was a Russian soldier who
        knocked you down and took your Swiss watch, right?
Czech:  Well, maybe, but you said it, not me.
		-- fortune(6)
