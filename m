Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbTEAQLp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 12:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbTEAQLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 12:11:45 -0400
Received: from 60.54.252.64.snet.net ([64.252.54.60]:22415 "EHLO
	jaymale.blue-labs.org") by vger.kernel.org with ESMTP
	id S261408AbTEAQLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 12:11:43 -0400
Message-ID: <3EB122C4.4090901@blue-labs.org>
Date: Thu, 01 May 2003 09:36:04 -0400
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030429
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Ansorg <liste@ja-web.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.68 and trouble with mouse setup on Notebook
References: <1051683871.3692.42.camel@lisamobile>
In-Reply-To: <1051683871.3692.42.camel@lisamobile>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I also have an Inspiron, the 8200.  I am using one mouse device in X, 
/dev/input/mice and a USB mouse at times.  My glidepoint, stick, and USB 
mouse all work.  USB mouse can be unplugged/replugged at any time and 
still works.

This is with 2.5.67, 2.5.68 wants to immediately reboot on me.

Have you tried 2.5.67?  If not, are you interested in my .config?

David

Jens Ansorg wrote:

>hello,
>I have an Dell Inspiron Notebook that has two pointer devices build in:
>a Touchpad and a Trackstick (the mini Joystick placed in the keyboard
>area)
>
>while boot work fine in kernels of the 2.4.x series the Stick does not
>work with a current development kernen (2.5.68)
>
>
>The device just seems not there, no mention of it in the boot messages.
>
>I get just
>
>
>mice: PS/2 mouse device common for all mice
>...
>Found Synaptics Touchpad rev 5.7
>input: PS/2 Synaptics TouchPad on isa0060/serio1
>
>
># ll /dev/input/
>total 0
>crw-r--r--    1 root     root      13,  63 Jan  1  1970 mice
>crw-r--r--    1 root     root      13,  32 Jan  1  1970 mouse0
>
>
>does anybody have an advice how to get the stick working?
>
>thanks
>Jens
>
>
>  
>


