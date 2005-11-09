Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbVKIXBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbVKIXBF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 18:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbVKIXBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 18:01:05 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:25472 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751054AbVKIXBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 18:01:01 -0500
Subject: Re: [Patch 1/1] V4L (926) Saa7134 alsa can only be
	autoloaded	after	saa7134 is active
From: Lee Revell <rlrevell@joe-job.com>
To: R C <v4l@cerqueira.org>
Cc: Takashi Iwai <tiwai@suse.de>, mchehab@brturbo.com.br,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       video4linux-list@redhat.com, alsa-devel@lists.sourceforge.net,
       nshmyrev@yandex.ru
In-Reply-To: <1131484155.4851.10.camel@frolic>
References: <1131397121.6632.127.camel@localhost>
	 <s5hd5lbnzg6.wl%tiwai@suse.de> <1131451671.2863.4.camel@frolic>
	 <s5h4q6nnunn.wl%tiwai@suse.de>  <1131484155.4851.10.camel@frolic>
Content-Type: text/plain
Date: Wed, 09 Nov 2005 17:59:03 -0500
Message-Id: <1131577144.8383.126.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-08 at 21:09 +0000, R C wrote:
> On Tue, 2005-11-08 at 14:20 +0100, Takashi Iwai wrote:
> 
> > But saa7134_dma_stop() should be already called in trigger callback,
> > which is called via snd_pcm_stop().
> 
> You're right. I wasn't aware pcm_stop() caused a trigger.
> You may want to check the current version at
> http://linuxtv.org/cgi-bin/viewcvs.cgi/v4l-kernel/linux/drivers/media/video/saa7134/saa7134-alsa.c?rev=1.21&root=v4l&view=auto

Did you not read Takashi-san's ALSA driver guide?  If not I'm impressed
you made it work at all...

http://www.alsa-project.org/~iwai/writing-an-alsa-driver/


Lee

