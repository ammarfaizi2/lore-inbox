Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbWHQH6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWHQH6Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 03:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWHQH6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 03:58:24 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:27480 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S932250AbWHQH6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 03:58:23 -0400
Message-ID: <44E42198.3030500@tls.msk.ru>
Date: Thu, 17 Aug 2006 11:58:16 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Lee Trager <Lee@PicturesInMotion.net>
CC: Jeff Garzik <jeff@garzik.org>, Gabor Gombas <gombasg@sztaki.hu>,
       Adrian Bunk <bunk@stusta.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: /dev/sd*
References: <1155144599.5729.226.camel@localhost.localdomain> <20060809212124.GC3691@stusta.de> <1155160903.5729.263.camel@localhost.localdomain> <20060809221857.GG3691@stusta.de> <20060810123643.GC25187@boogie.lpds.sztaki.hu> <44DB289A.4060503@garzik.org> <44E3DFD6.4010504@PicturesInMotion.net>
In-Reply-To: <44E3DFD6.4010504@PicturesInMotion.net>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Trager wrote:
> Jeff Garzik wrote:
>> Gabor Gombas wrote:
>>> AFAIR long ago Linus said he'd like just one major number (and thus only
>>> one naming scheme) for every disk in the system; with /dev/sd* we're now
>>> getting there.
>> Yep.  /dev/disk is a long term goal :)
[]
> I agree with Adrian, users are going to get confused if their devices
> are named something different once they switch to this new interface. So
> if we're going to confusing them why not just take the big leap and
> switch it over to /dev/disk? It seems to make more sense then to have
> all IDE and SATA users use /dev/sda for awhile only to down the road
> have to to switch to /dev/disk.

The reason, in my opinion anyway, is that not all the word is IDE now,
and it has been this way for a long time.  I mean, real scsi uses /dev/sd*
*right now*, and changing this to /dev/disk* will break just everything,
not only people using IDE.

/mjt

