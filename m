Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264990AbSLBUYR>; Mon, 2 Dec 2002 15:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264992AbSLBUYR>; Mon, 2 Dec 2002 15:24:17 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:12558 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264990AbSLBUYQ>; Mon, 2 Dec 2002 15:24:16 -0500
Date: Mon, 2 Dec 2002 20:31:23 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Antonino Daplas <adaplas@pol.net>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] FBDev: vga16fb port
In-Reply-To: <1038468176.1091.46.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0212022027510.18805-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Attached is a patch against 2.5.49 + James Simmons' latest fbdev.diff.
> 
> Added support for logo drawing.
> Fixed vga16fb_imageblit() limitation of 8-pixel wide bitmap blitting
> only.

Applied and tested :-=) The only weird thing is it drew the logo twice 
when I don't have a SMP laptop. It works other than that. 

P.S
  Things I like to get done for the vga16fb driver. 

  1) Its own read and write functions to fake a linear framebuffer.
  2) The ability to go back to vga text mode on close of /dev/fb. 
     Yes fbdev/fbcon supports that now. 
 

