Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262772AbVG3EDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbVG3EDx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 00:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262822AbVG3EDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 00:03:53 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:2256 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262772AbVG3EDw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 00:03:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BGF2RyQ3Sn1I2UhZD0Is5PtvnGsXw0HQcMW9/7S58PRsinmPFDmn1V4nYS01m3OM9GFta02Wl9eh6t7xQw1qpuvz8GMPCTLlr5FGCKrymE1bVTk5wjp6INhkaIOWOKQoiPQQhGlTduqXZs5Yo9Kn+UphDYdBF2sP/tg9AWpbGX8=
Message-ID: <21d7e997050729210379e221c3@mail.gmail.com>
Date: Sat, 30 Jul 2005 14:03:52 +1000
From: Dave Airlie <airlied@gmail.com>
To: Ed Tomlinson <tomlins@cam.org>
Subject: Re: 2.6.13-rc3-mm2/mm1 breaks DRI
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200507290652.44418.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050727024330.78ee32c2.akpm@osdl.org>
	 <200507282037.52292.tomlins@cam.org>
	 <21d7e9970507281741fb51c98@mail.gmail.com>
	 <200507290652.44418.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay I'm still having trouble from reading back these e-mails on what
is broken and what isn't..

The most important question is if mainline 2.6.13-rc3 or -rc4 is okay?

If so then it is the -mm only that breaks  it, if -mm only can you 

modprobe drm debug=1
modprobe radeon

then start X and send me the log... try commenting out the in
radeon_drv.c line 79,
.presetup = radeon_presetup

to see if it makes it okay...

I've just booted 32-bit debian-stable and it works okay for me ..

Dave.
