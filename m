Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbWDJIwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbWDJIwh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 04:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbWDJIwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 04:52:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15559 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750903AbWDJIwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 04:52:36 -0400
Date: Mon, 10 Apr 2006 00:51:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: Re: [PATCH 0/19] kconfig patches
Message-Id: <20060410005153.2a5c19e2.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604101035240.32445@scrub.home>
References: <Pine.LNX.4.64.0604091628240.21970@scrub.home>
	<20060409235548.52b563a9.akpm@osdl.org>
	<Pine.LNX.4.64.0604101035240.32445@scrub.home>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel <zippel@linux-m68k.org> wrote:
>
> Hi,
> 
> On Sun, 9 Apr 2006, Andrew Morton wrote:
> 
> > > Andrew, what might be very interesting for you is that kconfig is not 
> > >  rewriting .config anymore all the time by itself and if you set 
> > >  KCONFIG_NOSILENTUPDATE you can even omit the silent updates, so unless you 
> > >  explicitly call one of the config targets, you can be sure kbuild won't 
> > >  touch your .config symlink anymore and as long as the .config is in sync 
> > >  with the Kconfig files you shouldn't see a difference. I'm very interested 
> > >  how that works for you.
> > 
> > Badly, sorry.  `make oldconfig' blows away the .config symlink.
> 
> I know, that's why I said "unless you explicitly call one of the config 
> targets",

I know that's why you said that ;)

> If you call "make oldconfig", you have to restore the symlink manually.

Why?  What advantage does that have?

I've been using the copy-it-there approach for maybe four years and have
yet to notice any problem with it.

