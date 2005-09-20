Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965123AbVITVj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965123AbVITVj7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 17:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbVITVj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 17:39:59 -0400
Received: from vms046pub.verizon.net ([206.46.252.46]:23256 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S1750770AbVITVj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 17:39:58 -0400
Date: Tue, 20 Sep 2005 17:39:54 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Arrr! Linux v2.6.14-rc2
In-reply-to: <BAYC1-PASMTP04AB35B0A82E89B341AB0BAE950@cez.ice>
To: linux-kernel@vger.kernel.org
Message-id: <200509201739.55208.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.58.0509192003410.2553@g5.osdl.org>
 <200509201025.36998.gene.heskett@verizon.net>
 <BAYC1-PASMTP04AB35B0A82E89B341AB0BAE950@cez.ice>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 September 2005 11:20, Sean wrote:
>On Tue, September 20, 2005 10:25 am, Gene Heskett said:
>> Humm, what are they holding out for, more ram or more cpu?:-)
>>
>> FWIW, http://master.kernel.org doesn't show it either just now.
>
>Gene,
>
>While kernel.org snapshots will no doubt be working again shortly, you
>might want to consider using git.  It reduces the amount you have to
>download for each release a lot.
>
>It's really easy to grab a copy of git and use it to grab the kernel:
>
>mkdir kernel
>cd kernel
>wget http://kernel.org/pub/software/scm/git/git-core-0.99.7.tar.bz2
>tar -xvjf git-core-0.99.7.tar.bz2
>cd git-core-0.99.7
>make install
>cd ..
>
>git clone \
>rsync://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git \
>linux
>
>cd linux
>git checkout
>
>
>The above is given as an attachment as well because of annoying word
> wrap issues with the long url's.   Anyway, after that you can stay
> current with the latest Linus release with a simple  "git pull".
>
>Cheers,
>Sean

Ok, once all thats done, then anytime I want a snapshot, go there and
do a git checkout, then snapshot copy that dir to
/usr/src/linux-$VERSION, copy the old .config in to this copy, add my
build scripts and go?  Anyway, I've just done the above, so we'll
test it out right now.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

