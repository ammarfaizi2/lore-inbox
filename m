Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132186AbRDTXxq>; Fri, 20 Apr 2001 19:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132226AbRDTXxj>; Fri, 20 Apr 2001 19:53:39 -0400
Received: from stanis.onastick.net ([207.96.1.49]:28426 "EHLO
	stanis.onastick.net") by vger.kernel.org with ESMTP
	id <S132186AbRDTXxC>; Fri, 20 Apr 2001 19:53:02 -0400
Date: Fri, 20 Apr 2001 19:52:53 -0400
From: Disconnect <lkml@sigkill.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Athlon problem report summary
Message-ID: <20010420195253.A20176@sigkill.net>
In-Reply-To: <E14p894-00009E-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14p894-00009E-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Addendum to 1. So far everyone (at least on LKML) who has had the
crash-immediatly-do-not-pass-go issues has been using an iwill kk266 (or
kk266r, IIRC) mobo.

Have we gotten any fix, other than not using K7 optimizations?

I'm willing to keep trying new patches, if necessary.  (And for that
matter, the box is on dialup behind masq, but if you are interested I can
set up an account.  No serial console, no remote power cycle, so I'm not
sure how much good it'll do, but it's an option if you want/need it.)

On Mon, 16 Apr 2001, Alan Cox did have cause to say:

> There appear to be two common threads to this
> 
> 1.  'It runs if I don't use Athlon optimisations'
> 
> This one is compiler independant. It seems to be unrelated to obvious 
> candidates like vesafb. It isnt related to CPU version. Every victim has a 
> VIA chipset machine.
> 
> 
> 2.  'My athlon box is fine until I am swapping' {and using DMA}
> 
> Compiler independant, CPU version independant. All victims have a VIA chipset.
> This one may be linked to the reported problems with VIA PCI. Two of the 
> reporters found disabling IDE DMA fixed this one
> 
> 
> Nobody using an AMD chipset has reported either problem.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
---
   _.-=<Disconnect>=-._
|     dis@sigkill.net    | And Remember...
\  shawn@healthcite.com  / He who controls Purple controls the Universe..
 PGP Key given on Request  Or at least the Purple parts!

-----BEGIN GEEK CODE BLOCK-----
Version: 3.1 [www.ebb.org/ungeek]
GIT/CC/CM/AT d--(-)@ s+:-- a-->? C++++$ ULBS*++++$ P+>+++ L++++>+++++ 
E--- W+++ N+@ o+>$ K? w--->+++++ O- M V-- PS+() PE Y+@ PGP++() t 5--- 
X-- R tv+@ b++++>$ DI++++ D++(+++) G++ e* h(-)* r++ y++
------END GEEK CODE BLOCK------
