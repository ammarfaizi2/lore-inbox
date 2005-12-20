Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbVLTUX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbVLTUX1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 15:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbVLTUX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 15:23:27 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:59150 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932074AbVLTUX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 15:23:27 -0500
Date: Tue, 20 Dec 2005 21:23:25 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Sergey Vlasov <vsu@altlinux.ru>, Ricardo Cerqueira <v4l@cerqueira.org>,
       mchehab@brturbo.com.br,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       video4linux-list@redhat.com, perex@suse.cz, alsa-devel@alsa-project.org
Subject: Re: [Alsa-devel] 2.6.15-rc6: boot failure in saa7134-alsa.c
Message-ID: <20051220202325.GA3850@stusta.de>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org> <20051220131810.GB6789@stusta.de> <20051220155216.GA19797@master.mivlgu.local> <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org> <20051220191412.GA4578@stusta.de> <Pine.LNX.4.64.0512201156250.4827@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512201156250.4827@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2005 at 11:59:20AM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 20 Dec 2005, Adrian Bunk wrote:
> >
> > > Adrian, does it work if you change the "module_init()" in 
> > > sound/sound_core.c into a "fs_initcall()"?
> > 
> > No, this didn't work.
> > 
> > What did work was to leave sound/sound_core.c alone
> 
> Can you do try the other way again, with sound/core/sound.c fixed too?
>...

This works in the sense that the kernel boots and my saa7134 TV card is 
giving both audio and video output.

But the non-saa7134 access to my soundcard (e.g. rexima or xmms) is no 
longer working.

> 	Thanks,
> 
> 		Linus

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

