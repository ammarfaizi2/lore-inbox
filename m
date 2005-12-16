Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbVLPU2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbVLPU2c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 15:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbVLPU2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 15:28:32 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:7982 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S1751347AbVLPU2b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 15:28:31 -0500
Date: Fri, 16 Dec 2005 21:29:24 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Petr Baudis <pasky@suse.cz>, linux-kernel@vger.kernel.org,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: [PATCH 3/3] [kconfig] Direct use of lxdialog routines by menuconfig
Message-ID: <20051216202923.GA8687@mars.ravnborg.org>
References: <20051212004159.31263.89669.stgit@machine.or.cz> <20051212004606.31263.37616.stgit@machine.or.cz> <Pine.LNX.4.61.0512142155220.1609@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0512142155220.1609@scrub.home>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 11:18:32PM +0100, Roman Zippel wrote:
> 
> > Compared to the previous version (from February 2003), this one should be
> > less buggy (especially wrt. the escape character handling), should not
> > crash while resizing and the resizing should have immediate effect
> > (although things can still start looking ugly when you are resizing while
> > not in a menu - to fix that properly, more liblxdialog integration is
> > required). Also, the code is considerably simplified on few places.
> 
> The <esc><esc> as described in mconf.c still produces two exits, which is 
> a little annoying if one is used to it. I don't know how easy it is to 
> supress that second <esc>.
The <esc><esc> behaviour is just illogical and to let it die cannot
hurt much. We create a more logical interface but yes, some users will
be irritated only due to the change.

	Sam
