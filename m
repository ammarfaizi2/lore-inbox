Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932520AbWARTxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbWARTxi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 14:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbWARTxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 14:53:38 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:39917 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932520AbWARTxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 14:53:37 -0500
Subject: Re: [RFC] Moving snd-bt87x and btaudio to drivers/media
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       Takashi Iwai <tiwai@suse.de>,
       alsa devel <alsa-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Johannes Stezenbach <js@linuxtv.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       Manu Abraham <abraham.manu@gmail.com>
In-Reply-To: <20060118194147.GN19398@stusta.de>
References: <1137590968.32449.46.camel@localhost>
	 <20060118194147.GN19398@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 18 Jan 2006 17:53:20 -0200
Message-Id: <1137614000.28917.40.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Qua, 2006-01-18 às 20:41 +0100, Adrian Bunk escreveu:
> On Wed, Jan 18, 2006 at 11:29:28AM -0200, Mauro Carvalho Chehab wrote:
> >...
> > 	This I couldn't found at any Kconfig (but module exists, and also an
> > entry at Makefile):
> > sound/oss/Makefile:obj-$(CONFIG_SOUND_BT878)    += btaudio.o
> >...
> 
> The entry is in sound/oss/Kconfig.
	Ok. I don't know why I didn't saw it :) So, we should also move it to
video Kconfig, with the module, and add a choice for OSS or ALSA, like
we intend to do with saa7134-oss/alsa.
> 
> > Cheers, 
> > Mauro.
> 
> cu
> Adrian
> 
Cheers, 
Mauro.

