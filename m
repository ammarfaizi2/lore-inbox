Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbVIUQvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbVIUQvG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 12:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbVIUQvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 12:51:06 -0400
Received: from vms040pub.verizon.net ([206.46.252.40]:55551 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751155AbVIUQvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 12:51:04 -0400
Date: Wed, 21 Sep 2005 12:50:25 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Arrr! Linux v2.6.14-rc2
In-reply-to: <BAYC1-PASMTP04AB35B0A82E89B341AB0BAE950@cez.ice>
To: linux-kernel@vger.kernel.org
Message-id: <200509211250.25356.gene.heskett@verizon.net>
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

What is the lifetime of this script?  The reason I am asking is that
somehow, the 'linux' directory got emptied when I used mc to make a
copy of it to /usr/src/linux-2.6.14-rc2, which then built just fine
and I'm running it.

But editing the script so that it only does the stuff from the rsync
line on, I have not been able to duplicate its flawless performance,
instead getting this near the end of the proceedure:
------
[...]
tags/v2.6.14-rc2

sent 563 bytes  received 2778 bytes  954.57 bytes/sec
total size is 779  speedup is 0.23
rsync: link_stat
"/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/info/alternates"
(in pub) failed: No such file or directory (2)
rsync error: some files could not be transferred (code 23) at
main.c(812)
------

I have now re-ran this 4 times, each time doing an rm -fR on the
'linux' directory, with the same results as above each time.

Is this normal, or am I missing something important (and probably
a 'duh' moment too) that it takes to do a re-run?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

