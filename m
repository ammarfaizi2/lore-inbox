Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264606AbRFPKRd>; Sat, 16 Jun 2001 06:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264607AbRFPKRX>; Sat, 16 Jun 2001 06:17:23 -0400
Received: from [212.18.228.90] ([212.18.228.90]:60683 "HELO
	carrot.linuxgrrls.org") by vger.kernel.org with SMTP
	id <S264606AbRFPKRF>; Sat, 16 Jun 2001 06:17:05 -0400
Message-ID: <3B2B31C7.5020708@linuxgrrls.org>
Date: Sat, 16 Jun 2001 11:15:35 +0100
From: Rachel Greenham <rachel@linuxgrrls.org>
Organization: LinuxGrrls.Org
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3-ac6 i686; en-US; rv:0.9.1) Gecko/20010607 Netscape6/6.1b1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: VIA KT133A crash *post* 2.4.3-ac6
In-Reply-To: <Pine.LNX.4.33.0106151858540.12619-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Molina wrote:

>So is there no correlation from particular hardware to problems reported?
>I'm running the A7V133 with a Western Digital WD300BB UDMA 5 drive on
>kernel 2.4.5 with no trouble.
>
Well, I don't know. I'd guess there'd *have* to be some correlation, but 
we're not gathering enough information to see the pattern. ie: which 
BIOS version, what exact BIOS options are set, what processor/speed, 
what memory, what exact model of hard disk... We just may not have a big 
enough sample size. Even in my case the crashes aren't predictable in 
nature - 2.4.4 passed my bonnie test the first time, making me think the 
problem was introduced in 2.4.5, and only failed later in normal usage - 
next time I tested it it failed in the first minute or so. *Most* of the 
time failures occur during the bonnie test, but at all sorts of random 
times during the test.

<redundant>as long as you're sure you do have DMA enabled that is - SuSE 
at least leaves it disabled by default, under which conditions all 
kernels are stable for me</redundant>

-- 
Rachel


