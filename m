Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271507AbRHPPgH>; Thu, 16 Aug 2001 11:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271575AbRHPPf5>; Thu, 16 Aug 2001 11:35:57 -0400
Received: from mail.ayrix.net ([64.49.1.26]:54262 "EHLO mail.bignetsouth.net")
	by vger.kernel.org with ESMTP id <S270873AbRHPPfj>;
	Thu, 16 Aug 2001 11:35:39 -0400
Message-ID: <3B7BE84D.117212FE@ayrix.net>
Date: Thu, 16 Aug 2001 10:35:41 -0500
From: Bob Martin <bmartin@ayrix.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Via chipset
In-Reply-To: <E15X75K-0003vl-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Someone should be able to forward failure cases to some AMD contacts. A
> > day or so with a bus analyzer should pin things down, AMD certainly has
> > the hardware to check this.
> 
> It doesnt happen with AMD chipsets. Although if anyone from AMD is
> interested I'd be happy to know
> 
> Alan


I have a MSI-6195 slot-A , AMD chipset with a visiontek nvidia vanta 32mb agp
card, RH 7.1 installed. I have experienced complete system lockups with random
uptimes < 1 day to 4 days, no mouse, keyboard, VCs, can't even telnet in or
ping. I finally made the connection it was happening when I was away from the
box and not using it interactively, which lead me to xscreensaver and sure
enough after I disabled it, no more lockups, up 30 days now. But I haven't
figured what in xscreensaver is doing this, don't know if it might be kernel
related or not, probably not. I suspect xscreensaver is triggering something in
the xserver that is not normally getting hit in normal use.

-- 

Bob Martin
