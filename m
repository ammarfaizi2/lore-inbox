Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267776AbUJHBtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267776AbUJHBtB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 21:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267903AbUJHBqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 21:46:31 -0400
Received: from relay.pair.com ([209.68.1.20]:13329 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S267776AbUJHBlm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 21:41:42 -0400
X-pair-Authenticated: 66.190.53.4
Message-ID: <4165F050.5050904@cybsft.com>
Date: Thu, 07 Oct 2004 20:41:36 -0500
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>,
       Florian Schmidt <mista.tapas@gmx.net>, Mark_H_Johnson@raytheon.com,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm3-T3
References: <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu> <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu> <20041004215315.GA17707@elte.hu> <20041005134707.GA32033@elte.hu> <20041007105230.GA17411@elte.hu> <4165832E.1010401@cybsft.com> <4165A729.5060402@cybsft.com> <20041007215546.GA8541@elte.hu>
In-Reply-To: <20041007215546.GA8541@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * K.R. Foley <kr@cybsft.com> wrote:
> 
> 
>>>For me, this one wants to panic on boot when trying to find the root 
>>>filesystem. Acts like either the aic7xxx module is missing (which I 
>>>don't think is the case) or hosed, or it's having trouble with the label 
>>>for the root partition (Fedora system). Will investigate further when I 
>>>get home tonight, unless something jumps out at anyone.
>>>
>>>kr
>>
>>For clarification: This appears to be a problem in 2.6.9-rc3-mm3 also.
> 
> 
> try root=/dev/sda3 (or whereever your root fs is) instead of
> root=LABEL=/, in /etc/grub.conf.
> 
> 	Ingo
> 

Thanks. Tried that just to be sure. However, I don't seem to be the only 
one having this problem with aic7xxx.

kr
