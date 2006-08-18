Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbWHRHMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWHRHMg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 03:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbWHRHMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 03:12:36 -0400
Received: from mr1.bfh.ch ([147.87.250.50]:1511 "EHLO mr1.bfh.ch")
	by vger.kernel.org with ESMTP id S1750814AbWHRHMf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 03:12:35 -0400
Message-ID: <44E56804.1080906@bfh.ch>
Date: Fri, 18 Aug 2006 09:11:00 +0200
From: Seewer Philippe <philippe.seewer@bfh.ch>
Organization: BFH
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Jeff Garzik <jeff@garzik.org>, Gabor Gombas <gombasg@sztaki.hu>,
       Adrian Bunk <bunk@stusta.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: /dev/sd*
References: <1155144599.5729.226.camel@localhost.localdomain> <20060809212124.GC3691@stusta.de> <1155160903.5729.263.camel@localhost.localdomain> <20060809221857.GG3691@stusta.de> <20060810123643.GC25187@boogie.lpds.sztaki.hu> <44DB289A.4060503@garzik.org> <44E3DFD6.4010504@PicturesInMotion.net> <Pine.LNX.4.61.0608171000220.19847@yvahk01.tjqt.qr> <44E42900.1030905@PicturesInMotion.net> <Pine.LNX.4.61.0608171120260.4252@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0608171120260.4252@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Aug 2006 07:11:00.0157 (UTC) FILETIME=[755CCED0:01C6C295]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>> In the process, we can rename the then-"generic disk" (scsi ide whatever) 
>>> back to "hd*" since that actually expands to Hard Disk.
>>> (If I would have known a lot earlier about Linux I would have proposed 
>>> "id*" for the IDE disks.)
>>>
>> Actually that does make more sense then using disk. So I guess we're
>> back to square one. Personally I don't think its that big of a deal, all
>> you have to do is change fstab and grub or lilo. My main concern is for
>> the less advanced Linux users.
> 
> Less advanced users should use the upgrade tools their distribution 
> provides.

And personally I think less advanced users will be very happy with
/dev/disk (or /dev/hd). No more confusion wether to user /dev/hdx or
/dev/sdx or whatever!

Philippe Seewer

