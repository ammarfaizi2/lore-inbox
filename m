Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129378AbQKBV1g>; Thu, 2 Nov 2000 16:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129519AbQKBV10>; Thu, 2 Nov 2000 16:27:26 -0500
Received: from ra.lineo.com ([204.246.147.10]:32164 "EHLO thor.lineo.com")
	by vger.kernel.org with ESMTP id <S129378AbQKBV1P>;
	Thu, 2 Nov 2000 16:27:15 -0500
Message-ID: <3A01DADB.9EB34BA0@Rikers.org>
Date: Thu, 02 Nov 2000 14:21:31 -0700
From: Tim Riker <Tim@Rikers.org>
Organization: Riker Family (http://rikers.org/)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@caldera.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: non-gcc linux?
In-Reply-To: <200011022106.WAA18428@ns.caldera.de>
X-MIMETrack: Serialize by Router on thor/Lineo(Release 5.0.5 |September 22, 2000) at 11/02/2000
 02:27:11 PM,
	Serialize complete at 11/02/2000 02:27:11 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do you or anyone else on the list recall why this decision was made? Can
you recall around when it was made so I can dig out the history from the
archives?

I would be eager to convert everything over to the C99 syntax, test the
heck out of it and submit the patch. Obviously this is wasted effort if
there is a good reason to continue using the gcc syntax.

Christoph Hellwig wrote:
> 
> In article <3A01D463.9ADEF3AF@Rikers.org> you wrote:
> > As is being discussed here, C99 has some replacements to the gcc syntax
> > the kernel uses. I believe the C99 syntax will win in the near future,
> > and thus the gcc syntax will have to be removed at some point. In the
> > interim the kernel will either move towards supporting both, or a
> > quantum jump to support the new gcc3+ compiler only. I am hoping a
> > little thought can get put into this such that this change will be less
> > painful down the road.
> 
> BTW: the C99 syntax for named structure initializers is supported from
> gcc 2.7.<something> on. But a policy decision has been take to use
> gcc syntax in kernel.

-- 
Tim Riker - http://rikers.org/ - short SIGs! <g>
All I need to know I could have learned in Kindergarten
... if I'd just been paying attention.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
