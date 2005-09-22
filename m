Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030338AbVIVVJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030338AbVIVVJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 17:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbVIVVJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 17:09:56 -0400
Received: from vms048pub.verizon.net ([206.46.252.48]:2027 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S1030303AbVIVVJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 17:09:55 -0400
Date: Thu, 22 Sep 2005 17:09:53 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Linus GIT tree disappeared from http://www.kernel.org/git/?
In-reply-to: <BAYC1-PASMTP0225E685AD4FA9108A11B1AE970@CEZ.ICE>
To: linux-kernel@vger.kernel.org
Message-id: <200509221709.53482.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200509221514.44027.roffermanns@sysgo.com>
 <200509221212.01811.gene.heskett@verizon.net>
 <BAYC1-PASMTP0225E685AD4FA9108A11B1AE970@CEZ.ICE>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 September 2005 13:37, Sean wrote:
>On Thu, September 22, 2005 12:12 pm, Gene Heskett said:
>> Well, I think what I was trying to ask but got lost in the bushes was
>> "do I have a valid download?"  and, how do I go about keeping it upto
>> date now that I have it?  I've read about half the git.txt stuff in
>> the Documentation dir, but nothing sticks out as being the magic
>> updater command.
>
>Gene,
>
>In order to update your copy of the kernel repository just run "git
> pull". Unfortunately there still seem to be some issues with
> kernel.org, hopefully that'll be fixed up soon.
>
>The warning you're getting from git about "alternates" will be fixed in
>the next release of git.   You _could_ use your current version of git
> to track the official git repository and get this fix before it's
> officially released:
>
>$ cd ~
>$ git clone rsync://rsync.kernel.org/pub/scm/git/git.git/ git-repo
>$ cd git-repo
>$ git checkout
>$ make install
>
>Which should upgrade your current version of git to the very latest.
>After which you can upgrade git whenever you like by running:
>
>$ cd ~/git-repo
>$ git pull
>$ make install
>
>Cheers,
>Sean

Thanks, I've printed this, and as soon as BDI-4.29.iso is here so I
have some bandwidth, I'll give it a shot.  But I think I'll do it in
/usr/src rather than ~=/root.  Is that going to be a problem?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

