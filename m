Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267364AbSLERXy>; Thu, 5 Dec 2002 12:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267363AbSLERXy>; Thu, 5 Dec 2002 12:23:54 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:53522 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267359AbSLERXw>; Thu, 5 Dec 2002 12:23:52 -0500
Date: Thu, 5 Dec 2002 17:31:20 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Antonino Daplas <adaplas@pol.net>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH 1/3: FBDEV: VGA State Save/Restore
 module
In-Reply-To: <1039017469.1013.30.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0212051729230.31967-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Limitations:
> 1.  Restoring the VGA state from high-resolution graphics mode may
> result in a corrupt display which can be corrected by switching
> consoles.  May need a screen redraw at this point.  Restoring from VGA
> graphics mode to text mode and vice versa is okay.
> 
> 2. Assumes some things about the hardware which is not universally
> correct:  VGA memory base is at 0xA0000, memory size is 64KB, the
> hardware palette is readable, etc. 
> 
> Any comments welcome.

One thing I like to suggest. I like to move the vga code in fb.h to vga.h. 
Alot of fbdev devices don't have a VGA core. 


