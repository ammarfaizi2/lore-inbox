Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261351AbTC0U44>; Thu, 27 Mar 2003 15:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261372AbTC0U44>; Thu, 27 Mar 2003 15:56:56 -0500
Received: from pine.compass.com.ph ([202.70.96.37]:17157 "HELO
	pine.compass.com.ph") by vger.kernel.org with SMTP
	id <S261351AbTC0U4z>; Thu, 27 Mar 2003 15:56:55 -0500
Subject: Re: [Linux-fbdev-devel] Framebuffer fixes.
From: Antonino Daplas <adaplas@pol.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <Pine.GSO.4.21.0303272148280.7286-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0303272148280.7286-100000@vervain.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1048798158.1035.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 28 Mar 2003 04:49:34 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-28 at 04:49, Geert Uytterhoeven wrote:
> > > 
> > > Shouldn't these be info->var.bits_per_pixel instead of fb_logo.depth?
> > 
> > Yes, fb_logo.depth == info->var.bits_per_pixel.
> 
> Euh, now I get confused... Do you mean
> `Yes, it should be replaced by info->var.bits_per_pixel' or
> `No, logo.depth is always equal to info->var.bits_per_pixel'?

:)  Sorry about that. I meant:


`No, fb_logo.depth is always equal to info->var.bits_per_pixel'

Tony

