Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263574AbTKQTRd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 14:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263586AbTKQTRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 14:17:32 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:18345 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S263574AbTKQTRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 14:17:31 -0500
Date: Mon, 17 Nov 2003 13:38:05 -0500
From: Ben Collins <bcollins@debian.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [FBDEV UPDATE] Newer patch.
Message-ID: <20031117183805.GB476@phunnypharm.org>
References: <20031023234552.GB554@phunnypharm.org> <Pine.LNX.4.44.0310301833140.4560-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310301833140.4560-100000@phoenix.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 30, 2003 at 06:38:46PM +0000, James Simmons wrote:
> 
> > I noticed one thing, and that is that the mach64 used to use software
> > cursor it seems (I remember wondering why atyfb_cursor was never used
> > anywhere). It's now using the hw cursor.
> 
> Yeap. I'm in the process of getting several driver to use there hardware 
> cursors.
>  
> > Also, I notice with this new code that the random vertical shifting of
> > the console doesn't occur anymore like it does with current 2.6.0-test8
> > code. For as long as I can remember 2.6.0-test, and way back into
> > 2.5.5x, this has been a problem with highly active console programs
> > (mutt, vim, etc...). Good to see it's going away :)
> 
> :-)
> 
> I have fixed the problems you have reported. I have a newer patch. Note 
> this is updated with the LCD support. I like to see if the patch works on 
> sparc. I has updates from the latest 2.4.X kernels. Please give it a try.
> 
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
> 
> Let me know the results.

FYI, this new code is working for me on my Blade100. The cursor is much
better now.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
