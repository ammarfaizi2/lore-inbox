Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266196AbUJLQu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266196AbUJLQu6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 12:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266216AbUJLQu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 12:50:58 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:4248 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S266196AbUJLQuw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 12:50:52 -0400
Message-ID: <416C0B5E.3090907@colorfullife.com>
Date: Tue, 12 Oct 2004 18:50:38 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vitez Gabor <vitezg@niif.hu>
CC: Vincent Hanquez <tab@snarc.org>, linux-kernel@vger.kernel.org
Subject: Re: forcedeth: "received irq with unknown events 0x1"
References: <20041011145104.GA9494@swszl.szkp.uni-miskolc.hu> <20041011154950.GA22553@snarc.org> <416AB99E.1020407@colorfullife.com> <20041012082047.GA17313@swszl.szkp.uni-miskolc.hu>
In-Reply-To: <20041012082047.GA17313@swszl.szkp.uni-miskolc.hu>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vitez Gabor wrote:

>On Mon, Oct 11, 2004 at 06:49:34PM +0200, Manfred Spraul wrote:
>  
>
>>Vincent, could you try the attached patch? The critical change is the 
>>media detection: Test that the nic handles booting without a network 
>>cable and then attaching the network cable when the interface is already 
>>up correctly.
>>    
>>
>
>I patched my kernel, and I'm still baffled: when I connect the E1000 and the
>nvidia card, both of them say the link is down. The E1000 and the 3Com card
>works well. The E1000 is supposed to do polarity detection, so it should
>work with the nvidia card, too. ??
>
>Not really a problem, but I find it pretty strange.
>
>  
>
Sorry, I don't understand your mail: Does the nic work or not? Which 
tool did you use to check the link status? ethtool or something else?

--
    Manfred
