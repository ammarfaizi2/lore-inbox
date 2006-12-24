Return-Path: <linux-kernel-owner+w=401wt.eu-S1754119AbWLXGFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754119AbWLXGFu (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 01:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754134AbWLXGFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 01:05:50 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4289 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754119AbWLXGFu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 01:05:50 -0500
Date: Sun, 24 Dec 2006 07:05:50 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Steve French <smfltc@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dmitry Torokhov <dtor@mail.ru>
Subject: Re: 2.6.19-rc1 build problem
Message-ID: <20061224060550.GA12251@stusta.de>
References: <458D8E38.4090303@us.ibm.com> <20061223150715.422c655b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061223150715.422c655b.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 23, 2006 at 03:07:15PM -0800, Andrew Morton wrote:
> On Sat, 23 Dec 2006 14:14:48 -0600
> Steve French <smfltc@us.ibm.com> wrote:
> 
> > Is this a know problem with very current 2.6.19-rc?
> > 
> > Building modules, stage 2.
> > MODPOST 443 modules
> > WARNING: "bitrev32" [drivers/net/8139cp.ko] undefined!
> 
> You'll need to set CONFIG_BITREVERSE.  Somehow.  This is going to cause
> problems and I suspect we'll end up giving up in horror and just adding it
> to lib-y.
>...

Not lib-y but obj-y.

Adding it to lib-y would be a bug, and it would obviously not help with 
this problem.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

