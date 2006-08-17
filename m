Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbWHQIK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWHQIK1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 04:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWHQIK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 04:10:27 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:39332 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932271AbWHQIKZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 04:10:25 -0400
Date: Thu, 17 Aug 2006 10:01:50 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Lee Trager <Lee@PicturesInMotion.net>
cc: Jeff Garzik <jeff@garzik.org>, Gabor Gombas <gombasg@sztaki.hu>,
       Adrian Bunk <bunk@stusta.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: /dev/sd*
In-Reply-To: <44E3DFD6.4010504@PicturesInMotion.net>
Message-ID: <Pine.LNX.4.61.0608171000220.19847@yvahk01.tjqt.qr>
References: <1155144599.5729.226.camel@localhost.localdomain>
 <20060809212124.GC3691@stusta.de> <1155160903.5729.263.camel@localhost.localdomain>
 <20060809221857.GG3691@stusta.de> <20060810123643.GC25187@boogie.lpds.sztaki.hu>
 <44DB289A.4060503@garzik.org> <44E3DFD6.4010504@PicturesInMotion.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> AFAIR long ago Linus said he'd like just one major number (and thus only
>>> one naming scheme) for every disk in the system; with /dev/sd* we're now
>>> getting there.
>>
>> Yep.  /dev/disk is a long term goal :)
>>
>I agree with Adrian, users are going to get confused if their devices
>are named something different once they switch to this new interface. So
>if we're going to confusing them why not just take the big leap and
>switch it over to /dev/disk? It seems to make more sense then to have
>all IDE and SATA users use /dev/sda for awhile only to down the road
>have to to switch to /dev/disk.

In the process, we can rename the then-"generic disk" (scsi ide whatever) 
back to "hd*" since that actually expands to Hard Disk.
(If I would have known a lot earlier about Linux I would have proposed 
"id*" for the IDE disks.)


Jan Engelhardt
-- 
