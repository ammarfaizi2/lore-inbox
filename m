Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964993AbVLVA7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964993AbVLVA7o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 19:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbVLVA7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 19:59:44 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:31757 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964993AbVLVA7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 19:59:43 -0500
Date: Thu, 22 Dec 2005 01:59:41 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Cc: Linus Torvalds <torvalds@osdl.org>, Sergey Vlasov <vsu@altlinux.ru>,
       Ricardo Cerqueira <v4l@cerqueira.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       video4linux-list@redhat.com, perex@suse.cz, alsa-devel@alsa-project.org
Subject: Re: [Alsa-devel] 2.6.15-rc6: boot failure in saa7134-alsa.c
Message-ID: <20051222005941.GK3917@stusta.de>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org> <20051220131810.GB6789@stusta.de> <20051220155216.GA19797@master.mivlgu.local> <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org> <20051220191412.GA4578@stusta.de> <1135110930.7822.18.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1135110930.7822.18.camel@localhost>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2005 at 06:35:30PM -0200, Mauro Carvalho Chehab wrote:
> Em Ter, 2005-12-20 às 20:14 +0100, Adrian Bunk escreveu:
> > (plus disabling building of saa7134-oss.o because
> > otherwise saa7134-alsa.o wouldn't do anything). 
> 
> 	This patch should fix alsa-oss incompatibilities when both are linked
> as module. It will also require either -oss or -alsa if it is statically
> linked.
> 
> 	It doesn't address the OOPS because of sound late init.
> 
> 	Adrian,
> 
> 	Please test and give us some feedback.

It works and looks good.

Can we get this patch into 2.6.15?

> Cheers, 
> Mauro.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

