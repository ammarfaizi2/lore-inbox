Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264164AbUDTW1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264164AbUDTW1t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 18:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264535AbUDTW0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 18:26:22 -0400
Received: from twin.uoregon.edu ([128.223.214.27]:42886 "EHLO twin.uoregon.edu")
	by vger.kernel.org with ESMTP id S264164AbUDTT2K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 15:28:10 -0400
Date: Tue, 20 Apr 2004 12:28:08 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Timothy Miller <miller@techsource.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: System hang with ATI's lousy driver
In-Reply-To: <4085753B.2010700@techsource.com>
Message-ID: <Pine.LNX.4.44.0404201216280.10469-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Apr 2004, Timothy Miller wrote:

> 
> 
> Joel Jaeggli wrote:
> > On Tue, 20 Apr 2004, Timothy Miller wrote:
> > 
> > 
> >>So, since XFree86's lousy open-source Radeon driver won't do OpenGL 
> >>right, I am forced to use ATI's lousy proprietary Radeon driver.  With 
> >>that, I can do OpenGL right, but when I exit the X server, the system 
> >>hangs completely.  I get lots of vertical lines on the screen, but I 
> >>can't even ping the computer.
> > 
> > 
> > you didn't specify which ati card?
> 
> Sorry.  Radeon 9000 Pro.

kernel drm + xfree86 driver will actually provide accelerated opengl 
support in Xwindows albiet without quite as many hardware features as the 
proprietary driver on all the rv2xx chipsets including the 9000 but not 
on the later models. 

kernel drm & radeonfb have been reported to not play very well with each 
other in other venues. vesafb is known to work in this situation though.
 
> >  
> > 
> >>Does anyone know of any conflict between using ATI's X11 driver and the 
> >>Radeon console driver at the same time?
> >>
> >>I'm using kernel gentoo-2.4.25.
> >>
> >>
> >>I'm getting really sick of not being able to get new graphics cards to 
> >>just work properly under Linux.
> >>
> >>
> >>Thanks.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli  	       Unix Consulting 	       joelja@darkwing.uoregon.edu    
GPG Key Fingerprint:     5C6E 0104 BAF0 40B0 5BD3 C38B F000 35AB B67F 56B2


