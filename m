Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbTEFMme (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 08:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262715AbTEFMme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 08:42:34 -0400
Received: from [65.244.37.61] ([65.244.37.61]:65091 "EHLO
	WSPNYCON1IPC.corp.root.ipc.com") by vger.kernel.org with ESMTP
	id S262714AbTEFMmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 08:42:32 -0400
Message-ID: <170EBA504C3AD511A3FE00508BB89A9202085B63@exnanycmbx4.ipc.com>
From: "Downing, Thomas" <Thomas.Downing@ipc.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Simon Kelley <simon@thekelleys.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Binary firmware in the kernel - licensing issues.
Date: Tue, 6 May 2003 08:54:33 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
>
> So you can't distribute it at all unless there is other paperwork
> involved.
>
>> Given the current SCO-IBM situation I don't want to be responsible for
>> introducing any legally questionable IP into the kernel tree.
>> 
>> This situation must have come up before, how was it solved then?
>
> The easiest approach is to do the firmware load from userspace - which
> also keeps the driver size down and makes updating the firmware images
> easier for end users.
>
> (Debian as policy will rip the firmware out anyway regardless of what
> Linus does btw)
>
> The hotplug interface can be used to handle this.

I am writing a USB driver for a well-known vendor's USB device which
requires firmware download.  The vendor is considering allowing me
to publish the driver under GPL.  They will _not_ allow me to include
the binary firmware under any conditions.

So I will be loading the firmware from userspace - but the user must
obtain the firmware as a part of a larger application package.
(Complete crap IMO, but what can I do...)

PS:  what would be the preferred place to load the firmware
from, if no option giving the firmware pathname is passed to the 
module at load time?
