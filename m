Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281255AbRL0OIw>; Thu, 27 Dec 2001 09:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281458AbRL0OIm>; Thu, 27 Dec 2001 09:08:42 -0500
Received: from adsl-64-109-89-110.chicago.il.ameritech.net ([64.109.89.110]:47192
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S281255AbRL0OIb>; Thu, 27 Dec 2001 09:08:31 -0500
Message-Id: <200112271408.fBRE84d19791@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Rik van Riel <riel@conectiva.com.br>
cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH: NEW ARCHITECTURE FOR 2.5] support for NCR voyager 
 343x/345x/4100/51xx architecture
In-Reply-To: Message from Rik van Riel <riel@conectiva.com.br> 
   of "Sun, 23 Dec 2001 22:58:05 -0200." <Pine.LNX.4.33L.0112232256180.12081-100000@imladris.surriel.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 27 Dec 2001 08:08:03 -0600
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

riel@conectiva.com.br said:
> One thing which worries me is that the number of these machines is
> very small, so the code could temporarily go the way the SGI visws
> code went. 

> It would be nice if this code was split out in such a way that it
> won't have any impact on the maintainability of the mainstream code,
> so even if the voyager folks go on holiday, normal Linux development
> can continue and the resulting bitrot will be limited to just the
> voyager code. 

I would like to do this.  I didn't do it for the 2.4 series because such a 
patch would have been very difficult to maintain.  I'll see if I can separate 
the VISW code as well.

James


