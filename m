Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266469AbRGLRm0>; Thu, 12 Jul 2001 13:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266459AbRGLRmQ>; Thu, 12 Jul 2001 13:42:16 -0400
Received: from [64.8.237.82] ([64.8.237.82]:61903 "EHLO azrael.nerv-9.net")
	by vger.kernel.org with ESMTP id <S266429AbRGLRmH>;
	Thu, 12 Jul 2001 13:42:07 -0400
From: Mike Borrelli <mike@nerv-9.net>
Message-Id: <200107121737.f6CHbGu09349@azrael.nerv-9.net>
Subject: Re: Switching Kernels without Rebooting?
To: acahalan@cs.uml.edu (Albert D. Cahalan)
Date: Thu, 12 Jul 2001 13:37:16 -0400 (EDT)
Cc: riel@conectiva.com.br (Rik van Riel), cslater@wcnet.org (C. Slater),
        linux-kernel@vger.kernel.org
In-Reply-To: <200107121623.f6CGNV569053@saturn.cs.uml.edu> from "Albert D. Cahalan" at Jul 12, 2001 12:23:31 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How often would a company that demands 24x7 uptime /want/ to upgrade their 
kernel?  It seems to me that when the choice been decided to take that 
kind of a step in a production environment, that someone has done lots of 
tests with the new target kernel, so that even if they don't have the 
extra hardware to bring up another server in parallel, the most downtime 
that would be suffered would be the time it takes to do two boots (boot 
the new kernel, find out it doesn't work, reboot the old one.)

Not to discourage anyone, but is this really necessary, or is it something 
to be worked on just to say that it can be done?

Just a random comment from someone who knows very little.

Regards,
Mike

On Thu Jul 12 12:23:31 2001 Albert D. Cahalan said...
> Rik van Riel writes:
> 
> > I won't have time to put in a project as huge and difficult
> > as upgrading the kernel "live", but I'll be around to try
> > and teach people about how the kernel works.
> 
> I think I see a business opportunity here.
> 
> Live upgrades require data structure conversion and other horrors.
> You can't just write the code and expect it to maintain itself.
> You'd need to rewrite half of it every time, for every patch level.
> 
> The 24x7 places might be willing to pay somebody to do this.
> It's consulting work really. The customer says "I want to go
> from 2.4.8 to 2.4.12", you say "OK, $320405 please.", and you
> make a custom upgrade procedure for them.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

