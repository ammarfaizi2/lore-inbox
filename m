Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261719AbVDENRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbVDENRv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 09:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbVDENRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 09:17:51 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:23664 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261719AbVDENRt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 09:17:49 -0400
Date: Tue, 5 Apr 2005 15:19:25 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Ryan Anderson <ryan@michonline.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] Makefile: fix spaces instead of tab
Message-ID: <20050405131925.GA8100@mars.ravnborg.org>
References: <20050405000524.592fc125.akpm@osdl.org> <20050405122157.GC6885@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050405122157.GC6885@stusta.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 02:21:57PM +0200, Adrian Bunk wrote:
> GNU Emacs correctly complains because of spaces instead of a tab.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.12-rc2-mm1-full/Makefile.old	2005-04-05 14:00:06.000000000 +0200
> +++ linux-2.6.12-rc2-mm1-full/Makefile	2005-04-05 14:00:16.000000000 +0200
> @@ -577,7 +577,7 @@
>  
>  ifdef CONFIG_LOCALVERSION_AUTO
>  	localversion-auto := \
> -        	$(shell $(PERL) $(srctree)/scripts/setlocalversion $(srctree))
> +		$(shell $(PERL) $(srctree)/scripts/setlocalversion $(srctree))
>  	LOCALVERSION := $(LOCALVERSION)$(localversion-auto)
>  endif

In this case it makes sense - thanks.

	Sam
