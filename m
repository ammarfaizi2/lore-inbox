Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030401AbWJKOJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030401AbWJKOJu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 10:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030408AbWJKOJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 10:09:49 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:14480 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1030401AbWJKOJs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 10:09:48 -0400
Message-ID: <452CFB29.4020200@drzeus.cx>
Date: Wed, 11 Oct 2006 16:09:45 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061004)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Sean <seanlkml@sympatico.ca>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Lennert Buytenhek <buytenh@wantstofly.org>,
       Dave Jones <davej@redhat.com>, David Miller <davem@davemloft.net>,
       jeff@garzik.org, davidsen@tmr.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 -mm merge plans
References: <45130533.2010209@tmr.com> <45130527.1000302@garzik.org> <20060921.145208.26283973.davem@davemloft.net> <20060921220539.GL26683@redhat.com> <20060922083542.GA4246@flint.arm.linux.org.uk> <20060922154816.GA15032@redhat.com> <Pine.LNX.4.64.0609220901040.4388@g5.osdl.org> <20060924074837.GB13487@xi.wantstofly.org> <20060924092010.GC17639@flint.arm.linux.org.uk> <20060924142353.6c725128.seanlkml@sympatico.ca> <20060924230948.GG12795@flint.arm.linux.org.uk> <BAYC1-PASMTP03A93CF0AD4CEACDC36DF0AE270@CEZ.ICE> <Pine.LNX.4.64.0609241741210.3952@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609241741210.3952@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> (Of course, once you get really used to git, you use git _anyway_, and 
> then you use cherry-pick and other tools to re-write a cleaned-up version 
> of the thing that you originally screwed up because you didn't know what 
> you were doing. So you _can_ do this too with git, but that doesn't mean 
> that git would necessarily be the best way to do it).
> 
> That said, maybe we could help the "fixup" phases evenmore using git. For 
> example, right now you can do "git cherry-pick" to transfer individual 
> patches, but if you want to combine two commits while cherry-picking, it 
> immediately gets more involved (still quite doable: use cherry-pick 
> multiple times with the "-n" flag, but it's not as obvious any more).
> 

Are there any docs (with examples) on how to work like this? I currently
use StGIT for my patch management, but that has some problems when it
comes to publishing my development tree for others.

Rgds
Pierre

