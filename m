Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262255AbVAEFt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262255AbVAEFt0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 00:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbVAEFt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 00:49:26 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:39437 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262255AbVAEFtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 00:49:22 -0500
Date: Wed, 5 Jan 2005 06:37:01 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Thomas Graf <tgraf@suug.ch>,
       Bill Davidsen <davidsen@tmr.com>, Adrian Bunk <bunk@stusta.de>,
       Diego Calleja <diegocg@teleline.es>, wli@holomorphy.com,
       aebr@win.tue.nl, solt2@dns.toxicfilms.tv
Subject: Re: starting with 2.7
Message-ID: <20050105053701.GB24263@alpha.home.local>
References: <20050104031229.GE26856@postel.suug.ch> <20050104211910.GB7280@thunk.org> <20050104214324.GG22075@alpha.home.local> <200501041850.20446.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501041850.20446.gene.heskett@verizon.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 06:50:20PM -0500, Gene Heskett wrote:
> I disagree Willy, if I see an -rc candidate, even if I'm following an 
> interesting thread, like Ingo's patches, the rc will get built and 
> run here, precisely so I can bitch if it doesn't work.  I have an 
> idea there are more like me who are interested as much in whats *new* 
> as in how well does it run *my* stuff, and that you may possibly be 
> undercounting us...

I do this too when I have time, but basically, the number of testers
is limited to a small percent of the amount of LKML readers. This is
why I say it does not get tested on a large scale. Seeing that even
slashdot announces new releases, I suspect that releases are tested
by 10 or 100 times more users than -rc. If we spend too much time
waiting for a few hundred people to test -rc, it is with great deception
that we discover that obvious bugs go to the final release unnoticed,
like the NFS problem on 2.6.8 which hit me on the first boot. OK, I
would have seen it in -rc, but I didn't have time to test -rc this
time, and nobody else did enough testing on it. Result, -rc did not
serve to catch this obvious one. I agree that a very few days should
be better than absolutely nothing, at least to catch build problems,
but we should not wait too long.

Cheers,
Willy

