Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130053AbRBADYV>; Wed, 31 Jan 2001 22:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130076AbRBADYL>; Wed, 31 Jan 2001 22:24:11 -0500
Received: from getafix.lostland.net ([216.29.29.27]:10511 "EHLO
	getafix.lostland.net") by vger.kernel.org with ESMTP
	id <S130053AbRBADYF>; Wed, 31 Jan 2001 22:24:05 -0500
Date: Wed, 31 Jan 2001 22:23:57 -0500 (EST)
From: adrian <jimbud@lostland.net>
To: Gerd Knorr <kraxel@bytesex.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: bttv problems in 2.4.0/2.4.1
In-Reply-To: <slrn97h1h1.13r.kraxel@bogomips.masq.in-berlin.de>
Message-ID: <Pine.BSO.4.30.0101311800250.8045-100000@getafix.lostland.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 31 Jan 2001, Gerd Knorr wrote:

> > The card is a video only capture that came with a camera (and has a
> > connector to power that camera next to the video connector).
>
> Sure the box is really dead?  These very cheap cards with just the bt848
[snip]
> some sanity checks on the i2c bus first (options i2c-algo-bit bit_test=1).
>
>   Gerd
>

Yup, the box was just waiting for the timeout.  Setting that option allows
booting to continue regularly (i2c reports the device as being "busy"
during bootup).

Adrian


PS.  I think that card has gone bad or the drivers don't support it
correctly, since in both Windows and Linux machines it now gives scrambled
video.





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
