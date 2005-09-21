Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbVIUSb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbVIUSb5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 14:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbVIUSb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 14:31:57 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:32262 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751359AbVIUSb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 14:31:56 -0400
Message-ID: <4331A65B.90103@tmr.com>
Date: Wed, 21 Sep 2005 14:28:43 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sean <seanlkml@sympatico.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: Arrr! Linux v2.6.14-rc2
References: <Pine.LNX.4.58.0509192003410.2553@g5.osdl.org>    <200509201005.49294.gene.heskett@verizon.net>    <20050920141008.GA493@flint.arm.linux.org.uk>    <200509201025.36998.gene.heskett@verizon.net> <BAYC1-PASMTP04AB35B0A82E89B341AB0BAE950@cez.ice>
In-Reply-To: <BAYC1-PASMTP04AB35B0A82E89B341AB0BAE950@cez.ice>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean wrote:
> On Tue, September 20, 2005 10:25 am, Gene Heskett said:
> 
> 
>>Humm, what are they holding out for, more ram or more cpu?:-)
>>
>>FWIW, http://master.kernel.org doesn't show it either just now.
> 
> 
> Gene,
> 
> While kernel.org snapshots will no doubt be working again shortly, you
> might want to consider using git.  It reduces the amount you have to
> download for each release a lot.
> 
> It's really easy to grab a copy of git and use it to grab the kernel:
> 
> mkdir kernel
> cd kernel
> wget http://kernel.org/pub/software/scm/git/git-core-0.99.7.tar.bz2
> tar -xvjf git-core-0.99.7.tar.bz2
> cd git-core-0.99.7
> make install
> cd ..
> 
> git clone \
> rsync://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git \
> linux
> 
> cd linux
> git checkout
> 
> 
> The above is given as an attachment as well because of annoying word wrap
> issues with the long url's.   Anyway, after that you can stay current with
> the latest Linus release with a simple  "git pull".

But that pulls the current tree, doesn't it? Not the git release?

For purposes of bug reporting and fixing, I would think that having some 
reproducible version is superior. If I say git3, anyone can get it, it 
would appear that "git pull" isn't as deterministic.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
