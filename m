Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286183AbRLJHvn>; Mon, 10 Dec 2001 02:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286184AbRLJHve>; Mon, 10 Dec 2001 02:51:34 -0500
Received: from bitmover.com ([192.132.92.2]:44962 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S286183AbRLJHv1>;
	Mon, 10 Dec 2001 02:51:27 -0500
Date: Sun, 9 Dec 2001 23:51:26 -0800
From: Larry McVoy <lm@bitmover.com>
To: David Lang <david.lang@digitalinsight.com>
Cc: Larry McVoy <lm@bitmover.com>, Stevie O <stevie@qrpff.net>,
        linux-kernel@vger.kernel.org
Subject: Re: "Colo[u]rs"
Message-ID: <20011209235126.J25754@work.bitmover.com>
Mail-Followup-To: David Lang <david.lang@digitalinsight.com>,
	Larry McVoy <lm@bitmover.com>, Stevie O <stevie@qrpff.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011209232859.I25754@work.bitmover.com> <Pine.LNX.4.40.0112092319020.4915-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.40.0112092319020.4915-100000@dlang.diginsite.com>; from david.lang@digitalinsight.com on Sun, Dec 09, 2001 at 11:21:23PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2001 at 11:21:23PM -0800, David Lang wrote:
> Larry, I thought that direct mapped caches had full mapping from any cache
> address to any physical address while the N-way mapped caches were more
> limited. modern caches are N-way instead of direct mapped becouse it's
> much more expensive (transistor count wise) for the direct mapped
> approach.

That's not correct unless they changed terminology without asking my 
permission :-)  A direct mapped cache is the same as a 1-way set
associative cache.  It means each cache line has one and only one 
place it can be in the cache.  It also means there is only one set
of tag comparitors, which makes it cheaper and easier to build.

> If I'm mistaken about my termonology (very possible :-) what is the term
> for what I am refering to as direct mapped?

Fully associative cache, I believe.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
