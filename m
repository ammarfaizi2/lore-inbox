Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318138AbSHIC6p>; Thu, 8 Aug 2002 22:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318139AbSHIC6p>; Thu, 8 Aug 2002 22:58:45 -0400
Received: from dsl-213-023-043-103.arcor-ip.net ([213.23.43.103]:15493 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318138AbSHIC6o>;
	Thu, 8 Aug 2002 22:58:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Jesse Barnes <jbarnes@sgi.com>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: [PATCH] lock assertion macros for 2.5.30
Date: Fri, 9 Aug 2002 05:04:17 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, jmacd@namesys.com, rml@tech9.net
References: <20020807221532.GA20469@sgi.com> <Pine.LNX.4.44L.0208071918440.23404-100000@imladris.surriel.com> <20020808172335.GA29509@sgi.com>
In-Reply-To: <20020808172335.GA29509@sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17d04X-0000eD-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 August 2002 19:23, Jesse Barnes wrote:
> On Wed, Aug 07, 2002 at 07:19:21PM -0300, Rik van Riel wrote:
> > Looks good to me. Would be even better if you removed MUST_NOT_HOLD ;)
> 
> Ok, here's yet another version.  I've removed the conversion of the
> scsi layer's ASSERT_LOCK macros as well as the silly version of
> MUST_NOT_HOLD.  Other things people seem interested in:
>   o sleeping function assertions
>   o lock ordering enforcement
>   o lock recursion detection
>   o more assertion checks in other parts of the kernel
> 
> Should any of the above be included in this patch?

You would just have to break the patch up again when you submit it.  You
might want create a patch that demonstrates its usage, by adding some
asserts to core code and removing comments where the assert makes them
redundant.

> If so, I can try
> to hack one or more of them together, otherwise maybe this is ok to go
> in?

It's looking good.

-- 
Daniel
