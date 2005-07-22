Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262179AbVGVVPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbVGVVPH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 17:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbVGVVPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 17:15:06 -0400
Received: from rly-ip04.mx.aol.com ([64.12.138.8]:55010 "EHLO
	rly-ip04.mx.aol.com") by vger.kernel.org with ESMTP id S262179AbVGVVNc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 17:13:32 -0400
Message-ID: <42E160F5.20408@yahoo.co.uk>
Date: Fri, 22 Jul 2005 22:11:17 +0100
From: christos gentsis <christos_gentsis@yahoo.co.uk>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel optimization
References: <42E14134.1040804@yahoo.co.uk> <20050722201416.GM3160@stusta.de>
In-Reply-To: <20050722201416.GM3160@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AOL-IP: 195.93.24.41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

>On Fri, Jul 22, 2005 at 07:55:48PM +0100, christos gentsis wrote:
>
>  
>
>>hello
>>    
>>
>
>Hi Chris,
>
>  
>
>>i would like to ask if it possible to change the optimization of the 
>>kernel from -O2 to -O3 :D, how can i do that? if i change it to the top 
>>level Makefile does it change to all the Makefiles?
>>    
>>
>
>search for the line with
>  CFLAGS          += -O2
>and change this to -O3.
>
>This works for most Makefile's except for the one's that manually
>set -Os.
>
>  
>
>>And let's say that i change it... does this generate any problems with 
>>the space that the kernel will take? (the kernel will be much larger)
>>    
>>
>
>It's completely untested.
>And since it's larger, it's also slower.
>
>  
>
>>Thanks
>>Chris
>>    
>>
>
>cu
>Adrian
>
>  
>
so if i want to play with and see what happens i have to change it 
manually in each make file... good i may create a kernel like that to 
see what will happens (just for test) ;)

thanks
Chris

