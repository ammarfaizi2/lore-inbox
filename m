Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261653AbUL3PXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbUL3PXn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 10:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbUL3PXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 10:23:42 -0500
Received: from mail.hometree.net ([194.77.152.181]:35740 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP id S261653AbUL3PXi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 10:23:38 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: Fwd: Toshiba PS/2 touchpad on 2.6.X not working along bottom and right sides
Date: Thu, 30 Dec 2004 15:23:36 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <cr16ho$eh1$1@tangens.hometree.net>
References: <105c793f04122907116b571ebf@mail.gmail.com> <105c793f041230065818ba608f@mail.gmail.com>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1104420216 14881 194.77.152.164 (30 Dec 2004 15:23:36 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Thu, 30 Dec 2004 15:23:36 +0000 (UTC)
X-Copyright: (C) 1996-2005 Henning Schmiedehausen
X-No-Archive: yes
User-Agent: nn/6.6.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Haninger <ahaning@gmail.com> writes:

This might be a touchpad that simulates the scroll wheel on the right
side and horizontal scrolling on the bottom.

Does your touchpad emit mouse button events when touching on the 
right / bottom side?

I have a Toshiba Satellite with another touchpad (a Synaptics) and
this can be programmed to do so. I'd think that Toshiba noadays uses
touchpads that have this hard-coded (maybe there is a command to turn
this on/off).

	Regards
		Henning

>I forgot to CC the list in case anyone else was interested in this
>information as well.

>Sorry about the dupe, Dmitry.

>-Andy

>---------- Forwarded message ----------
>From: Andrew Haninger <ahaning@gmail.com>
>Date: Thu, 30 Dec 2004 09:53:33 -0500
>Subject: Re: Toshiba PS/2 touchpad on 2.6.X not working along bottom
>and right sides
>To: Dmitry Torokhov <dtor_core@ameritech.net>

>> > I recently installed Linux 2.6.10 on my Gateway Solo 2500 notebook
>> > after using it happily with 2.4.27 (aside from some ACPI sleeping
>> > issues). Since installing the new kernel, I've noticed an odd problem
>> > with the Toshiba PS/2 touchpad which is used as a cursor. If I move my
>> > finger left and right along the 'bottom' portion of the touchpad or up
>> > and down along the right side, there is no movement from the mouse
>> > cursor at all. This behavior shows up using gdm and XFree86. Running
>> > 'xev' produces no output when these sides are used. However, if I move
>> > my finger left-right along the top side or up-down along the left
>> > side, the cursor moves just fine. Tapping the pad to click in the
>> > non-working areas and moving the finger from outside of these areas
>> > and then into them, however, works fine
>>
>> What does dmesg and /proc/bus/input/devices say about your touchpad?

>root@laptop:~# dmesg | grep "PS"
>mice: PS/2 mouse device common for all mice
>input: PS2T++ Logitech TouchPad 3 on isa0060/serio1

>root@laptop:~# cat /proc/bus/input/devices
>I: Bus=0011 Vendor=0002 Product=0003 Version=0061
>N: Name="PS2T++ Logitech TouchPad 3"
>P: Phys=isa0060/serio1/input0
>H: Handlers=mouse0
>B: EV=7
>B: KEY=70000 0 0 0 0 0 0 0 0
>B: REL=143

>Actually, this was more information than I was able to find earlier.
>I'll be able to do some more useful searches now.

>Thanks.
>--
>Andy
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen          INTERMETA GmbH
hps@intermeta.de        +49 9131 50 654 0   http://www.intermeta.de/

RedHat Certified Engineer -- Jakarta Turbine Development  -- hero for hire
   Linux, Java, perl, Solaris -- Consulting, Training, Development

What is more important to you...
   [ ] Product Security
or [ ] Quality of Sales and Marketing Support
              -- actual question from a Microsoft customer survey
