Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264125AbRFOVLR>; Fri, 15 Jun 2001 17:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264183AbRFOVLH>; Fri, 15 Jun 2001 17:11:07 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:63750 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S264125AbRFOVK7>;
	Fri, 15 Jun 2001 17:10:59 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.5-ac12] New Sony Vaio Motion Eye camera driver
In-Reply-To: <9gbao9$55e$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.31.0106121549130.4477-100000@penguin.transmeta.com> <E15A7os-0003e9-00@come.alcove-fr> <9gbao9$55e$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-Id: <E15B0rq-0005s3-00@smtp.alcove.fr>
From: Stelian Pop <stelian@fr.alcove.com>
Date: Fri, 15 Jun 2001 23:10:58 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In alcove.lists.linux.kernel, you wrote:

> >Well, not quite... I've had several X lockups while using the YUV 
> >acceleration code. Let's say one lockup per half an hour.
> 
> Strange. I've watched DVD's etc. Maybe it's not the Xv code, but your
> camera code?

It can be, of course. However I never experienced problems when 
using the 'regular' X server, but quite often when using the 
patched server from gatos.

And since the driver delivers YUV data in both cases, I see
no difference (from its point of vue) between the two uses.

> >Even the performances are controversial: with 320x240, I achieve 
> >great performance with xawtv/meye driver, I can even use the hardware
> >scaling facilities (well, the xawtv sources need a little hacking for
> >that), but in 640x480 the framerate achieved with Xv is below the
> >one I get by converting YUV->RGB in software...
> 
> There's something wrong with your setup. I watch full-screen DVD's on my
> VAIO. It's not really fast enough with just the YUV conversion done in
> hardware (it's plenty fast enough if MC and iDCT would be done in HW
> too, but ATI doesn't release docs without strict NDA's). But there's no
> way DVD's are watchable with sw YUV conversion and scaling.

I said that YUV conversion and scaling _do_ work in hardware. Actually,
using a capture size of 320x240 I can use those hardware features
and scale the image to full screen and I get all the 30 fps.

It seems however to work pretty bad in 640x480... but maybe it is
my setup here...

> >But the main question remains: does the MotionEye camera support
> >overlay or not ? 
> 
> That one I have no clue about at all.

Neither do I :-)

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
