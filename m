Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264359AbRFHVeO>; Fri, 8 Jun 2001 17:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264352AbRFHVeE>; Fri, 8 Jun 2001 17:34:04 -0400
Received: from moline.gci.com ([205.140.80.106]:13320 "EHLO moline.gci.com")
	by vger.kernel.org with ESMTP id <S264340AbRFHVd5>;
	Fri, 8 Jun 2001 17:33:57 -0400
Message-ID: <BF9651D8732ED311A61D00105A9CA315053E0AFB@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: "L. K." <lk@Aniela.EU.ORG>, linux-kernel@vger.kernel.org
Subject: RE: temperature standard - global config option?
Date: Fri, 8 Jun 2001 13:33:44 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: L. K. [mailto:lk@Aniela.EU.ORG]
> I really do not belive that for a CPU or a motherboard +- 1 
> degree would make any difference.

You haven't pushed your system, or run it in a hostile
environment then.  There are many places where systems are run
right up to the edge of thermal breakdown, and it's a firm
requirement to know exactly what that edge is.

 
> If a CPU runs fine at, say, 37 degrees C, I do not belive it 
> will have any problems running at 38 or 36 degrees. I support
> the ideea of having very good sensors for temperature
> monitoring, but CPU and motherboard temperature do not depend
> on the rise of the temperature of 1 degree, but when the
> temperature rises 10 or more degrees. I hope you understand
> what I want to say.

I have a CPU that runs great up to 43C, and shuts down hard at 44C
so I obviously want to know how close I am to that.  I don't want
rounding errors to get in the way, and I don't want changes
between kernel revs to affect it either.

If we've got the bitspace, keep the counters as granular as
possible within the useable range that we're designing for.

counter = .01 * degrees kelvin


