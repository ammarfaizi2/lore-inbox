Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261607AbSKCEP7>; Sat, 2 Nov 2002 23:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261609AbSKCEP7>; Sat, 2 Nov 2002 23:15:59 -0500
Received: from sccrmhc02.attbi.com ([204.127.202.62]:17113 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S261607AbSKCEP5>; Sat, 2 Nov 2002 23:15:57 -0500
Message-ID: <3DC4A479.A0D90C21@attbi.com>
Date: Sat, 02 Nov 2002 20:22:17 -0800
From: C Sanjayan Rosenmund <gnuman@attbi.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ultracam distorted image
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using Kernel 2.4.19, IBM UltraPort Camera (I), ultracam, usbvideo,
videodev compiled in and as modules (neither works). . .
I looked at the MAINTAINERS file, and this device is not even listed so
I have no options left but to bug you (sorry).
when using the gqcam app, I get a distorted image (a sample can be found
on http://home.attbi.com/~gnuman/webcam.html ) and the error
ioctl (VIDIOCSWIN): Invalid argument
which seems to point to autoscaling brightness. . .
the image looks like it is not synching properly and the brightness does
not matter that much to me.

When I use the CVS usbvideo package (the module is named ultradrv
instead of ultracam), I get a smaller black screen and "error reading
image. . ."

when using the 2.5.45 kernel, I get a white one, with the same results.

Having done a Google search on UltraPort Camera and Linux, as well as
one on the error, I found Karl Gutwins page (where I got the CVS
package), and quite a bit of discussion that stopped a over a year ago,
about things not working. I found no one that could give me any more
advice on how to get this working for me. I get the same results when
I'm using the camera from the ultraport or USB.

hasciicam works, but that is useless to me as I need to use this with a
webcam and several other v4l applications.  I have run out of places to
look for information and clues, and I cannot find the author for the
kernel driver (not listed in the code, or the maintainers file). It
seems to me that *someone* must have gotten this running, but they seem
to want to keep that info to themselves?

Please reply to me personally as well as the list, to ensure that I see
any response.
Thank you for all your efforts in making Linux so great!

PS: is there any work being done on a DRM for the S3 Savage IX chipset?
That is the only other thing not working right on my laptop.
-- 
Sanjay
gnuman@attbi.com
I'm pretty sure that for a 747, IFR actually doesn't mean "I Follow
Roads."
