Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314077AbSFXPGl>; Mon, 24 Jun 2002 11:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314078AbSFXPGk>; Mon, 24 Jun 2002 11:06:40 -0400
Received: from cwbone.bsi.com.br ([200.194.240.1]:46654 "EHLO
	cwbone.bsi.com.br") by vger.kernel.org with ESMTP
	id <S314077AbSFXPGj>; Mon, 24 Jun 2002 11:06:39 -0400
Message-ID: <3D173578.5080205@PolesApart.wox.org>
Date: Mon, 24 Jun 2002 12:06:32 -0300
From: "Alexandre P. Nunes" <alex@PolesApart.wox.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a) Gecko/20020610
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4.19-pre10-ac2 bug in page_alloc.c:131
References: <E17MUf8-00088K-00@the-village.bc.nu>
X-scanner: scanned by Inflex 1.0.9 - (http://pldaniels.com/inflex/)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>report. It's possible that the NVdriver module is the cause of the 
>>problem, but the bug spots in kernel's vm, in a place which it's no 
>>supposed to, at the point I understand. So, or the module does something 
>>very ugly, or the kernel really have a bug, or yet it's nothing related 
>>to the nvdriver. Unfortunately, the backtrace don't help me figuring 
>>that out, since I'm no vm expert, but perhaps someone will. I may 
>>attempt to forward this to Nvidia folks, but reporting a bug which only 
>>spotted once and in a "pre" series kernel may hurt their feelings...
>>    
>>
>
>Their problem - they have our source we dont have theirs. If it occurs
>with nvdriver ever loaded in that boot send it to nvidia or duplicate it
>from a cold boot without the driver ever loadinhg
>  
>
I sent an email to they.
I'm not able to try to reproduce it either with or without the module 
loaded, since I have no access to the machine in question right now. In 
the case I can, maybe I'll try to do it. Since it just happened once, 
after I happened to get with swap pratically full, I guess that would be 
hard (there was no OOM reporting from the kernel, though).

Maybe I got it the wrong way, but it seems to me that from your point of 
view, as long as proprietary driver is in use, it's not anyone else 
problem but to the vendor, even if the bug could happen to be in the 
kernel, is that right? If so, everyone else in this list who could try 
to fix this (again assuming it could be something related to the kernel 
and not to the proprietary driver) necessarily share your oppinion? (I'm 
not flaming in here, just trying to get the path).


Thank you,

Alexandre

