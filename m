Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030189AbVLVQij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbVLVQij (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 11:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965169AbVLVQij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 11:38:39 -0500
Received: from smtp3.brturbo.com.br ([200.199.201.164]:8166 "EHLO
	smtp3.brturbo.com.br") by vger.kernel.org with ESMTP
	id S965166AbVLVQii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 11:38:38 -0500
Subject: Re: [RFC: 2.6 patch] Makefile: sound/ must come before drivers/
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       James Courtier-Dutton <James@superbug.co.uk>,
       Sergey Vlasov <vsu@altlinux.ru>, Ricardo Cerqueira <v4l@cerqueira.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       video4linux-list@redhat.com, perex@suse.cz, alsa-devel@alsa-project.org
In-Reply-To: <s5h8xudxg1e.wl%tiwai@suse.de>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>
	 <20051220131810.GB6789@stusta.de>
	 <20051220155216.GA19797@master.mivlgu.local>
	 <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org>
	 <20051220191412.GA4578@stusta.de>
	 <Pine.LNX.4.64.0512201156250.4827@g5.osdl.org>
	 <20051220202325.GA3850@stusta.de>
	 <Pine.LNX.4.64.0512201240480.4827@g5.osdl.org>
	 <43A86DCD.8010400@superbug.co.uk> <20051220211359.GA5359@stusta.de>
	 <Pine.LNX.4.64.0512201405550.4827@g5.osdl.org>
	 <s5hslsmzg2y.wl%tiwai@suse.de> <1135198140.7419.9.camel@localhost>
	 <s5hfyolxi3r.wl%tiwai@suse.de> <1135267618.1609.8.camel@localhost>
	 <s5h8xudxg1e.wl%tiwai@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Date: Thu, 22 Dec 2005 14:38:26 -0200
Message-Id: <1135269506.1609.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Qui, 2005-12-22 às 17:17 +0100, Takashi Iwai escreveu:
> > > If I understand correctly, it must be OK.  Suppose that
> saa7134-alsa
> > > is moved to sound (only saa7134-alsa, other saa7134 stuff remains
> in
> > > drivers/media/video), the initialization order will be: 
> > > saa7134 -> sound core -> saa7134-alsa.
> > > 
> > > Or am I missing something else?
> >       saa7134-oss.
> 
> It's obsolete to me ;)
	He hope it will became obsolete soon, but saa-alsa needs more time to
became more mature :) 2.6.15 will be the first mainstream with this
module. People still uses -oss...
> 
Cheers, 
Mauro.

