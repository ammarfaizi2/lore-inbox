Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWBYWrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWBYWrt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 17:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWBYWrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 17:47:49 -0500
Received: from mtiwmhc13.worldnet.att.net ([204.127.131.117]:7591 "EHLO
	mtiwmhc13.worldnet.att.net") by vger.kernel.org with ESMTP
	id S932189AbWBYWrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 17:47:48 -0500
Message-ID: <4400DE8C.1000303@lwfinger.net>
Date: Sat, 25 Feb 2006 16:47:40 -0600
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: matthieu castet <castet.matthieu@free.fr>
CC: John Stoffel <john@stoffel.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [Announce] Intel PRO/Wireless 3945ABG Network Connection
References: <43FF88E6.6020603@linux.intel.com>	<20060225084139.GB22109@infradead.org>	<200602250549.47547.gene.heskett@verizon.net>	<Pine.LNX.4.61.0602251518200.31692@yvahk01.tjqt.qr>	<pan.2006.02.25.22.07.53.810642@free.fr> <17408.55266.948833.168988@smtp.charter.net> <4400DA0B.1060502@free.fr>
In-Reply-To: <4400DA0B.1060502@free.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

matthieu castet wrote:
> And what happen with the userspace binary blob ?
> 
> How it will know in which country you are ?
> Does it access to a secret GPS on your computer ?
> 
> So there are 2 solutions :
> - make the card work only for a country with a flag in a RO eeprom or in 
> another place in the hardware (firmware, ....).
> - make the card works on all the possible channels.
> 
> Also if the firmware need to be load each time you reset the card (this 
> is the case with the current ipw2xxx implementation), you won't notice 
> if you switch for a firmware for a country X to a firmware for a country Y.

I haven't looked at the driver code, but I would expect it to be like the ipw2200 where the 
"country" code is in eeprom, which sets a code specifying the region where it will work. If you take 
a given piece of hardware somewhere else in the world, it will likely not be in complience.

Larry

