Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129581AbQKBVds>; Thu, 2 Nov 2000 16:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129627AbQKBVdi>; Thu, 2 Nov 2000 16:33:38 -0500
Received: from ra.lineo.com ([204.246.147.10]:37284 "EHLO thor.lineo.com")
	by vger.kernel.org with ESMTP id <S129581AbQKBVdX>;
	Thu, 2 Nov 2000 16:33:23 -0500
Message-ID: <3A01DC47.4D48D875@Rikers.org>
Date: Thu, 02 Nov 2000 14:27:35 -0700
From: Tim Riker <Tim@Rikers.org>
Organization: Riker Family (http://rikers.org/)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: non-gcc linux?
In-Reply-To: <3A01D6D1.44BD66FE@Rikers.org> <E13rRk1-0001ut-00@the-village.bc.nu> <20001102222306.A15754@gruyere.muc.suse.de>
X-MIMETrack: Serialize by Router on thor/Lineo(Release 5.0.5 |September 22, 2000) at 11/02/2000
 02:33:20 PM,
	Serialize complete at 11/02/2000 02:33:20 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#pragma is a particularly difficult problem to deal with because it is
non macro friendly. =(

Sounds like C99 initializers are a likely first target for integration.

I'll keep plugging away at other stuff here as well.

Andi Kleen wrote:
> 
> On Thu, Nov 02, 2000 at 09:17:44PM +0000, Alan Cox wrote:
> > > How can I insure that the largest possible amount of my efforts benefit
> > > the community at large? Hopefully this will make it easier to move to
> > > C99 or any other future compiler porting project.
> >
> > The asm I dont know - its a hard problem. Things like C99 initializers for 2.5
> > seem quite a reasonable change. There are also things like partial structure
> > packing with __attribute((packed)) that can be hard to port
> 
> All non toy compilers[1] I've seen so far had some equivalent of __attribute__((packed)).
> It just always has a different syntax, usually even non macro friendly (#pragma)
> 
> -Andi
> 
> [1] ok and the TenDRA one

-- 
Tim Riker - http://rikers.org/ - short SIGs! <g>
All I need to know I could have learned in Kindergarten
... if I'd just been paying attention.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
