Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbVJSALY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbVJSALY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 20:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbVJSALY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 20:11:24 -0400
Received: from scooby.digital-creationsonline.com ([71.138.45.129]:45021 "EHLO
	scooby.digital-creationsonline.com") by vger.kernel.org with ESMTP
	id S932179AbVJSALY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 20:11:24 -0400
From: "James E. Jennison" <james.jennison@digital-creationsonline.com>
Organization: Digital Creations Online
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: ImExPS/2 status
Date: Tue, 18 Oct 2005 17:11:19 -0700
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510181711.19618.james.jennison@digital-creationsonline.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey everyone...this is my first posting here, and I may not be going about 
this the right way so please forgive me if I am not.  I had a question 
regarding the status of the code for the ImExPS/2 style mice.

I currently have a Nexxtech NXX200 PS/2 Optical Wheel Mouse, running kernel 
2.6.13.4.  I noticed that prior to the 2.6.x.x series (whilst in the 2.4.x.x 
series (I was stubborn)), that my mouse was working fine.

Now, however,if I plug my mouse in, the optical light comes on for perhaps 
half a second, and the mouse goes dark.  The second thing that happens is if 
you click either button, or move/click the scrollwheel, the cursor will go to 
the upper right hand corner of the screen to where you only see a small 
fraction of it.  This happens in both console mode and in graphical.

I have included the results from what dmesg displayed when I connected the 
mouse to the computer, as well as some of the output from /var/log/messages:

input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1

Oct 18 06:47:25 scooby gpm[18741]: Started gpm successfully. Entered daemon 
mode.
Oct 18 06:48:46 scooby kernel: psmouse.c: bad data from KBC - timeout
Oct 18 06:48:47 scooby hal.hotplug[22794]: DEVPATH is not set
Oct 18 06:48:47 scooby hal.hotplug[22836]: DEVPATH is not set
Oct 18 06:48:47 scooby kernel: input: PS/2 Generic Mouse on isa0060/serio1
Oct 18 06:52:54 scooby hal.hotplug[2047]: DEVPATH is not set
Oct 18 06:52:55 scooby hal.hotplug[2133]: DEVPATH is not set
Oct 18 06:52:55 scooby kernel: input: ImExPS/2 Generic Explorer Mouse on 
isa0060/serio1
Oct 18 06:54:28 scooby hal.hotplug[5846]: DEVPATH is not set
Oct 18 06:54:28 scooby hal.hotplug[5884]: DEVPATH is not set
Oct 18 06:54:29 scooby kernel: input: PS/2 Generic Mouse on isa0060/serio1

Is this something that is being addressed in the 2.6.14 kernel?  Or is there 
perhaps currently a patch available so that I can use my mouse?  I would 
really not have to go by another one if I can help it.

Thanks in advance,

James
