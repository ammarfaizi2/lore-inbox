Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283159AbRLDPJj>; Tue, 4 Dec 2001 10:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283206AbRLDPI7>; Tue, 4 Dec 2001 10:08:59 -0500
Received: from mail.zmailer.org ([194.252.70.162]:15878 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S283072AbRLDPGX>;
	Tue, 4 Dec 2001 10:06:23 -0500
Date: Tue, 4 Dec 2001 17:06:08 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Ragnar Hojland Espinosa <ragnar@ragnar-hojland.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is lkml dead?
Message-ID: <20011204170608.J1020@mea-ext.zmailer.org>
In-Reply-To: <20011203183504Z284933-752+4718@vger.kernel.org> <20011203224329.B11176@ragnar-hojland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011203224329.B11176@ragnar-hojland.com>; from ragnar@ragnar-hojland.com on Mon, Dec 03, 2001 at 10:43:29PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2001 at 10:43:29PM +0100, Ragnar Hojland Espinosa wrote:
> On Mon, Dec 03, 2001 at 08:35:04PM +0100, Hans-Christian Armingeon wrote:
> 
>   Seems that its hickuping a bit..

  I would say "that is an understatement"...

  For several good reasons there has been an attempt at renumbering
  vger into an alternate address space.   That project, however, did
  yield massive amounts of DNS lookups failing in a way which did
  yield "NO ERROR" status, but also no data at all.

  Moving vger back to old address failed partially too, and it took
  serious gymnastics to sort things out again.


  The situation motivating for such drastic operation of renumbering
  is that some systems consider it right and proper to reject email
  just because DNS lookup does timeout somehow on them (no attempt
  of yielding 400-series error codes).

  Some people (a LOT of people) seem to think that it is right and proper
  to analyze the parameter value given to the EHLO/HELO greeting verb.
  ISP's know that they just can't do that, world is full broken MUAs
  (for some reason, usually at M$ systems) which are trying to submit
  email via ISP hubs..   Spam-spewers usually do get that part correctly.

  Some people seem to think that it is proper to even imagine of analyzing
  that the SMTP client's IP address has working DNS reverser entry.
  (Combine that with a failure to handle timeouts..)


> -- 
> ____/|  Ragnar Højland      Freedom - Linux - OpenGL |    Brainbench MVP
> \ o.O|  PGP94C4B2F0D27DE025BE2302C104B78C56 B72F0822 | for Unix Programming
>  =(_)=  "Thou shalt not follow the NULL pointer for  | (www.brainbench.com)
>    U     chaos and madness await thee at its end."

/Matti Aarnio  co-postmaster at vger.kernel.org
