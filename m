Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136792AbREBCXI>; Tue, 1 May 2001 22:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136788AbREBCW6>; Tue, 1 May 2001 22:22:58 -0400
Received: from femail2.sdc1.sfba.home.com ([24.0.95.82]:47096 "EHLO
	femail2.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S136590AbREBCWs>; Tue, 1 May 2001 22:22:48 -0400
Message-ID: <3AEF6F71.A75D478F@home.com>
Date: Tue, 01 May 2001 19:22:41 -0700
From: Seth Goldberg <bergsoft@home.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: DISCOVERED! Cause of Athlon/VIA KX133 Instability
In-Reply-To: <Pine.LNX.4.10.10105011558310.17091-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn wrote:
> 
> >   And that's exactly what I did :)...  I found that ONLY the combination
> > of USE_3DNOW and forcing the athlon mmx stuff in (by doing #if 1 in
> > results in this wackiness.  I should alos repeat that I *DO* see that
> 
> I doubt that USE_3DNOW is causing the problem, but rather when you
> USE_3DNOW, the kernel streams through your northbridge at roughly
> twice the bandwidth.  if your dram settings are flakey, this could
> eaily trigger a problem.
> 
> this has nothing to do with the very specific disk corruption
> being discussed (which has to do with the ide controller, according
> to the most recent rumors.).

  Actually, I think there are 2 problems that have been discussed -- the
disk corruption and a general instability resulting in oops'es at
various points shortly after boot up.

  My memory system jas been set up very conservitavely and has been
rock solid in my other board (ka7), so I doubt it's that, but I
sure am happy to try a few more cominations of bios settings.  Anything
I should look for in particular?

  Thanks,
   Seth

> 
> >   The other thing i was gunna try is to dump my chipset registers using
> > WPCREDIT and WPCRSET and compare them with other people on this list
> 
> why resort to silly windows tools, when lspci under Linux does it for you?
> 
> regards, mark hahn.
> 

  Because lspci does not display all 256 bytes of pci configuration
information.


  --S
