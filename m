Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbWGDSGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWGDSGu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 14:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWGDSGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 14:06:50 -0400
Received: from ara.aytolacoruna.es ([195.55.102.196]:8643 "EHLO
	mx.aytolacoruna.es") by vger.kernel.org with ESMTP id S932293AbWGDSGt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 14:06:49 -0400
Date: Tue, 4 Jul 2006 20:06:42 +0200
From: Santiago Garcia Mantinan <manty@manty.net>
To: Andrew Morton <akpm@osdl.org>
Cc: tiwai@suse.de, linux-kernel@vger.kernel.org
Subject: Re: awe64 isa pnp ALSA problems since 2.6.17
Message-ID: <20060704180642.GA2383@pul.manty.net>
References: <20060630205703.GA2840@pul.manty.net> <s5hd5cmtx61.wl%tiwai@suse.de> <20060703223128.GA2423@pul.manty.net> <20060703175032.843ed1fb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060703175032.843ed1fb.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This has been addressed in Linus's current tree, via:
> 
>                 if (request_irq(*irq, pnp_test_handler,
>                                 IRQF_DISABLED|IRQF_PROBE_SHARED, "pnp", NULL))
> 
> in drivers/pnp/resource.c.

Sorry, I missed your message, I have picked the patch from git and works as
expected.

I still have the audio problems with skype when using the oss interface, but
I have not been able to reproduce them with any other program, I guess this
could be either the alsa drivers (I tested 1.0.12rc1 but the result was the
same as with 1.0.11rc4 from 2.6.17) or even the libs (I'm using debian's sid
1.0.11-7), even though the problem happens when I use 2.6.17 and doesn't
happen if I use 2.6.16.

Thanks for your help.

Regards...
-- 
Manty/BestiaTester -> http://manty.net
