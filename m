Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130532AbRDFCAh>; Thu, 5 Apr 2001 22:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130768AbRDFCAT>; Thu, 5 Apr 2001 22:00:19 -0400
Received: from adsl-63-194-96-244.dsl.snlo01.pacbell.net ([63.194.96.244]:61445
	"HELO alpha.dyndns.org") by vger.kernel.org with SMTP
	id <S130532AbRDFCAF>; Thu, 5 Apr 2001 22:00:05 -0400
Message-ID: <3ACD22E6.72143666@bigfoot.com>
Date: Thu, 05 Apr 2001 18:59:02 -0700
From: Mark McClelland <mmcclell@bigfoot.com>
X-Mailer: Mozilla 4.61 [en] (OS/2; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Erik Gustavsson <cyrano@algonet.se>, LKML <linux-kernel@vger.kernel.org>
CC: Thomas Speck <Thomas.Speck@univ-rennes1.fr>
Subject: Re: ov511 problem
In-Reply-To: <Pine.LNX.4.21.0104052311590.2324-100000@lillan>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ov511 supports compression, but it doesn't always work yet. Even with
compression, you will only get 12-15 FPS at 640x480 at most. USB just can't do
better than that with this type of compression algorithm.

If you want to try compression, use the "compress=1" and "ttpp=1" parameters
with the ov511 1.35 module. You will likely get garbage, but this will give you
an idea of what the frame rate will be like once I have it working.

Erik Gustavsson wrote:

> On Thu, 5 Apr 2001, Thomas Speck wrote:
>
> IIRC the driver doesn't support compression, and there is no way you can
> get 640x480 uncompressed at 30 fps over USB...
>
> > I am trying to get working a Spacec@m 300 (USB) by Trust. I tried this
> > under 2.2.18 and 2.4.3. In order to get the camera detected I can use the
> > usb-uhci or uhci module (the result is the same). The camera gets detected
> > (some OV7610 gets probed - I don't know if this is the correct one) and
> > after loading the ov511 module I get the picture of the camera displayed
> > with xawt-3.38 (resolution 640x480 - the camera is able to this).
> > The problem I am running into is that the framerate is extremely slow
> > (maybe 3 fps), however, from the specifications it should work with 30
> > fps. My system is a Pentium II with 300 Mhz. Some Miro TV card with a
> > BT848 chip works fine with the bttv driver.
> > Do you have any idea ?
> > If you need more info, just let me know. I am also willing to do some
> > tests...

--
Mark McClelland
mmcclell@bigfoot.com


