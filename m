Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271423AbTGQLKN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 07:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271422AbTGQLKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 07:10:13 -0400
Received: from lakemtao01.cox.net ([68.1.17.244]:29174 "EHLO
	lakemtao01.cox.net") by vger.kernel.org with ESMTP id S271430AbTGQLKD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 07:10:03 -0400
Date: Thu, 17 Jul 2003 07:25:36 -0400
From: Wil Reichert <wilreichert@yahoo.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.0-test1 snd-ice1724 module OOPS
Message-Id: <20030717072536.49057dc7.wilreichert@yahoo.com>
In-Reply-To: <s5hr84pzdu1.wl@alsa2.suse.de>
References: <20030716115156.2b5a1992.wilreichert@yahoo.com>
	<s5hr84pzdu1.wl@alsa2.suse.de>
Organization: NA
X-Mailer: Sylpheed version 0.9.3claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, the module loads fine now.

I have a couple of questions regarding this card (M-Audio Revolution 7.1) and ALSA if you'll humour me.

A) Does the driver support more than 2 channels of sound?  I've had no luck getting output out of anything but the analog front channel.

B) Instead of the typical <Master> <PCM> <Line> etc channels in alsamixer I have DAC[1-7], with the front left & right channel being <DAC> and <DAC1>.  Is this normal?

C) mplayer (http://www.mplayerhq.hu) compiled with alsa support will detect the card but fails a snd_pcm_hw_params_set_format call.  It will work fine via OSS emulation however.  The same build of mplayer works fine via alsa with other cards, tho.  Is this a driver problem, a hardware limitation, or a problem in mplayer?

Thanks.

Wil 


On Thu, 17 Jul 2003 11:45:26 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Wed, 16 Jul 2003 11:51:56 -0400,
> Wil Reichert wrote:
> > 
> > I get the following OOPS when loading the snd-ice1724 module for my Envy 24HT card.  Works fine if I build all the alsa code straight into the kernel.
> > 
> 
> does the attached patch fix the problem?
> 
> -- 
> Takashi Iwai <tiwai@suse.de>		SuSE Linux AG - www.suse.de
> ALSA Developer				ALSA Project - www.alsa-project.org
> 


