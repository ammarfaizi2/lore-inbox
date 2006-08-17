Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbWHQDRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWHQDRd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 23:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWHQDRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 23:17:33 -0400
Received: from mta10.srv.hcvlny.cv.net ([167.206.4.205]:34269 "EHLO
	mta10.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1750925AbWHQDRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 23:17:32 -0400
Date: Wed, 16 Aug 2006 23:17:42 -0400
From: Lee Trager <Lee@PicturesInMotion.net>
Subject: Re: /dev/sd*
In-reply-to: <44DB289A.4060503@garzik.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Gabor Gombas <gombasg@sztaki.hu>, Adrian Bunk <bunk@stusta.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Message-id: <44E3DFD6.4010504@PicturesInMotion.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
References: <1155144599.5729.226.camel@localhost.localdomain>
 <20060809212124.GC3691@stusta.de>
 <1155160903.5729.263.camel@localhost.localdomain>
 <20060809221857.GG3691@stusta.de>
 <20060810123643.GC25187@boogie.lpds.sztaki.hu> <44DB289A.4060503@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060731)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Gabor Gombas wrote:
>> AFAIR long ago Linus said he'd like just one major number (and thus only
>> one naming scheme) for every disk in the system; with /dev/sd* we're now
>> getting there.
>
> Yep.  /dev/disk is a long term goal :)
>
>     Jeff
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
I agree with Adrian, users are going to get confused if their devices
are named something different once they switch to this new interface. So
if we're going to confusing them why not just take the big leap and
switch it over to /dev/disk? It seems to make more sense then to have
all IDE and SATA users use /dev/sda for awhile only to down the road
have to to switch to /dev/disk.
