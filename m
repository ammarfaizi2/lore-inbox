Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbUL3O6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbUL3O6N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 09:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbUL3O6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 09:58:13 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:16798 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261625AbUL3O6H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 09:58:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=UwHxSIJCHg/b5dLEhK11gCveCGjeMNEeEhF8SLpFNY9GaaVNGUEPPwqeHt8ExpMETwkR7jGewBiL2nR8e+1I5DdJv503tzfD5/0TH4ExwdQ9CexIiVWxH1TivtsWZnCJhW5Ip7Gtn+hLjjlFpIOsztyWNlftsNVhTynDyHEoTPg=
Message-ID: <105c793f041230065818ba608f@mail.gmail.com>
Date: Thu, 30 Dec 2004 09:58:06 -0500
From: Andrew Haninger <ahaning@gmail.com>
Reply-To: Andrew Haninger <ahaning@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Fwd: Toshiba PS/2 touchpad on 2.6.X not working along bottom and right sides
In-Reply-To: <105c793f04123006532a9c1d18@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <105c793f04122907116b571ebf@mail.gmail.com>
	 <200412292338.08931.dtor_core@ameritech.net>
	 <105c793f04123006532a9c1d18@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I forgot to CC the list in case anyone else was interested in this
information as well.

Sorry about the dupe, Dmitry.

-Andy

---------- Forwarded message ----------
From: Andrew Haninger <ahaning@gmail.com>
Date: Thu, 30 Dec 2004 09:53:33 -0500
Subject: Re: Toshiba PS/2 touchpad on 2.6.X not working along bottom
and right sides
To: Dmitry Torokhov <dtor_core@ameritech.net>

> > I recently installed Linux 2.6.10 on my Gateway Solo 2500 notebook
> > after using it happily with 2.4.27 (aside from some ACPI sleeping
> > issues). Since installing the new kernel, I've noticed an odd problem
> > with the Toshiba PS/2 touchpad which is used as a cursor. If I move my
> > finger left and right along the 'bottom' portion of the touchpad or up
> > and down along the right side, there is no movement from the mouse
> > cursor at all. This behavior shows up using gdm and XFree86. Running
> > 'xev' produces no output when these sides are used. However, if I move
> > my finger left-right along the top side or up-down along the left
> > side, the cursor moves just fine. Tapping the pad to click in the
> > non-working areas and moving the finger from outside of these areas
> > and then into them, however, works fine
>
> What does dmesg and /proc/bus/input/devices say about your touchpad?

root@laptop:~# dmesg | grep "PS"
mice: PS/2 mouse device common for all mice
input: PS2T++ Logitech TouchPad 3 on isa0060/serio1

root@laptop:~# cat /proc/bus/input/devices
I: Bus=0011 Vendor=0002 Product=0003 Version=0061
N: Name="PS2T++ Logitech TouchPad 3"
P: Phys=isa0060/serio1/input0
H: Handlers=mouse0
B: EV=7
B: KEY=70000 0 0 0 0 0 0 0 0
B: REL=143

Actually, this was more information than I was able to find earlier.
I'll be able to do some more useful searches now.

Thanks.
--
Andy
