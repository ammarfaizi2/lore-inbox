Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263211AbUD0ErS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263211AbUD0ErS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 00:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263128AbUD0ErS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 00:47:18 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:16906 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S263211AbUD0ErM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 00:47:12 -0400
Date: Tue, 27 Apr 2004 12:52:41 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: raven@wombat.indigo.net.au
To: Paul Jackson <pj@sgi.com>
cc: davem@redhat.com, anton@samba.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: sparc64 2.6.6-rc2-mm2 build busted: usb/core/hub.c hubstatus
In-Reply-To: <20040426204947.797bd7c2.pj@sgi.com>
Message-ID: <Pine.LNX.4.58.0404271248250.8094@wombat.indigo.net.au>
References: <20040426204947.797bd7c2.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.5, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT, REFERENCES,
	REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Apr 2004, Paul Jackson wrote:

> Trying to build sparc64 as of 2.6.6-rc2-mm2, using the cross_compile
> tools from http://developer.osdl.org/dev/plm/cross_compile/ (nice
> tools - thanks!) fails for two reasons:
> 
> 1) Broken drivers/char/drm/ffb_drv.c:
> 
>       CC [M]  drivers/char/drm/ffb_drv.o
>     In file included from drivers/char/drm/ffb_drv.c:336:
>     drivers/char/drm/drm_drv.h:547: error: `ffb_PCI_IDS' undeclared here (not in a function)
>     drivers/char/drm/drm_drv.h:547: error: initializer element is not constant
>     drivers/char/drm/drm_drv.h:547: error: (near initialization for `ffb_pciidlist[0]')
>     drivers/char/drm/ffb_drv.c:225: warning: `ffb_count_card_instances' defined but not used
>     make[3]: *** [drivers/char/drm/ffb_drv.o] Error 1
> 
>    Andrew already reported this last week - something about missing PCI ID's.
> 

Yes and X didn't actually work when I got over that.

I'll test my build ASAP on rc2-mm2 and report results.

Ian

