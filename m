Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274081AbRISOzC>; Wed, 19 Sep 2001 10:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274082AbRISOyw>; Wed, 19 Sep 2001 10:54:52 -0400
Received: from app79.hitnet.RWTH-Aachen.DE ([137.226.181.79]:19219 "EHLO
	moria.gondor.com") by vger.kernel.org with ESMTP id <S274081AbRISOym>;
	Wed, 19 Sep 2001 10:54:42 -0400
Date: Wed, 19 Sep 2001 16:55:03 +0200
From: Jan Niehusmann <jan@gondor.com>
To: Liakakis Kostas <kostas@skiathos.physics.auth.gr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re[2]: [PATCH] Athlon bug stomper. Pls apply.
Message-ID: <20010919165503.A16359@gondor.com>
In-Reply-To: <20010919154701.A7381@stud.ntnu.no> <Pine.GSO.4.21.0109191707260.23205-100000@skiathos.physics.auth.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0109191707260.23205-100000@skiathos.physics.auth.gr>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 05:31:36PM +0300, Liakakis Kostas wrote:
> It seems to fix the stability problem. We don;t know why, but
> experimetation shows that those _with_ the problem are relieved. This is
> fine! We are happy with it.
> 
> We write to a register marked as "don't write" by Via. This is potentialy 
> dangerous in ways we don't know yet.

Additionally, look at who tested the 'fix' up to now: Probably only
people who had a problem before. And for all of them, the problem got
fixed. But do we know what happens if we use this 'fix' on a computer
that is not broken? No. Perhaps it breaks when we apply the 'fix'?

OTOH, I think there are only two ways to find out: Either we put the
'fix' into a mainline kernel (linux -pre kernel or -ac kernel should
be enough) as a default and look if somebody starts complaining, or
we convince VIA to tell us what the register in question really does.

Jan

