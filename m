Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751529AbVJSFa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbVJSFa5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 01:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751530AbVJSFa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 01:30:57 -0400
Received: from smtp113.sbc.mail.re2.yahoo.com ([68.142.229.92]:30393 "HELO
	smtp113.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751528AbVJSFa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 01:30:56 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: ImExPS/2 status
Date: Wed, 19 Oct 2005 00:30:54 -0500
User-Agent: KMail/1.8.2
Cc: "James E. Jennison" <james.jennison@digital-creationsonline.com>
References: <200510181711.19618.james.jennison@digital-creationsonline.com>
In-Reply-To: <200510181711.19618.james.jennison@digital-creationsonline.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510190030.54715.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 October 2005 19:11, James E. Jennison wrote:
> Hey everyone...this is my first posting here, and I may not be going about 
> this the right way so please forgive me if I am not.  I had a question 
> regarding the status of the code for the ImExPS/2 style mice.
> 
> I currently have a Nexxtech NXX200 PS/2 Optical Wheel Mouse, running kernel 
> 2.6.13.4.  I noticed that prior to the 2.6.x.x series (whilst in the 2.4.x.x 
> series (I was stubborn)), that my mouse was working fine.
> 
> Now, however,if I plug my mouse in, the optical light comes on for perhaps 
> half a second, and the mouse goes dark.  The second thing that happens is if 
> you click either button, or move/click the scrollwheel, the cursor will go to 
> the upper right hand corner of the screen to where you only see a small 
> fraction of it.  This happens in both console mode and in graphical.
> 
> I have included the results from what dmesg displayed when I connected the 
> mouse to the computer, as well as some of the output from /var/log/messages:
> 
> input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
> 
> Oct 18 06:47:25 scooby gpm[18741]: Started gpm successfully. Entered daemon 
> mode.
> Oct 18 06:48:46 scooby kernel: psmouse.c: bad data from KBC - timeout
> Oct 18 06:48:47 scooby hal.hotplug[22794]: DEVPATH is not set
> Oct 18 06:48:47 scooby hal.hotplug[22836]: DEVPATH is not set
> Oct 18 06:48:47 scooby kernel: input: PS/2 Generic Mouse on isa0060/serio1

So you start without a mouse plugged in and still it detects a mouse?

> Oct 18 06:52:54 scooby hal.hotplug[2047]: DEVPATH is not set
> Oct 18 06:52:55 scooby hal.hotplug[2133]: DEVPATH is not set
> Oct 18 06:52:55 scooby kernel: input: ImExPS/2 Generic Explorer Mouse on 
> isa0060/serio1

And here you plug the mouse, right?

> Oct 18 06:54:28 scooby hal.hotplug[5846]: DEVPATH is not set
> Oct 18 06:54:28 scooby hal.hotplug[5884]: DEVPATH is not set
> Oct 18 06:54:29 scooby kernel: input: PS/2 Generic Mouse on isa0060/serio1
> 

-- 
Dmitry
