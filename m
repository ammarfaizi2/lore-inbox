Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbVHaRJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbVHaRJm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 13:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964853AbVHaRJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 13:09:42 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:40973 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964812AbVHaRJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 13:09:41 -0400
Date: Wed, 31 Aug 2005 19:09:40 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Johannes Stezenbach <js@linuxtv.org>, Michael Krufky <mkrufky@m1k.net>,
       Andrew Morton <akpm@osdl.org>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       linux-kernel <linux-kernel@vger.kernel.org>, torvalds@osdl.org,
       linux-dvb-maintainer@linuxtv.org, stable@kernel.org
Subject: Re: [linux-dvb-maintainer] [2.6 patch] add missing select's to DVB_BUDGET_AV
Message-ID: <20050831170940.GA3766@stusta.de>
References: <4314B7C2.2080705@m1k.net> <20050831154350.GB8638@stusta.de> <20050831165907.GC21194@linuxtv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050831165907.GC21194@linuxtv.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2005 at 06:59:07PM +0200, Johannes Stezenbach wrote:
> On Wed, Aug 31, 2005 Adrian Bunk wrote:
> > 
> > Add missing select's to DVB_BUDGET_AV fixing the following compile 
> > error:
> > 
> > <--  snip  -->
> > 
> > ...
> >   LD      .tmp_vmlinux1
> > drivers/built-in.o: In function `frontend_init':
> > budget-av.c:(.text+0xb9448): undefined reference to `tda10046_attach'
> > budget-av.c:(.text+0xb9518): undefined reference to `tda10021_attach'
> > drivers/built-in.o: In function `philips_tu1216_request_firmware':
> > budget-av.c:(.text+0xb937b): undefined reference to `request_firmware'
> > make: *** [.tmp_vmlinux1] Error 1
> > 
> > <--  snip  -->
> > 
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> Acked-by: Johannes Stezenbach <js@linuxtv.org>
> 
> I also added this to linuxtv.org CVS. But I'm not sure it
> is critical enough to put it in stable.

If I were a -stable maintainer, I'd include both patches after they were 
included in Linus' tree and shipped with one -rc or -mm kernel.

But that's not a strong opinion, it's also OK for me if the patches 
don't get included in 2.6.13.x .

> Thanks,
> Johannes
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

