Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbVLUBdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbVLUBdM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 20:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbVLUBdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 20:33:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7656 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932135AbVLUBdL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 20:33:11 -0500
Date: Tue, 20 Dec 2005 17:29:20 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
cc: James Courtier-Dutton <James@superbug.co.uk>, Adrian Bunk <bunk@stusta.de>,
       Sergey Vlasov <vsu@altlinux.ru>, Ricardo Cerqueira <v4l@cerqueira.org>,
       mchehab@brturbo.com.br,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       video4linux-list@redhat.com, perex@suse.cz, alsa-devel@alsa-project.org
Subject: Re: [Alsa-devel] 2.6.15-rc6: boot failure in saa7134-alsa.c
In-Reply-To: <1135117067.27101.5.camel@mindpipe>
Message-ID: <Pine.LNX.4.64.0512201728020.4827@g5.osdl.org>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org> 
 <20051220131810.GB6789@stusta.de>  <20051220155216.GA19797@master.mivlgu.local>
  <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org>  <20051220191412.GA4578@stusta.de>
  <Pine.LNX.4.64.0512201156250.4827@g5.osdl.org>  <43A86B20.1090104@superbug.co.uk>
  <Pine.LNX.4.64.0512201248481.4827@g5.osdl.org> <1135117067.27101.5.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Dec 2005, Lee Revell wrote:
> 
> With modules it's possible to test a new ALSA version without
> recompiling the kernel or even rebooting

That's TOTALLY irrelevant.

Kernel modules work fine for developers. I'm not saying that _you_ 
shouldn't use modules.

I'm saying that you have absolutely no business telling others not to 
compile these things in.  Statically compiled drivers have advantages.

			Linus
