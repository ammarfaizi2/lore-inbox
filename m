Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262945AbUCRUg4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 15:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262943AbUCRUgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 15:36:55 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:28678 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262942AbUCRUgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 15:36:49 -0500
Date: Thu, 18 Mar 2004 20:36:38 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: James Simmons <jsimmons@infradead.org>
Cc: Ian Campbell <icampbell@arcom.com>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [PATCH] PXA255 LCD Driver
Message-ID: <20040318203638.A12978@flint.arm.linux.org.uk>
Mail-Followup-To: James Simmons <jsimmons@infradead.org>,
	Ian Campbell <icampbell@arcom.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
References: <1079525185.13373.143.camel@icampbell-debian> <Pine.LNX.4.44.0403171723330.15898-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0403171723330.15898-100000@phoenix.infradead.org>; from jsimmons@infradead.org on Wed, Mar 17, 2004 at 07:03:06PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2004 at 07:03:06PM +0000, James Simmons wrote:
> behavior is struct fb_monspecs. Take a look at it in fb.h. I'm interested 
> if I got all the needed data from the EDID about a display panel.

You're thinking too PC-centric.  You don't get EDID data with embedded
LCD panels.  Instead, you get timing information, number of pixels per
line, and other parameters either from a PDF or paper datasheet on the
device.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
