Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264079AbRFNVgw>; Thu, 14 Jun 2001 17:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264081AbRFNVgp>; Thu, 14 Jun 2001 17:36:45 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:50445 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264079AbRFNVgd>; Thu, 14 Jun 2001 17:36:33 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [PATCH 2.4.5-ac12] New Sony Vaio Motion Eye camera driver
Date: 14 Jun 2001 14:36:09 -0700
Organization: A poorly-installed InterNetNews site
Message-ID: <9gbao9$55e$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.31.0106121549130.4477-100000@penguin.transmeta.com> <E15A7os-0003e9-00@come.alcove-fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E15A7os-0003e9-00@come.alcove-fr>,
Stelian Pop  <stelian@alcove.fr> wrote:
>
>Well, not quite... I've had several X lockups while using the YUV 
>acceleration code. Let's say one lockup per half an hour.

Strange. I've watched DVD's etc. Maybe it's not the Xv code, but your
camera code?

>Even the performances are controversial: with 320x240, I achieve 
>great performance with xawtv/meye driver, I can even use the hardware
>scaling facilities (well, the xawtv sources need a little hacking for
>that), but in 640x480 the framerate achieved with Xv is below the
>one I get by converting YUV->RGB in software...

There's something wrong with your setup. I watch full-screen DVD's on my
VAIO. It's not really fast enough with just the YUV conversion done in
hardware (it's plenty fast enough if MC and iDCT would be done in HW
too, but ATI doesn't release docs without strict NDA's). But there's no
way DVD's are watchable with sw YUV conversion and scaling.

>But the main question remains: does the MotionEye camera support
>overlay or not ? 

That one I have no clue about at all.

			Linus
