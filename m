Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310806AbSD1RoE>; Sun, 28 Apr 2002 13:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313578AbSD1RoD>; Sun, 28 Apr 2002 13:44:03 -0400
Received: from bstnma1-ar1-4-64-205-250.bstnma1.elnk.dsl.genuity.net ([4.64.205.250]:30920
	"EHLO mail.spoofed.org") by vger.kernel.org with ESMTP
	id <S310806AbSD1Rn7>; Sun, 28 Apr 2002 13:43:59 -0400
Date: Sun, 28 Apr 2002 13:47:25 -0400
From: warchild@spoofed.org
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: remote memory reading using arp?
Message-ID: <20020428174725.GA5399@spoofed.org>
In-Reply-To: <20020427202756.GC6240@spoofed.org.suse.lists.linux.kernel> <3CCB0EAB.9050602@ixiacom.com.suse.lists.linux.kernel> <p73znzom2kv.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The driver should be fixed in that case. I would consider it a driver
> bug. The cost of clearing the tail should be minimal, it is at most
> two cache lines.
> 
> Is it known which driver caused this?

My testing yesterday was done with a Xircom RBEM58G-100 (10/100 + 56k) and an
Aironet PC4800 (with xircom_tulip_cb and airo/airo_cs, respectively).
Since this may be a driver problem, I should note that the airo drivers are
from pcmcia-cs-3.1.33.

 
> > This is NOT a "remote memory reading" exploit, since there is no way to
> 
> It really is. 

I'm finding it really difficult to replicate this problem today, but if I
find anything else that may be of use to help shed more light on this
issue, I'll be sure and share it.

thanks
