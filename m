Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030356AbVKHVJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030356AbVKHVJj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 16:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030359AbVKHVJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 16:09:39 -0500
Received: from onyx.ip.pt ([195.23.92.252]:13034 "EHLO mail.isp.novis.pt")
	by vger.kernel.org with ESMTP id S1030356AbVKHVJi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 16:09:38 -0500
Subject: Re: [Patch 1/1] V4L (926) Saa7134 alsa can only be
	autoloaded	after	saa7134 is active
From: R C <v4l@cerqueira.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: mchehab@brturbo.com.br, linux-kernel@vger.kernel.org, akpm@osdl.org,
       video4linux-list@redhat.com, rlrevell@joe-job.com,
       alsa-devel@lists.sourceforge.net, nshmyrev@yandex.ru
In-Reply-To: <s5h4q6nnunn.wl%tiwai@suse.de>
References: <1131397121.6632.127.camel@localhost>
	 <s5hd5lbnzg6.wl%tiwai@suse.de> <1131451671.2863.4.camel@frolic>
	 <s5h4q6nnunn.wl%tiwai@suse.de>
Content-Type: text/plain
Date: Tue, 08 Nov 2005 21:09:15 +0000
Message-Id: <1131484155.4851.10.camel@frolic>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 2005-11-08 at 14:20 +0100, Takashi Iwai wrote:

> But saa7134_dma_stop() should be already called in trigger callback,
> which is called via snd_pcm_stop().

You're right. I wasn't aware pcm_stop() caused a trigger.
You may want to check the current version at
http://linuxtv.org/cgi-bin/viewcvs.cgi/v4l-kernel/linux/drivers/media/video/saa7134/saa7134-alsa.c?rev=1.21&root=v4l&view=auto

--
RC

