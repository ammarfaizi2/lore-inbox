Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312590AbSGQMMK>; Wed, 17 Jul 2002 08:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313190AbSGQMMI>; Wed, 17 Jul 2002 08:12:08 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:27367 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S312590AbSGQMMH>; Wed, 17 Jul 2002 08:12:07 -0400
Message-ID: <3D355FD0.9F0E4F8@delusion.de>
Date: Wed, 17 Jul 2002 14:15:12 +0200
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.26 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PS2 Input Core Support
References: <3D35435F.E5CFA5E2@delusion.de> <20020717122000.A12529@ucw.cz> <3D355940.96EE8327@delusion.de> <20020717141004.C12529@ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> 
> This is interesting. Can you try the attached test utility? You need to
> enable CONFIG_INPUT_EVDEV, as well, and use it on /dev/input/evdev0 or
> 1, depening what's your mouse.
> 
> I'm wondering whether the scroll events show up or not.

Hello,

They show up in the output. First 4 events are scroll-down, last
4 events are scroll-up.

Regards,
-Udo.

./evtest /dev/input/event2 
Input driver version is 1.0.0
Input device ID: bus 0x11 vendor 0x6 product 0x2 version 0x100
Input device name: "ImExPS/2 Microsoft IntelliMouse Explorer"
Supported events:
  Event type 1 (Key)
    Event code 272 (LeftBtn)
    Event code 273 (RightBtn)
    Event code 274 (MiddleBtn)
    Event code 275 (SideBtn)
    Event code 276 (ExtraBtn)
  Event type 2 (Relative)
    Event code 0 (X)
    Event code 1 (Y)
    Event code 8 (Wheel)
Testing ... (interrupt to exit)
Event: time 1026908021.053509, type 2 (Relative), code 8 (Wheel), value -1
Event: time 1026908021.607555, type 2 (Relative), code 8 (Wheel), value -1
Event: time 1026908022.017017, type 2 (Relative), code 8 (Wheel), value -1
Event: time 1026908022.412833, type 2 (Relative), code 8 (Wheel), value -1
Event: time 1026908023.241679, type 2 (Relative), code 8 (Wheel), value -7
Event: time 1026908023.711842, type 2 (Relative), code 8 (Wheel), value -7
Event: time 1026908024.149266, type 2 (Relative), code 8 (Wheel), value -7
Event: time 1026908024.529600, type 2 (Relative), code 8 (Wheel), value -7
