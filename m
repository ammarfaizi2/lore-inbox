Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262957AbUBZTqg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 14:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262943AbUBZTqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 14:46:35 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:53773 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262957AbUBZTpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 14:45:50 -0500
Date: Thu, 26 Feb 2004 19:45:47 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Otto Solares <solca@guug.org>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] fbdv/fbcon pending problems
In-Reply-To: <20040226194020.GF17390@guug.org>
Message-ID: <Pine.LNX.4.44.0402261941520.20525-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Exactly, that's the whole point, if you want userland accel you must disable
> kernel land accel.  That's was my question against acceleration work inside
> the kernel.  Nobody use it in userland and is the stability devil in fbdev.
> If you want acceleration in userland there is mesa-solo or directfb or console-sdl.
> 
> In short acceleration belongs to specialized libs not the kernel.
> 
> Why accel it is needed for font drawing?, i am pretty sure my 8bit video old
> sparc doesn't have any accel and is pretty capable for drawing fonts.

Because we are going to run into graphics hardware that don't have 
framebuffers. The solution is the one we are approaching now. That fbcon 
be a client like userland apps to the accel engine. You will see it will 
all work out :-)

