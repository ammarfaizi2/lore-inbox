Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318264AbSGQKKu>; Wed, 17 Jul 2002 06:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318265AbSGQKKt>; Wed, 17 Jul 2002 06:10:49 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:45286 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S318264AbSGQKKs>; Wed, 17 Jul 2002 06:10:48 -0400
Message-ID: <3D35435F.E5CFA5E2@delusion.de>
Date: Wed, 17 Jul 2002 12:13:51 +0200
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.26 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: PS2 Input Core Support
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Vojtech,

I'm running 2.5.26 with an ordinary PS/2 keyboard and a 5 button PS/2 mouse.
When using the old psaux driver the mouse works fine.
With input core support, however, the scroll wheel doesn't work properly.
In my XF86Config I'm using IMPS/2 protocol and ZAxisMapping 4 5.
Scrolling up causes the window to scroll down. Scrolling down doesn't do
anything. When changing the protocol to ExplorerPS2 things are not much
better. You can't drag windows over the screen.

The following is the relevant kernel information.
Do you have any tips?

mice: PS/2 mouse device common for all mice
input.c: calling /sbin/hotplug input [HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add PRODUC
input.c: hotplug returned -2
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1  
serio: i8042 AUX port at 0x60,0x64 irq 12
input.c: calling /sbin/hotplug input [HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add PRODUC
input.c: hotplug returned -2
input: ImExPS/2 Microsoft IntelliMouse Explorer on isa0060/serio1

Regards,
Udo.
