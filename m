Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266209AbUHGB0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266209AbUHGB0T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 21:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266211AbUHGB0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 21:26:19 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:28649 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266209AbUHGB0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 21:26:18 -0400
Date: Sat, 7 Aug 2004 03:26:15 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andi Kleen <ak@muc.de>
Cc: Tim Bird <tim.bird@am.sony.com>, linux-kernel@vger.kernel.org
Subject: Re: Is extern inline -> static inline OK?
Message-ID: <20040807012614.GC17708@fs.tum.de>
References: <2q0Wb-2Tc-17@gated-at.bofh.it> <2q1pe-3hq-17@gated-at.bofh.it> <2qlo1-wO-37@gated-at.bofh.it> <m3657vj1bn.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3657vj1bn.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 07, 2004 at 01:26:04AM +0200, Andi Kleen wrote:
> Tim Bird <tim.bird@am.sony.com> writes:
> >
> >  From what I have read, for either 'extern inline' or 'static inline'
> > the compiler is free to not inline the code. Is this wrong?
> 
> Yes, it's wrong in current Linux 2.6. It currently defines inline to
> inline __attribute__((always_inline))
>...

To be more exact:

It's defined this way in both 2.4 and 2.6, but only for gcc >= 3.1 
(which support __attribute__((always_inline)) ).

> Hope this helps,
> 
> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

