Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbWHQITL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWHQITL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 04:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbWHQITL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 04:19:11 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:28619 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932166AbWHQITK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 04:19:10 -0400
Date: Thu, 17 Aug 2006 10:10:20 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Michael Tokarev <mjt@tls.msk.ru>
cc: Lee Trager <Lee@PicturesInMotion.net>, Jeff Garzik <jeff@garzik.org>,
       Gabor Gombas <gombasg@sztaki.hu>, Adrian Bunk <bunk@stusta.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: /dev/sd*
In-Reply-To: <44E42198.3030500@tls.msk.ru>
Message-ID: <Pine.LNX.4.61.0608171008100.19847@yvahk01.tjqt.qr>
References: <1155144599.5729.226.camel@localhost.localdomain>
 <20060809212124.GC3691@stusta.de> <1155160903.5729.263.camel@localhost.localdomain>
 <20060809221857.GG3691@stusta.de> <20060810123643.GC25187@boogie.lpds.sztaki.hu>
 <44DB289A.4060503@garzik.org> <44E3DFD6.4010504@PicturesInMotion.net>
 <44E42198.3030500@tls.msk.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> AFAIR long ago Linus said he'd like just one major number (and thus only
>>>> one naming scheme) for every disk in the system; with /dev/sd* we're now
>>>> getting there.
>>> Yep.  /dev/disk is a long term goal :)
>[]
>> I agree with Adrian, users are going to get confused if their devices
>> are named something different once they switch to this new interface. So
>> if we're going to confusing them why not just take the big leap and
>> switch it over to /dev/disk? It seems to make more sense then to have
>> all IDE and SATA users use /dev/sda for awhile only to down the road
>> have to to switch to /dev/disk.
>
>The reason, in my opinion anyway, is that not all the word is IDE now,
>and it has been this way for a long time.  I mean, real scsi uses /dev/sd*
>*right now*, and changing this to /dev/disk* will break just everything,
>not only people using IDE.

Some people already went through this when devfs hit the scene, and once again
when it left the scene. Should be practiced now :)


Jan Engelhardt
-- 
