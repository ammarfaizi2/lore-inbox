Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965119AbVITU6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965119AbVITU6E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 16:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965120AbVITU6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 16:58:03 -0400
Received: from vms040pub.verizon.net ([206.46.252.40]:53144 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S965119AbVITU6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 16:58:03 -0400
Date: Tue, 20 Sep 2005 16:57:59 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Arrr! Linux v2.6.14-rc2
In-reply-to: <BAYC1-PASMTP04AB35B0A82E89B341AB0BAE950@cez.ice>
To: linux-kernel@vger.kernel.org
Message-id: <200509201657.59407.gene.heskett@verizon.net>
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
check
>cd kernel
check
>wget http://kernel.org/pub/software/scm/git/git-core-0.99.7.tar.bz2
check
>tar -xvjf git-core-0.99.7.tar.bz2
check
>cd git-core-0.99.7
check
>make install
check
>cd ..
>
>git clone \
>rsync://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git \
>linux

Well, things marched right along till I got to the line for git clone
etc.

[root@coyote kernel]# git clone
rsync://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
linux
bash: git: command not found

Humm, back up & find it put git stuff in /root/bin  ?????

[root@coyote kernel]# /root/bin/git clone \
rsync://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
 linux
/root/bin/git-clone: line 2: git-init-db: command not found
* git clone [-l [-s]] [-q] [-u <upload-pack>] <repo> <dir>

So why did it put it in /root/bin?  It's there, but not in my $PATH.
And theres no "make uninstall" to clean up the install so I might be
able to cleanly fix the miss-fire...  Murphy rides again..

[...]

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

