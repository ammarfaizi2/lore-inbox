Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161469AbWATC6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161469AbWATC6k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 21:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161475AbWATC6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 21:58:40 -0500
Received: from cable-212.76.255.90.static.coditel.net ([212.76.255.90]:20365
	"EHLO jekyll.org") by vger.kernel.org with ESMTP id S1161469AbWATC6j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 21:58:39 -0500
Message-ID: <43D051CE.8060609@jekyll.org>
Date: Fri, 20 Jan 2006 03:58:22 +0100
From: Gilles May <gilles@jekyll.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: SMP trouble
References: <43CAFF80.2020707@jekyll.org> <Pine.LNX.4.64.0601181817410.20777@montezuma.fsmlabs.com> <43CFD877.4090503@jekyll.org> <Pine.LNX.4.64.0601191132010.1579@montezuma.fsmlabs.com> <43CFEC68.4070704@jekyll.org> <Pine.LNX.4.64.0601191826520.1579@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.64.0601191826520.1579@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

>On Thu, 19 Jan 2006, Gilles May wrote:
>
>  
>
>>I don't think it has something to do with the USB card, nor the HDD oder the
>>DVD writer connected to it..
>>Just to be sure I bought a new USB card with a different chip even, hangs with
>>both controllers..
>>Besides it freezes aswell if I do the ping and IDE to IDE copies and listening
>>music.. Looks like high
>>IO loads brings it down, no matter where it comes from..
>>The wierd part is that it's only with Linux SMP, not with UP, and no problems
>>like that on WindowsXP SP2..
>>
>>This starts giving me serious headaches.. ;)
>>    
>>
>
>Trying to isolate things here, do you need the ping/network load to 
>trigger it? How about only network load?
>  
>
Hmm good question, I'll do further tests, but from my past experiences I 
got the feeling that it's rather the sound that is needed to trigger the 
freeze, not the network load.

A few lines from dmesg puzzle me too, like:

spurious 8259A interrupt: IRQ7. -> What is that, and why?

mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration. -> Maybe not corrected correctly?

BIOS failed to enable PCI standards compliance, fixing this error. -> 
Maybe not really fixed?

Thanks for your effort,
Gilles May

PS: Am I the only one with a K7D Master-L and problems like that?
