Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266624AbUBQXhb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 18:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266689AbUBQXhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 18:37:31 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:23778 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S266624AbUBQXhY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 18:37:24 -0500
From: Emmeran Seehuber <rototor@rototor.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: PS/2 Mouse does no longer work with kernel 2.6 on a laptop
Date: Wed, 18 Feb 2004 00:37:53 +0000
User-Agent: KMail/1.6
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
References: <200402112344.23378.rototor@rototor.de> <200402172313.39140.rototor@rototor.de> <200402171829.57596.dtor_core@ameritech.net>
In-Reply-To: <200402171829.57596.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200402180037.53614.rototor@rototor.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:d84d732d8ddd2281dac05c143a411240
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 February 2004 23:29, Dmitry Torokhov wrote:
> On Tuesday 17 February 2004 06:13 pm, Emmeran Seehuber wrote:
>
> OK, I am lost.. how many pointing devices you physically have?
> 2 or 3? According to the kernel data you have 2 PS/2 devices
>
> and one USB trackball:
> > N: Name="PS2++ Logitech Mouse"
> > P: Phys=isa0060/serio2/input0
> > N: Name="PS/2 Generic Mouse"
> > P: Phys=isa0060/serio4/input0
> > N: Name="Microsoft Microsoft Trackball Explorer®"
> > P: Phys=usb-0000:00:03.2-1/input0
>
> Is this correct? Or you have only 2 devices (one PS/2 and one USB) and it
> is one of those wierd USB legacy emulation troubles. Does it behave better
> if you load USB modules first and only then psmouse?
Sorry, I didn't want to confuse you.

I`ve attached a USB mouse because the PS/2 trackball didn`t work when I was 
creating the /proc-output (since I booted without the i????.nomux option). 
But I don`t like the USB mouse, I prefer to use the trackball.

The problem is the same: The USB mouse can be attachend/detached any time. It 
does hotplug very well. All data I've send you was with the USB mouse 
detached. Only when I did the cat /proc/... I didn't want to use the trackpad 
and attached the USB mouse ...

Just ignore the USB mouse. It doesn't seem to be related to the problem. And 
yes, in this case I had 3 physical devices (trackpad, PS/2 trackball, USB 
trackball) attached.

cu,
  Emmy
