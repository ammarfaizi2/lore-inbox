Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137039AbREKClJ>; Thu, 10 May 2001 22:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137040AbREKClF>; Thu, 10 May 2001 22:41:05 -0400
Received: from [206.14.214.140] ([206.14.214.140]:51474 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S137039AbREKCkh>; Thu, 10 May 2001 22:40:37 -0400
Date: Thu, 10 May 2001 19:40:00 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Sean Swallow <sean@swallow.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: Riva console frame buffer
In-Reply-To: <Pine.LNX.4.33.0105101813220.1140-100000@lsd.nurk.org>
Message-ID: <Pine.LNX.4.10.10105101936330.30870-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Right now when I bootup it's in 640x480, and I change it to 1024x768 @70Hz
> w/ fbset in /etc/rc.local . I would like to give the kernel an arg to
> startup in 1024x768; eg video=riva:mode:1024x768-70,ypan,vc:1-8
> 
> Is there a way to do this w/ the riva frame buffer? Is there a list of
> kernel args for the riva frame buffer?

Yes. Most fbdev drivers use modedb which provides a standard easy way to
select a video resolution. 

    video=riva:<xres>x<yres>[-<bpp>][@refresh]


