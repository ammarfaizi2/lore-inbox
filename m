Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261747AbSJQRXn>; Thu, 17 Oct 2002 13:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261588AbSJQRXb>; Thu, 17 Oct 2002 13:23:31 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64011 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261747AbSJQRWC>; Thu, 17 Oct 2002 13:22:02 -0400
Date: Thu, 17 Oct 2002 18:27:56 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [ANNOUCE] fbdev changes finished.
Message-ID: <20021017182756.B3326@flint.arm.linux.org.uk>
References: <Pine.LNX.4.33.0210170919210.4730-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0210170919210.4730-100000@maxwell.earthlink.net>; from jsimmons@infradead.org on Thu, Oct 17, 2002 at 09:38:37AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 09:38:37AM -0700, James Simmons wrote:
>   I like to annouce that I just finished the final fbdev changes. They are
> in the BK repository bk://fbdev.bkbits.net/fbdev-2.5. The changes are
> 
> 1) Removal of all console related code in the lower level drivers. Smaller
>    easier to program drivers.
> 
> 2) Now you can use the framebuffer driver WITHOUT framebuffer console.
>    Last night I built a kernel with MDA console and used the VESA
>    framebuffer by itself. Now you can easily debug new framebuffer
>    drivers. The real bonus is for embedded systems you have much smaller
>    kernels.
> 
> 3) I moved the agp and drm code into drivers/video. I did NOT place any
>    drm code with framebuffer code at people's request. I simiple moved the
>    directory from one spot to another. The main reason I did this was
>    because some framebuffer drivers will need to use the agp code initialized
>    before the framebuffer layer. The DRM code was moved because it makes
>    sense to move it there.
> 
> 4) I cleaned up the config.in for all the video stuff across all
>    platforms.
> 
> You can grab the lastest BK tree at
> 
> bk://fbdev.bkbits.net/fbdev-2.5
> 
> Give it a try. For people who want a diff it is avaiable at
> 
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

... which is not representative of the changes.

Can you _please_ take much more care over patches and such like and take
the time to get them correct _please_.

I really don't like patches that float around that unintentionally delete
other peoples drivers for no reason.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

