Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269731AbUISCct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269731AbUISCct (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 22:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269729AbUISCcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 22:32:48 -0400
Received: from pimout5-ext.prodigy.net ([207.115.63.73]:31680 "EHLO
	pimout5-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S269731AbUISCcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 22:32:46 -0400
Date: Sat, 18 Sep 2004 22:32:43 -0400 (EDT)
From: Vladimir Dergachev <volodya@mindspring.com>
X-X-Sender: volodya@node2.an-vo.com
Reply-To: Vladimir Dergachev <volodya@mindspring.com>
To: Jon Smirl <jonsmirl@gmail.com>
cc: dri-devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Design for setting video modes, ownership of sysfs attributes
In-Reply-To: <9e4733910409181916446719b8@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0409182229130.3641@node2.an-vo.com>
References: <9e47339104091815125ef78738@mail.gmail.com>  <E1C8oiI-0001xU-UG@evo.keithp.com>
  <9e47339104091817545b3d2675@mail.gmail.com>  <Pine.LNX.4.61.0409182156160.3498@node2.an-vo.com>
 <9e4733910409181916446719b8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 18 Sep 2004, Jon Smirl wrote:

> You did that from an xterm, right? Which console device is the xterm running on?

Yes.

I thought /dev/pts/1 was a console - much like regular tty or a serial 
port.

>
> X starts up a process that knows which device it is running and it can
> remember that device since X stays running.
>
> Maybe the answer is that this is something for the VC layer since the
> VC layer stays running and knows what device it was started on. An
> escape sequence could query the device from the VC terminal emulator.
>
> Is there some way to figure this out from the environment?

Well, there is a DISPLAY variable which you likely knew about. Otherwise 
there does not seem to be anything else console specific.

Btw, completely unrelated, but I found that that I have 
WINDOW_MANAGER=metacity set. Not sure how I got it, but I am running KDE.

                              best

                                 Vladimir Dergachev
