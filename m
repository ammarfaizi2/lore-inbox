Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262834AbUBZUNH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 15:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262964AbUBZUNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 15:13:06 -0500
Received: from guug.galileo.edu ([168.234.203.30]:21384 "EHLO guug.galileo.edu")
	by vger.kernel.org with ESMTP id S262971AbUBZULy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 15:11:54 -0500
Date: Thu, 26 Feb 2004 14:12:16 -0600
To: James Simmons <jsimmons@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] fbdv/fbcon pending problems
Message-ID: <20040226201216.GH17390@guug.org>
References: <20040226194020.GF17390@guug.org> <Pine.LNX.4.44.0402261941520.20525-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0402261941520.20525-100000@phoenix.infradead.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Otto Solares <solca@guug.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 26, 2004 at 07:45:47PM +0000, James Simmons wrote:
> 
> > Exactly, that's the whole point, if you want userland accel you must disable
> > kernel land accel.  That's was my question against acceleration work inside
> > the kernel.  Nobody use it in userland and is the stability devil in fbdev.
> > If you want acceleration in userland there is mesa-solo or directfb or console-sdl.
> > 
> > In short acceleration belongs to specialized libs not the kernel.
> > 
> > Why accel it is needed for font drawing?, i am pretty sure my 8bit video old
> > sparc doesn't have any accel and is pretty capable for drawing fonts.
> 
> Because we are going to run into graphics hardware that don't have 
> framebuffers. The solution is the one we are approaching now. That fbcon 
> be a client like userland apps to the accel engine. You will see it will 
> all work out :-)

Oh, that fact changes everything :)

-otto

