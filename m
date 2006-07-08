Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030360AbWGHUmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030360AbWGHUmh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 16:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030363AbWGHUmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 16:42:37 -0400
Received: from mail.gmx.net ([213.165.64.21]:15006 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030360AbWGHUmh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 16:42:37 -0400
X-Authenticated: #20450766
Date: Sat, 8 Jul 2006 22:42:37 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Harald Dunkel <harald.dunkel@t-online.de>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc1: zd1211rw doesn't work yet?
In-Reply-To: <44B00653.3030303@t-online.de>
Message-ID: <Pine.LNX.4.60.0607082240180.10311@poirot.grange>
References: <44B00653.3030303@t-online.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jul 2006, Harald Dunkel wrote:

> Hi folks,
> 
> I have used the "external" zd1211 driver for months without problems,
> but the integrated version in 2.6.18-rc1 does not work for me.

Please, post this to <zd1211-devs@lists.sourceforge.net> along with 
details for your dongle, including the "zd1211 chip ..." line from your 
dmesg.

Thanks
Guennadi

> 
> iwconfig says:
> 
> wlan0     802.11g zd1211  ESSID:""
>           Mode:Managed  Frequency:2.412 GHz  Access Point: Invalid
>           Bit Rate=1 Mb/s
>           Encryption key:XXXX-XXXX-XXXX-XXXX-XXXX-XXXX-XX   Security mode:open
>           Link Quality:0  Signal level:0  Noise level:0
>           Rx invalid nwid:0  Rx invalid crypt:0  Rx invalid frag:0
>           Tx excessive retries:0  Invalid misc:0   Missed beacon:0
> 
> I had expected something like this (running iwconfig for 2.6.17.3
> + zd1211 rev80):
> 
> wlan0     802.11b/g NIC  ESSID:"harrinet"
>           Mode:Managed  Frequency=2.432 GHz  Access Point: XX:XX:XX:XX:XX:XX
>           Bit Rate:54 Mb/s
>           Retry:off   RTS thr=2432 B   Fragment thr:off
>           Encryption key:****-****-****-****-****-****-**   Security mode:open
>           Power Management:off
>           Link Quality=84/100  Signal level=55/100  Noise level=0/100
>           Rx invalid nwid:0  Rx invalid crypt:0  Rx invalid frag:44
>           Tx excessive retries:145  Invalid misc:0   Missed beacon:0
> 
> Please note that there is no MAC for 2.6.18-rc1.
> 
> ???
> 
> 
> Any hint would be highly appreciated. Of course I would be glad to
> help debugging.
> 
> 
> Regards
> 
> Harri
> 
> 
> 
> 

---
Guennadi Liakhovetski
