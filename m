Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271730AbRIJVKO>; Mon, 10 Sep 2001 17:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271687AbRIJVKE>; Mon, 10 Sep 2001 17:10:04 -0400
Received: from opengraphics.com ([216.208.162.194]:33208 "EHLO
	hurricane.opengraphics.com") by vger.kernel.org with ESMTP
	id <S271737AbRIJVJ5>; Mon, 10 Sep 2001 17:09:57 -0400
Date: Mon, 10 Sep 2001 17:10:12 -0400
To: "Udo A. Steinberg" <reality@delusion.de>
Cc: Pete Zaitcev <zaitcev@redhat.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: USB device not accepting new address
Message-ID: <20010910171012.A3460@concord.opengraphics.com>
In-Reply-To: <mailman.999666181.21742.linux-kernel2news@redhat.com> <200109051619.f85GJEo07592@devserv.devel.redhat.com> <3B967EDD.5A81F2DD@delusion.de> <20010905160940.B11067@devserv.devel.redhat.com> <3B96C59A.2EC7C768@delusion.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B96C59A.2EC7C768@delusion.de>
User-Agent: Mutt/1.3.18i
From: Len Sorensen <lsorense@opengraphics.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2001 at 02:38:50AM +0200, Udo A. Steinberg wrote:
> I've just tried all -ac1 kernels from 2.4.5-ac1 to 2.4.9-ac1
> and the problem exists with all of them. So it would appear that
> it didn't work reliably with earlier kernels either. I find it
> interesting however, that it is much harder to trigger in
> earlier kernels and that it doesn't happen every time.

I have seen a similar problem when I plugged in a creative nomad jukebox
(which was misbehaving with windows as well).  It had been behaving
properly in the past, but was of course an unrecognized usb device.
However this time it failed to get a device id assigned.  The solution:
replace the usb cable.  Turns out one of the wires had a break in it,
and would loose the connection in one direction if you didn't bend it
"just right".  if you have usb problems, treat it like scsi: blame the
cable first.  With a different usb cable all the problems went away
instantly and it accepted it's usb device id.

Len Sorensen
