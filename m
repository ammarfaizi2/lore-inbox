Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267657AbUIXCY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267657AbUIXCY1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 22:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267568AbUIXCXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 22:23:30 -0400
Received: from relay.pair.com ([209.68.1.20]:45841 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S265805AbUIXCWb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 22:22:31 -0400
X-pair-Authenticated: 66.188.111.210
Message-ID: <415384E1.2080907@cybsft.com>
Date: Thu, 23 Sep 2004 21:22:25 -0500
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Mark_H_Johnson@Raytheon.com, Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm3-S5
References: <1094597988.16954.212.camel@krustophenia.net> <20040908082050.GA680@elte.hu> <1094683020.1362.219.camel@krustophenia.net> <20040909061729.GH1362@elte.hu> <20040919122618.GA24982@elte.hu> <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu>
In-Reply-To: <20040923211206.GA2366@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i've released the -S5 VP patch:
>  
>    http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc2-mm3-S5

This one seems to bring back some issues with the network interface. The 
only noticeable symptom is dropping ~30 percent of new telnet 
connections under heavy load. When not loaded it still drops ~5 percent. 
I had no dropped connections with S4 even when loaded. This just happens 
to be one of things that I have been testing manually since I noticed 
some problems with previous patches.

Currently using an SMC card with a DEC 21140 chip and the tulip driver 
on my SMP system.

kr
