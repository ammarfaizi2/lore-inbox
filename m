Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275229AbRIZOZ7>; Wed, 26 Sep 2001 10:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275230AbRIZOZt>; Wed, 26 Sep 2001 10:25:49 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:17671 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S275229AbRIZOZl>; Wed, 26 Sep 2001 10:25:41 -0400
Date: Wed, 26 Sep 2001 16:25:59 +0200
From: Pavel Machek <pavel@suse.cz>
To: Rik van Riel <riel@conectiva.com.br>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Out of memory handling broken
Message-ID: <20010926162559.F7290@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20010926160306.D7290@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.33L.0109261106550.19147-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0109261106550.19147-100000@imladris.rielhome.conectiva>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> We swap something out.
> 
> But indeed, when the kernel needs memory for itself
> and no more memory is available, we'd crash. This is
> not something I've ever seen any system get close to,
> however...

Yep...

> > Okay, okay. Is there any solution (in 2.4.10) in doing what I want to
> > do?
> 
> GPF_ATOMIC and giving kswapd a chance to run whenever the
> atomic allocations fail ?

But how do I know when to stop? I'd have to place timeout there
:-(. How do I know no more memory is available?
								Pavel  
-- 
Causalities in World Trade Center: 6453 dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
