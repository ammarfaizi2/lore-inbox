Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261609AbSKCEgZ>; Sat, 2 Nov 2002 23:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261615AbSKCEgZ>; Sat, 2 Nov 2002 23:36:25 -0500
Received: from [216.38.156.94] ([216.38.156.94]:26892 "EHLO
	mail.networkfab.com") by vger.kernel.org with ESMTP
	id <S261609AbSKCEgY>; Sat, 2 Nov 2002 23:36:24 -0500
Subject: Re: ultracam distorted image
From: Dmitri <dmitri@users.sourceforge.net>
To: ierC Sanjayan Rosenmund <gnuman@attbi.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3DC4A479.A0D90C21@attbi.com>
References: <3DC4A479.A0D90C21@attbi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Nov 2002 20:42:46 -0800
Message-Id: <1036298566.14085.9.camel@usb.networkfab.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-11-02 at 20:22, C Sanjayan Rosenmund wrote:

> I looked at the MAINTAINERS file, and this device is not even listed so

It always was experimental, as I recall. Karl Gutwin is the author.
See http://www.linux-usb.org/

> I have no options left but to bug you (sorry).

linux-usb-users@lists.sourceforge.net is a more appropriate forum.

> when using the gqcam app, I get a distorted image (a sample can be found
> on http://home.attbi.com/~gnuman/webcam.html ) and the error

It's better than most :-) You probably have a different version of the
camera, with a different firmware, hardware or sensor.

> the image looks like it is not synching properly and the brightness does
> not matter that much to me.

Indeed, the decoder of the camera datastream is not working. Everything
else, past the decoder, seems to work.

> When I use the CVS usbvideo package (the module is named ultradrv
> instead of ultracam), I get a smaller black screen and "error reading
> image. . ."

Check the dates, maybe in-kernel driver is more recent. Contact Karl.

> about things not working. I found no one that could give me any more
> advice on how to get this working for me. I get the same results when
> I'm using the camera from the ultraport or USB.

This is a rare camera, as I understand. Nobody else has it.

> hasciicam works, but that is useless to me as I need to use this with a
> webcam and several other v4l applications.  I have run out of places to
> look for information and clues, and I cannot find the author for the
> kernel driver (not listed in the code, or the maintainers file).

Karl Gutwin. His email is at the URL that I gave above.

> seems to me that *someone* must have gotten this running, but they seem
> to want to keep that info to themselves?

If there is that mysterious "someone", it is not anyone I know. As I
said, virtually nobody has the device. I don't even know how the driver
was developed in first place, using specs, reverse engineering or just
black magic...

Dmitri


