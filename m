Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292294AbSB0KWh>; Wed, 27 Feb 2002 05:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292315AbSB0KW1>; Wed, 27 Feb 2002 05:22:27 -0500
Received: from [195.63.194.11] ([195.63.194.11]:58639 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S292294AbSB0KWI>; Wed, 27 Feb 2002 05:22:08 -0500
Message-ID: <3C7CB325.5050304@evision-ventures.com>
Date: Wed, 27 Feb 2002 11:21:25 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Ken Brownfield <brownfld@irridia.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] ServerWorks autodma behavior
In-Reply-To: <20020226032629.A930@asooo.flowerfire.com> <3C7B6DAE.1090809@evision-ventures.com> <20020226190149.B16048@asooo.flowerfire.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ken Brownfield wrote:
> On Tue, Feb 26, 2002 at 12:12:46PM +0100, Martin Dalecki wrote:
> | Ken Brownfield wrote:
> [...]
> | > In any case, I've appended the patch I'm using to be able to turn off
> | > auto-DMA at config-time rather than run-time for ServerWorks.  One
> | > alternative is to shed this code altogether, since ide-pci.c seems to
> | > set a rational default.
> | 
> | I think (not 100% becouse not re-checked against the code),
> | you could just have removed the lines
> | 
> | if (!noautodma)
> | 	hwif->autodma = 1;
> | 
> | and all should be well ;-).
> 
> Yes, and that's what I found as well.  That was my first patch until I
> noticed the AUTO check in the VIA driver around this same code.
I rather think that VIA could be cured the same way.

