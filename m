Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbVLTUpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbVLTUpZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 15:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbVLTUpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 15:45:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14755 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932087AbVLTUpY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 15:45:24 -0500
Date: Tue, 20 Dec 2005 12:41:25 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Sergey Vlasov <vsu@altlinux.ru>, Ricardo Cerqueira <v4l@cerqueira.org>,
       mchehab@brturbo.com.br,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       video4linux-list@redhat.com, perex@suse.cz, alsa-devel@alsa-project.org
Subject: Re: [Alsa-devel] 2.6.15-rc6: boot failure in saa7134-alsa.c
In-Reply-To: <20051220202325.GA3850@stusta.de>
Message-ID: <Pine.LNX.4.64.0512201240480.4827@g5.osdl.org>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>
 <20051220131810.GB6789@stusta.de> <20051220155216.GA19797@master.mivlgu.local>
 <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org> <20051220191412.GA4578@stusta.de>
 <Pine.LNX.4.64.0512201156250.4827@g5.osdl.org> <20051220202325.GA3850@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Dec 2005, Adrian Bunk wrote:
> 
> But the non-saa7134 access to my soundcard (e.g. rexima or xmms) is no 
> longer working.

Ahh. I assume it's the sequencer init etc that is missing.

Maybe we'll just have to do the late_init thing for at least the 2.6.15 
timeframe.

		Linus
