Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbVLTUrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbVLTUrM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 15:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbVLTUrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 15:47:12 -0500
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:40708 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S932089AbVLTUrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 15:47:11 -0500
Message-ID: <43A86DCD.8010400@superbug.co.uk>
Date: Tue, 20 Dec 2005 20:47:09 +0000
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051218)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Adrian Bunk <bunk@stusta.de>, Sergey Vlasov <vsu@altlinux.ru>,
       Ricardo Cerqueira <v4l@cerqueira.org>, mchehab@brturbo.com.br,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       video4linux-list@redhat.com, perex@suse.cz, alsa-devel@alsa-project.org
Subject: Re: [Alsa-devel] 2.6.15-rc6: boot failure in saa7134-alsa.c
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org> <20051220131810.GB6789@stusta.de> <20051220155216.GA19797@master.mivlgu.local> <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org> <20051220191412.GA4578@stusta.de> <Pine.LNX.4.64.0512201156250.4827@g5.osdl.org> <20051220202325.GA3850@stusta.de> <Pine.LNX.4.64.0512201240480.4827@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0512201240480.4827@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 20 Dec 2005, Adrian Bunk wrote:
> 
>>But the non-saa7134 access to my soundcard (e.g. rexima or xmms) is no 
>>longer working.
> 
> 
> Ahh. I assume it's the sequencer init etc that is missing.
> 
> Maybe we'll just have to do the late_init thing for at least the 2.6.15 
> timeframe.
> 
> 		Linus
> 

But that's not really a useable fix. The problem is with almost all ALSA 
sound cards.

