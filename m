Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289102AbSAUJV4>; Mon, 21 Jan 2002 04:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289103AbSAUJVr>; Mon, 21 Jan 2002 04:21:47 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:19907 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S289102AbSAUJVk>; Mon, 21 Jan 2002 04:21:40 -0500
Message-Id: <200201210921.g0L9LOeV001797@tigger.cs.uni-dortmund.de>
To: Matt <matt@progsoc.uts.edu.au>
cc: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>
Subject: Re: Possible Idea with filesystem buffering. 
In-Reply-To: Message from Matt <matt@progsoc.uts.edu.au> 
   of "Mon, 21 Jan 2002 11:10:05 +1100." <20020121111005.F12258@ftoomsh.progsoc.uts.edu.au> 
Date: Mon, 21 Jan 2002 10:21:23 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt <matt@progsoc.uts.edu.au> said:

[...]

> i know this sounds semi-evil, but can't you just drop another non
> dirty page and do a copy if you need the page you have been asked to
> write out? because if you have no non dirty pages around you'd
> probably have to drop the page anyway at some stage..

Better not. "Get rid of A", OK, copied to B. "Get rid of B", OK, copied to
C. Lather. Rinse. Repeat.
-- 
Horst von Brand			     http://counter.li.org # 22616
