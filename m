Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291611AbSBMMse>; Wed, 13 Feb 2002 07:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291616AbSBMMsO>; Wed, 13 Feb 2002 07:48:14 -0500
Received: from [195.63.194.11] ([195.63.194.11]:45319 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S291611AbSBMMr6>; Wed, 13 Feb 2002 07:47:58 -0500
Message-ID: <3C6A606C.1060604@evision-ventures.com>
Date: Wed, 13 Feb 2002 13:47:40 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.5.4 i810_audio, bttv, working at all.
In-Reply-To: <200201282213.g0SMDcU25653@snark.thyrsus.com> <200201290137.g0T1bwB24120@karis.localdomain> <a354iv$ai9$1@penguin.transmeta.com> <3C6A57CE.9010107@evision-ventures.com> <3C6A5D79.33C31910@mandrakesoft.com> <3C6A5EDB.40908@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:

> Jeff Garzik wrote:
>
>> These changes are wrong.  The addresses desired need to be obtained from
>> the pci_alloc_consistent return values. 
>
>
> The bttv we can argue about, I was just tagging it as beeing a quick 
> fix...
>
> Of course I admit that I have taken the easy shoot here. But it wasn't 
> possible
> to me to deduce the proper thing to do by looking at the patches.
> This is the usual way I deal with API changes: Have a look at what has 
> been done
> to the other candidates and do the analogous thing where you need it.
>
> But please just show me a non x86 architecture which is using the 
> i810_audio driver! 


Ah OK now I see that the API changes you where referencing too are 
missing in bttv.c
already for a longer time then the 2.5.3->2.5.4 stage. This makes it 
clear how to deal with that.


>

