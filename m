Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWITXOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWITXOl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 19:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWITXOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 19:14:41 -0400
Received: from xenotime.net ([66.160.160.81]:9682 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750782AbWITXOk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 19:14:40 -0400
Date: Wed, 20 Sep 2006 16:15:46 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Reiner Herrmann <reiner@reiner-h.de>
Cc: adaplas@pol.net, kernel-janitors@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation fixes in intel810.txt
Message-Id: <20060920161546.7d009c9e.rdunlap@xenotime.net>
In-Reply-To: <200609210103.10768.reiner@reiner-h.de>
References: <200609210103.10768.reiner@reiner-h.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006 01:03:10 +0200 Reiner Herrmann wrote:

> some general documentation fixes and a lot of whitespace cleanup
> 
> Signed-off-by: Reiner Herrmann <reiner@reiner-h.de>
> ---
> diff -uprN -X linux-2.6.18/Documentation/dontdiff linux-2.6.18/Documentation/fb/intel810.txt linux-work/Documentation/fb/intel810.txt
> --- linux-2.6.18/Documentation/fb/intel810.txt	2006-09-20 05:42:06.000000000 +0200
> +++ linux-work/Documentation/fb/intel810.txt	2006-09-21 00:55:20.000000000 +0200
> @@ -9,8 +9,9 @@ Intel 810/815 Framebuffer driver
>  ================================================================
>  
>  A. Introduction
> +
>  	This is a framebuffer driver for various Intel 810/815 compatible
> -graphics devices.  These would include:
> +	graphics devices.  These would include:

Might as well drop "would" while you are here.

>  	Intel 810
>  	Intel 810E
> @@ -22,135 +23,135 @@ graphics devices.  These would include:
>  B.  Features
>  
>          - Choice of using Discrete Video Timings, VESA Generalized Timing
> -	  Formula, or a framebuffer specific database to set the video mode
> +	  Formula or a framebuffer specific database to set the video mode

There's nothing wrong with a comma after the next-to-last item of
3 or more items in a series (above and below).

> -	- Supports a variable range of horizontal and vertical resolution, and
> -	  vertical refresh rates if the VESA Generalized Timing Formula is 
> +	- Supports a variable range of horizontal and vertical resolution and
> +	  vertical refresh rates if the VESA Generalized Timing Formula is
>  	  enabled.
>  
>          - Supports color depths of 8, 16, 24 and 32 bits per pixel
>  
> -	- Supports pseudocolor, directcolor, or truecolor visuals
> +	- Supports pseudocolor, directcolor or truecolor visuals

Last comma was OK as is.

>          - Full and optimized hardware acceleration at 8, 16 and 24 bpp
>  
>  	- Robust video state save and restore
>  
> -        - MTRR support 
> +        - MTRR support
>  
>  	- Utilizes user-entered monitor specifications to automatically
>  	  calculate required video mode parameters.
>  
> -	- Can concurrently run with xfree86 running with native i810 drivers 
> +	- Can concurrently run with xfree86 running with native i810 drivers
>  
>  	- Hardware Cursor Support
>   
>  	- Supports EDID probing either by DDC/I2C or through the BIOS
>  
>  C.  List of available options
> -	
> -   a. "video=i810fb"  
> +
> +   a. "video=i810fb"
>  	enables the i810 driver
>  
>  	Recommendation: required
> - 
> -   b. "xres:<value>"  
> +
> +   b. "xres:<value>"
>  	select horizontal resolution in pixels. (This parameter will be
>  	ignored if 'mode_option' is specified.  See 'o' below).
>  
> -	Recommendation: user preference 
> +	Recommendation: user preference
>  	(default = 640)
>  
>     c. "yres:<value>"
>  	select vertical resolution in scanlines. If Discrete Video Timings
>  	is enabled, this will be ignored and computed as 3*xres/4.  (This
>  	parameter will be ignored if 'mode_option' is specified.  See 'o'
> -	below)  
> +	below)
>  
>  	Recommendation: user preference
>  	(default = 480)
> -		
> -   d. "vyres:<value>" 
> +
> +   d. "vyres:<value>"
>  	select virtual vertical resolution in scanlines. If (0) or none
> -	is specified, this will be computed against maximum available memory. 
> +	is specified, this will be computed against maximum available memory.
>  
>  	Recommendation: do not set
>  	(default = 480)
>  
>     e. "vram:<value>"
> -	select amount of system RAM in MB to allocate for the video memory 
> +	select amount of system RAM in MB to allocate for the video memory
>  
>  	Recommendation: 1 - 4 MB.
>  	(default = 4)
>  
> -   f. "bpp:<value>"   
> -	select desired pixel depth 
> +   f. "bpp:<value>"
> +	select desired pixel depth
>  
>  	Recommendation: 8
>  	(default = 8)
>  
> -   g. "hsync1/hsync2:<value>" 
> -	select the minimum and maximum Horizontal Sync Frequency of the 
> -	monitor in KHz.  If a using a fixed frequency monitor, hsync1 must 
> +   g. "hsync1/hsync2:<value>"
> +	select the minimum and maximum Horizontal Sync Frequency of the
> +	monitor in kHz.  If using a fixed frequency monitor, hsync1 must

Why small 'k'?  Is that some standard?
I prefer KHz but I'm flexible.

>  	be equal to hsync2. If EDID probing is successful, these will be
>  	ignored and values will be taken from the EDID block.
>  
>  	Recommendation: check monitor manual for correct values
> -	default (29/30)
> +	(default = 29/30)
>  
> -   h. "vsync1/vsync2:<value>" 
> +   h. "vsync1/vsync2:<value>"
>  	select the minimum and maximum Vertical Sync Frequency of the monitor
> -	in Hz. You can also use this option to lock your monitor's refresh 
> +	in Hz. You can also use this option to lock your monitor's refresh
>  	rate. If EDID probing is successful, these will be ignored and values
>  	will be taken from the EDID block.
>  
>  	Recommendation: check monitor manual for correct values
>  	(default = 60/60)
>  
> -	IMPORTANT:  If you need to clamp your timings, try to give some 
> -	leeway for computational errors (over/underflows).  Example: if 
> +	IMPORTANT:  If you need to clamp your timings, try to give some
> +	leeway for computational errors (over/underflows).  Example: if
>  	using vsync1/vsync2 = 60/60, make sure hsync1/hsync2 has at least
>  	a 1 unit difference, and vice versa.
>  
> -   i. "voffset:<value>"	
> -        select at what offset in MB of the logical memory to allocate the 
> +   i. "voffset:<value>"
> +        select at what offset in MB of the logical memory to allocate the

Indentation is funky here...

>  	framebuffer memory.  The intent is to avoid the memory blocks
>  	used by standard graphics applications (XFree86).  The default
>          offset (16 MB for a 64MB aperture, 8 MB for a 32MB aperture) will
>          avoid XFree86's usage and allows up to 7MB/15MB of framebuffer
> -        memory.  Depending on your usage, adjust the value up or down, 
> -	(0 for maximum usage, 31/63 MB for the least amount).  Note, an 
> +        memory.  Depending on your usage, adjust the value up or down,
> +	(0 for maximum usage, 31/63 MB for the least amount).  Note, an
>  	arbitrary setting may conflict with XFree86.
>  
>  	Recommendation: do not set
>  	(default = 8 or 16 MB)
> -      
> -   j. "accel" 
> -	enable text acceleration.  This can be enabled/reenabled anytime 
> -	by using 'fbset -accel true/false'. 
> +
> +   j. "accel"
> +	enable text acceleration.  This can be enabled/reenabled anytime
> +	by using 'fbset -accel true/false'.
>  
>  	Recommendation: enable
> -	(default = not set) 
> +	(default = not set)
>  
> -   k. "mtrr" 
> +   k. "mtrr"
>  	enable MTRR.  This allows data transfers to the framebuffer memory
>  	to occur in bursts which can significantly increase performance.
> -	Not very helpful with the i810/i815 because of 'shared memory'. 
> +	Not very helpful with the i810/i815 because of 'shared memory'.
>  
>  	Recommendation: do not set
> -	(default = not set) 
> +	(default = not set)
>  
>     l. "extvga"
>  	if specified, secondary/external VGA output will always be enabled.
>  	Useful if the BIOS turns off the VGA port when no monitor is attached.
> -	The external VGA monitor can then be attached without rebooting. 
> +	The external VGA monitor can then be attached without rebooting.
>  
>  	Recommendation: do not set
>  	(default = not set)
> -	
> -   m. "sync" 
> +
> +   m. "sync"
>  	Forces the hardware engine to do a "sync" or wait for the hardware
> -	to finish before starting another instruction. This will produce a 
> +	to finish before starting another instruction. This will produce a
>  	more stable setup, but will be slower.
>  
>  	Recommendation: do not set
> @@ -162,6 +163,7 @@ C.  List of available options
>  
>  	Recommendation: do not set
>  	(default = not set)
> +
>     o. <xres>x<yres>[-<bpp>][@<refresh>]
>  	The driver will now accept specification of boot mode option.  If this
>  	is specified, the options 'xres' and 'yres' will be ignored. See
> @@ -183,8 +185,8 @@ append="video=i810fb:vram:2,xres:1024,yr
>          vsync1:50,vsync2:85,accel,mtrr"
>  
>  This will initialize the framebuffer to 1024x768 at 8bpp.  The framebuffer
> -will use 2 MB of System RAM. MTRR support will be enabled. The refresh rate 
> -will be computed based on the hsync1/hsync2 and vsync1/vsync2 values.  
> +will use 2 MB of System RAM. MTRR support will be enabled. The refresh rate
> +will be computed based on the hsync1/hsync2 and vsync1/vsync2 values.
>  
>  IMPORTANT:
>  You must include hsync1, hsync2, vsync1 and vsync2 to enable video modes
> @@ -194,10 +196,10 @@ vsync1 and vsync2 parameters.  These par
>  block.
>  
>  E.  Module options
> -	
> -	The module parameters are essentially similar to the kernel 
> -parameters. The main difference is that you need to include a Boolean value 
> -(1 for TRUE, and 0 for FALSE) for those options which don't need a value. 
> +
> +The module parameters are essentially similar to the kernel
> +parameters. The main difference is that you need to include a Boolean value
> +(1 for TRUE, and 0 for FALSE) for those options which don't need a value.
>  
>  Example, to enable MTRR, include "mtrr=1".
>  
> @@ -214,62 +216,62 @@ Or just add the following to /etc/modpro
>  	options i810fb vram=2 xres=1024 bpp=16 hsync1=30 hsync2=55 vsync1=50 \
>  	vsync2=85 accel=1 mtrr=1
>  
> -and just do a 
> +and just do a
>  
>  	modprobe i810fb
>  
>  
>  F.  Setup
>  
> -	a. Do your usual method of configuring the kernel. 
> -	
> +	a. Do your usual method of configuring the kernel.
> +
>  	make menuconfig/xconfig/config
>  
> -	b. Under "Code Maturity Options", enable "Prompt for experimental/
> -	   incomplete code/drivers".
> +	b. Under "Code maturity level options" enable "Prompt for development
> +	   and/or incomplete code/drivers".
>  
>   	c. Enable agpgart support for the Intel 810/815 on-board graphics.
>  	   This is required.  The option is under "Character Devices"

Add period (full stop) above.

>  	d. Under "Graphics Support", select "Intel 810/815" either statically
>  	   or as a module.  Choose "use VESA Generalized Timing Formula" if
> -	   you need to maximize the capability of your display.  To be on the 
> -	   safe side, you can leave this unselected.  
> -  
> +	   you need to maximize the capability of your display.  To be on the
> +	   safe side, you can leave this unselected.
> +
>  	e. If you want support for DDC/I2C probing (Plug and Play Displays),
>  	   set 'Enable DDC Support' to 'y'. To make this option appear, set
>  	   'use VESA Generalized Timing Formula' to 'y'.
>  
> -        f. If you want a framebuffer console, enable it under "Console 
> +        f. If you want a framebuffer console, enable it under "Console
>  	   Drivers"

End above with '.'.

> -	g. Compile your kernel. 
> -	  	
> +	g. Compile your kernel.
> +
>  	h. Load the driver as described in section D and E.

"sections" ?

> -	
> +
>  	i.  Try the DirectFB (http://www.directfb.org) + the i810 gfxdriver
>  	    patch to see the chipset in action (or inaction :-).
>  
>  G.  Acknowledgment:
> -	
> +
>  	1.  Geert Uytterhoeven - his excellent howto and the virtual
> -                                 framebuffer driver code made this possible.
> +	    framebuffer driver code made this possible.
>  
> -	2.  Jeff Hartmann for his agpgart code.  
> +	2.  Jeff Hartmann for his agpgart code.
>  
>  	3.  The X developers.  Insights were provided just by reading the
>  	    XFree86 source code.
>  
>  	4.  Intel(c).  For this value-oriented chipset driver and for
> -            providing documentation.
> +	    providing documentation.
>  
>  	5. Matt Sottek.  His inputs and ideas  helped in making some
> -	optimizations possible.
> +	   optimizations possible.
>  
>  H.  Home Page:
>  
>  	A more complete, and probably updated information is provided at
> -http://i810fb.sourceforge.net.
> +	http://i810fb.sourceforge.net.
>  
>  ###########################
>  Tony


---
~Randy
