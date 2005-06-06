Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261663AbVFFUJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbVFFUJy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 16:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbVFFUGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 16:06:33 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44222 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261651AbVFFUFa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 16:05:30 -0400
Date: Mon, 6 Jun 2005 22:05:12 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.12-rc6
Message-ID: <20050606200512.GF2230@elf.ucw.cz>
References: <Pine.LNX.4.58.0506061104190.1876@ppc970.osdl.org> <20050606192654.GA3155@elf.ucw.cz> <42A4AA01.90905@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A4AA01.90905@pobox.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >...perhaps shortlog script needs some updating?
> 
> 
> In git-whatchanged, you are listed as the author:
> 
> 
> >diff-tree c1e4c8d3ee3300f363a52fd4cf3d90fdf5098f5a (from 
> >8bd7f125e2f217c8aa3dff0
> >Author: Pavel Machek <pavel@suse.cz>
> >Date:   Fri May 27 12:53:03 2005 -0700
> >    
> >    [PATCH] fix jumpy mouse cursor on console
> >    
> >    Do not send empty events to gpm.  (Keyboards are assumed to have scroll
> >    wheel these days, that makes them part-mouse.  That means typing on
> >    keyboard generates empty mouse events).
> >    
> >    From: Dmitry Torokhov <dtor_core@ameritech.net>
> >    Signed-off-by: Pavel Machek <pavel@suse.cz>
> >    Signed-off-by: Andrew Morton <akpm@osdl.org>
> >    Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
> '^Author: ' is what git-shortlog looks at.

Linus, perhaps your scripts are doing something wrong? They should
have taken From in the description; or did I provide wrong changelog?

								Pavel 
