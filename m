Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129152AbQKBVX0>; Thu, 2 Nov 2000 16:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129378AbQKBVXQ>; Thu, 2 Nov 2000 16:23:16 -0500
Received: from Cantor.suse.de ([194.112.123.193]:39941 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129152AbQKBVXJ>;
	Thu, 2 Nov 2000 16:23:09 -0500
Date: Thu, 2 Nov 2000 22:23:06 +0100
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tim Riker <Tim@Rikers.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: non-gcc linux? (was Re: Where did kgcc go in 2.4.0-test10?)
Message-ID: <20001102222306.A15754@gruyere.muc.suse.de>
In-Reply-To: <3A01D6D1.44BD66FE@Rikers.org> <E13rRk1-0001ut-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E13rRk1-0001ut-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Nov 02, 2000 at 09:17:44PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2000 at 09:17:44PM +0000, Alan Cox wrote:
> > How can I insure that the largest possible amount of my efforts benefit
> > the community at large? Hopefully this will make it easier to move to
> > C99 or any other future compiler porting project.
> 
> The asm I dont know - its a hard problem. Things like C99 initializers for 2.5
> seem quite a reasonable change. There are also things like partial structure
> packing with __attribute((packed)) that can be hard to port

All non toy compilers[1] I've seen so far had some equivalent of __attribute__((packed)).
It just always has a different syntax, usually even non macro friendly (#pragma) 

-Andi

[1] ok and the TenDRA one
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
