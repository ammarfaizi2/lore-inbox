Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbVABHAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVABHAv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 02:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVABHAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 02:00:51 -0500
Received: from mx.freeshell.org ([192.94.73.21]:28108 "EHLO sdf.lonestar.org")
	by vger.kernel.org with ESMTP id S261221AbVABHAo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 02:00:44 -0500
Date: Sun, 2 Jan 2005 06:59:58 +0000 (UTC)
From: Roey Katz <roey@sdf.lonestar.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 & 2.6.10 unresponsive to keyboard upon bootup
In-Reply-To: <200501020152.32207.dtor_core@ameritech.net>
Message-ID: <Pine.NEB.4.61.0501020658040.15015@sdf.lonestar.org>
References: <Pine.NEB.4.61.0501010814490.26191@sdf.lonestar.org>
 <200501011631.36884.dtor_core@ameritech.net> <Pine.NEB.4.61.0501020622080.16181@sdf.lonestar.org>
 <200501020152.32207.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1411646026-1104649198=:15015"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1411646026-1104649198=:15015
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 2 Jan 2005, Dmitry Torokhov wrote:

>> Dmitry,
>>
>> I do not have a Synaptics touchpad on this computer nor do I have the
>> driver installed (though all I know is 'grep SYN .config' returned
>> empty, so I may be mistaken). =A0Does the Synaptics driver mess with the
>> keyboard at all?
>>
>
> Not exactly - Synaptics X driver "grabs" the device it uses so other
> processes do not get any data from the touchpad when its active. When
> keyboard and mouse initialization got swapped around many people who
> were specifying /dev/input/event0 as a device were in for surprise as
> the driver "grabbed" keyboard making it impossible to type.

Perhaps the wacom driver is doing some of its own grabbing.  Does the=20
evdev device matter to the console (i.e., a pty)?

>
> [snip]
>
> Does the keyboard work when you are not in X (like when booting to
> runlevel 3)? It looks like everything is detected correctly...

That's the thing -- the keyboard is unresponsive right from the login=20
prompt.


- Roey
--0-1411646026-1104649198=:15015--
