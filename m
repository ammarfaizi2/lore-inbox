Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbVKWUFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbVKWUFi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 15:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbVKWUFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 15:05:38 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:51113 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932283AbVKWUFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 15:05:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=EPFkk9lpmD5+l7J0oRd6A7c7kbm6/nJc9xJZ08OFKef0R+JUY51Qpvfpq92SSFAlqxDmLmk+4T08H2Y7fs1gWNpqdvp6z42mtwDDDoxAijyzh0RZQ2bnaplfUKA3wNWollFtVnyueh05jMDs+D0ZTCxXv/az5eDNBoD3QBrMcBg=
Message-ID: <4384CB8B.6040409@gmail.com>
Date: Wed, 23 Nov 2005 21:05:31 +0100
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051027)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Ard van Breemen <ard@kwaak.net>, linux-kernel@vger.kernel.org
Subject: Re: [BUG 2579] linux 2.6.* sound problems
References: <53L1x-6dC-13@gated-at.bofh.it> <53LkE-6QU-5@gated-at.bofh.it>	 <53LkW-6QU-49@gated-at.bofh.it> <53LEq-7gr-7@gated-at.bofh.it>	 <43667406.9070104@gmail.com> <4366A49F.3000101@rainbow-software.org>	 <43673B6F.5030909@gmail.com>  <20051123162216.GG1700@kwaak.net> <1132775178.10453.14.camel@mindpipe>
In-Reply-To: <1132775178.10453.14.camel@mindpipe>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell ha scritto:

>On Wed, 2005-11-23 at 17:22 +0100, Ard van Breemen wrote:
>  
>
>>On Tue, Nov 01, 2005 at 10:54:55AM +0100, Patrizio Bassi wrote:
>>    
>>
>>>i played a bit with bios, but no luck.
>>>considering that in my windows copy i have no problems, i'm sure it's
>>>linux 2.6
>>>
>>>update: can't use linux 2.4, i have nptl only and acpi problems too.
>>>i'll play with timers and latency
>>>      
>>>
>>One more suggestion:
>>try running distributed-net or something else that uses 100% cpu.
>>I also have "bad sound" from on-board audio (hp nx9110 notebook
>>and some elcheap asus motherboard). Usually it is a bad or cheap
>>motherboard design.
>>If using your CPU 100% fixes or mostly diminishes your audio
>>distortion, you can be 100% sure that the audio part has a very
>>bad design (no separate voltage controllers or good power supply
>>filters, and no separate power supply circuit, and of course a
>>good deal of crosstalk between analog lines and "digital" lines).
>>
>>    
>>
>
>Please try to isolate whether the PCI latency timer change OR the change
>from HZ=250 to HZ=100 fixed the problem.
>
>Lee
>
>
>  
>
it seems both.
now i'm using 1000hz with 0x40 latency.
i still get some noises but lower than before (lat = 0x20).

however i saw you marked it closed as hardware problem, i'm sure it isn't.

it' a linux 2.6 problem for me, as 2.4 and windows works perfectly. stop :)
a windows copy, running under vmware on linux 2.6, seems to work good too.
