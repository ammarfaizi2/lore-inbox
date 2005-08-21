Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbVHUFQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbVHUFQQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 01:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbVHUFQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 01:16:16 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:39054 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1750801AbVHUFQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 01:16:16 -0400
Message-ID: <43080E22.1070103@m1k.net>
Date: Sun, 21 Aug 2005 01:16:18 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Harald Dunkel <harald.dunkel@t-online.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12.5: psmouse mouse detection doesn't work
References: <4308062F.7080208@t-online.de>
In-Reply-To: <4308062F.7080208@t-online.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Dunkel wrote:

>At boot time my Logitech mouse is detected as
>
>I: Bus=0011 Vendor=0002 Product=0001 Version=0000
>N: Name="PS/2 Generic Mouse"
>P: Phys=isa0060/serio1/input0
>H: Handlers=event1 ts0 mouse0
>B: EV=7
>B: KEY=70000 0 0 0 0
>B: REL=3
>
>After manually reloading psmouse I get the expected
>
>I: Bus=0011 Vendor=0002 Product=0002 Version=0049
>N: Name="PS2++ Logitech Mouse"
>P: Phys=isa0060/serio1/input0
>H: Handlers=event1 ts0 mouse0
>B: EV=7
>B: KEY=f0000 0 0 0 0
>B: REL=3
>
>Using psmouse_noext=1 at boot time does not help.
>
>How comes that this doesn't work on the first run?
>
>I asked this more than a year ago, and somebody posted
>a fix, but obviously it wasn't accepted.
>
>What needs to be done to fix this?
>  
>
Harri-

I was having problems with my psmouse also.  Try the kernel boot option 
"usb-handoff", see if that helps.  This is just a suggestion.  I have 
nothing to do with the development of that driver.

Good Luck.

-- 
Michael Krufky

