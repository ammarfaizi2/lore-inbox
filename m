Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264305AbUAIUHA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 15:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264583AbUAIUHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 15:07:00 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:62218 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264305AbUAIUGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 15:06:11 -0500
Date: Fri, 9 Jan 2004 20:06:06 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Kronos <kronos@kronoz.cjb.net>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] New FBDev patch
In-Reply-To: <20040109171733.GA13027@dreamland.darkstar.lan>
Message-ID: <Pine.LNX.4.44.0401092005410.27985-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> > http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
> 
> > <kronos@kronoz.cjb.net> (03/09/17 1.1267.40.1)
> >    Add new API framebuffer_alloc and framebuffer_release.
> >    
> >    Framebuffer info structure (ie. struct fb_info) must be obtained from
> >    framebuffer_alloc. When it is no longer needed (after unregister_framebuffer
> >    and clean up) it can be released using framebuffer_release.
> >    
> >    If the framebuffer is not registered yet (eg. on error path) then fb_info must
> >    be released via kfree. 
> 
> 
> Are we sure that we want this for 2.6? Greg KH has a much less intrusive
> patch, maybe you should take that instead and keep my work 2.7.
> 
> If you decide to go with framebuffer_alloc then I have more patches for
> you ;)

I have been using it for awhile on various cards. 


