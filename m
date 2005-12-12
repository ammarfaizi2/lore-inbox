Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750946AbVLLM1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbVLLM1s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 07:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbVLLM1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 07:27:48 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:63619 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750946AbVLLM1s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 07:27:48 -0500
Message-ID: <439D6D9E.1020609@aitel.hist.no>
Date: Mon, 12 Dec 2005 13:31:26 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nix <nix@esperi.org.uk>
CC: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Helge Hafting <helgehaf@aitel.hist.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc5: multiuser scheduling trouble
References: <Pine.LNX.4.64.0512032155290.3099@g5.osdl.org>	<20051210162759.GA15986@aitel.hist.no>	<Pine.LNX.4.64.0512111607040.15597@g5.osdl.org>	<20051212065150.GA8187@elte.hu> <87vexuy2lt.fsf@amaterasu.srvr.nix>
In-Reply-To: <87vexuy2lt.fsf@amaterasu.srvr.nix>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nix wrote:

>On 12 Dec 2005, Ingo Molnar announced authoritatively:
>  
>
>>does this mean X defaults to nice level 0, and then if you renice
>>Firefox and X by +10, everything is fine? Or is Linus' suspicion, and X
>>defaults to something like nice -5? (e.g. on Debian type of systems)
>>    
>>
>
>Your latter suspicion is correct, on Debian at least: see the setting of
>nice_value in /etc/X11/Xwrapper.config.
>  
>
This value is 0 on my debian system - as recommended for the kernels
I use.

Hegle Hafting
