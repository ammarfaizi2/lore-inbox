Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262820AbVCPV70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262820AbVCPV70 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 16:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbVCPV5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 16:57:32 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:61401 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262820AbVCPVw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 16:52:56 -0500
Date: Wed, 16 Mar 2005 21:52:52 +0000 (GMT)
From: James Simmons <jsimmons@www.infradead.org>
X-X-Sender: jsimmons@pentafluge.infradead.org
To: Matthew Wilcox <matthew@wil.cx>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CON_BOOT
In-Reply-To: <20050316211755.GS21986@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.56.0503162152110.30645@pentafluge.infradead.org>
References: <20050315222706.GI21986@parcelfarce.linux.theplanet.co.uk>
 <20050315143711.4ae21d88.akpm@osdl.org> <20050316130759.GL21986@parcelfarce.linux.theplanet.co.uk>
 <20050316130948.678ca2f2.akpm@osdl.org> <20050316211755.GS21986@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You're spot on, we get no info.  That's why there's a bunch of kludges
> around, mostly called early_printk.  But most people use x86 and they
> get console output sufficiently early anyway because they know their
> serial port is at 0x3f8 ...
> 
> I just realised that with CON_BOOT, we could actually get rid of the
> __con_initcall loop in tty_io.c and let all the horrible early serial
> console stuff disappear.
> 
> This console stuff really needs a dedicated maintainer ... wonder if
> we can find a sucker ...

I like ot tackle those problems. The only thing is I'm busy handling the 
fbdev fixes.

