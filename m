Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131082AbRASIGF>; Fri, 19 Jan 2001 03:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131201AbRASIFy>; Fri, 19 Jan 2001 03:05:54 -0500
Received: from [209.143.110.29] ([209.143.110.29]:11525 "HELO
	mail.the-rileys.net") by vger.kernel.org with SMTP
	id <S131082AbRASIFm>; Fri, 19 Jan 2001 03:05:42 -0500
Message-ID: <3A67F54D.F7E4C0BF@the-rileys.net>
Date: Fri, 19 Jan 2001 03:05:38 -0500
From: David Riley <oscar@the-rileys.net>
Reply-To: oscar@the-rileys.net
Organization: The Rileys
X-Mailer: Mozilla 4.74 (Macintosh; U; PPC)
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: rui.sousa@conexant.com
CC: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] via82cxxx_audio
In-Reply-To: <Pine.LNX.4.30.0101182106510.5753-200000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rui.sousa@conexant.com wrote:
> 
> Hi,
> 
> A patch for the via82cxxx_audio sound driver against 2.4.1-pre8.
> It includes:
> 
> 1. Support for variable fragment size and variable fragment number
> 2. Fixes for the SPEED, STEREO, CHANNELS, FMT ioctls when in read & write
> mode
> 2.1 Mmaped sound is now fully functional.
> 
> The patch is fairly tested (xmms, quake3, oss-test) but it might
> still have some bugs. Also there is almost no documentation update...
> sorry.

Yes!  This patch works wonderfully...  The mmapped sound is great, much
better than the ALSA drivers.  The patch also applies without a hitch to
2.4.0, since the driver hasn't been updated in a while (hope you feel
better soon, Jeff).  I haven't found any bugs, but my test of "see if it
runs quake3 and soldier of fortune without clipping or crashing" is far
from exhaustive.  I can definitely say that it's better than the ALSA
emulation of OSS, since there's no annoying mixing slowdown and
corresponding clipping.  Thanks!

-- 
"Windows for Dummies?  Isn't that redundant?"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
