Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315485AbSE2VA2>; Wed, 29 May 2002 17:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315491AbSE2VA1>; Wed, 29 May 2002 17:00:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3344 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315485AbSE2VA0>;
	Wed, 29 May 2002 17:00:26 -0400
Message-ID: <3CF540F8.6000802@mandrakesoft.com>
Date: Wed, 29 May 2002 16:58:32 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul P Komkoff Jr <i@stingr.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.19 - What's up with the kernel build?
In-Reply-To: <Pine.LNX.4.44.0205291519270.9971-100000@chaos.physics.uiowa.edu> <20020529205005.GN422@stingr.net>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul P Komkoff Jr wrote:

>Replying to Kai Germaschewski:
>  
>
>>There is still quite a bit left to do (in particular improving
>>dependency generation and modversions handling), but I think it makes
>>sense to explain what happened so far.
>>
>>There's also some points (marked with >>>) where I'd like to get
>>feedback on how things should be handled in the future.
>>    
>>
>
>May I ask you just one questin?
>Have you read (yet) kbuild25 ?
>
>Ahh, no, another one.
>Is this a "signs" of kbuild25 being thrown away like cml2 ?
>If yes, then I am very unhappy person now (c) ac
>
>Played with kbuild25 today I migrated 2.4.19-pre8-ac5-s2 to it. Now make -f
>Makefile-2.5 is a preferred way to make here. New system is much cleaner,
>and don't need that mess of makedep and listmultis. But hey, people you
>should already know that whilst you trying to install a couple of new nails
>to rotten construct to help it stay for another couple of time intervals ...
>  
>


Well, I really like Keith's kbuild25 too, but Linus said (at least once) 
he wanted an evolution to a new build system... not an unreasonable 
request to at least consider.  Despite Keith's quality of code (again -- 
I like kbuild25), his 3 patch submissions seemed a lot like ultimatums, 
very "take it or leave it dammit".  Not the best way to win friends and 
influence people.

If Keith is indeed leaving it, I'm hoping someone will maintain it, or 
work with Kai to integrate it into 2.5.x.

    Jeff



