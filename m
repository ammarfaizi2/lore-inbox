Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264062AbTDOUIY (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 16:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264065AbTDOUIY 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 16:08:24 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:8967 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264062AbTDOUIW (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 16:08:22 -0400
Date: Tue, 15 Apr 2003 21:20:12 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Sean Estabrooks <seanlkml@rogers.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: FBCON - vesa graphics modes no longer work on Toshiba Laptop
In-Reply-To: <1050336424.32705.31.camel@linux1.classroom.com>
Message-ID: <Pine.LNX.4.44.0304152119300.8236-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> S3 Inc. 86C270-294 Savage/IX-MV (rev 11) 
> 
> 2.4.20 kernel works well with vga=0x305 and uses the entire LCD panel.
> 
> 2.5.67 kernel with vga=0x305 sets a graphic mode that only uses the
> inner 640x480 set of pixels and the display is just a jumbled mess.  
> 
> I did try the latest fb patch and the problem remains.  Also found a
> note that said to try "video=vesa:ywrap,pmipal,mtrr" and this didn't
> work either.
> 
> Regards,
> Sean

Try disabling CONFIG_VGA_CONSOLE. Tell me if this fixes all your problems.

> CONFIG_VGA_CONSOLE=y
> # CONFIG_MDA_CONSOLE is not set
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_FRAMEBUFFER_CONSOLE=y
> CONFIG_PCI_CONSOLE=y
> CONFIG_FONTS=y
> CONFIG_FONT_8x8=y
> CONFIG_FONT_8x16=y
> CONFIG_FONT_6x11=y
> CONFIG_FONT_PEARL_8x8=y
> CONFIG_FONT_ACORN_8x8=y
> CONFIG_FONT_MINI_4x6=y
> CONFIG_FONT_SUN8x16=y
> CONFIG_FONT_SUN12x22=y

