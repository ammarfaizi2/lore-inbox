Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263228AbUAIRRV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 12:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263260AbUAIRRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 12:17:21 -0500
Received: from iron-c-1.tiscali.it ([212.123.84.81]:12577 "EHLO
	mailr-1.tiscali.it") by vger.kernel.org with ESMTP id S263228AbUAIRRS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 12:17:18 -0500
Date: Fri, 9 Jan 2004 18:17:33 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] New FBDev patch
Message-ID: <20040109171733.GA13027@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <Pine.LNX.4.44.0401082108080.12797-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401082108080.12797-100000@phoenix.infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Thu, Jan 08, 2004 at 10:03:54PM +0000, James Simmons ha scritto: 
> 
> This is the latest patch against 2.6.0-rc3. Give it a try.
> 
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

> <kronos@kronoz.cjb.net> (03/09/17 1.1267.40.1)
>    Add new API framebuffer_alloc and framebuffer_release.
>    
>    Framebuffer info structure (ie. struct fb_info) must be obtained from
>    framebuffer_alloc. When it is no longer needed (after unregister_framebuffer
>    and clean up) it can be released using framebuffer_release.
>    
>    If the framebuffer is not registered yet (eg. on error path) then fb_info must
>    be released via kfree. 


Are we sure that we want this for 2.6? Greg KH has a much less intrusive
patch, maybe you should take that instead and keep my work 2.7.

If you decide to go with framebuffer_alloc then I have more patches for
you ;)

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
I went to God just to see
And I was looking at me
Saw heaven and hell were lies
When I'm God everyone dies
