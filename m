Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314493AbSDXAhq>; Tue, 23 Apr 2002 20:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314497AbSDXAhp>; Tue, 23 Apr 2002 20:37:45 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:60862 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S314493AbSDXAho>; Tue, 23 Apr 2002 20:37:44 -0400
Date: Tue, 23 Apr 2002 20:37:43 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200204240037.g3O0bhT11578@devserv.devel.redhat.com>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BK, deltas, snapshots and fate of -pre...
In-Reply-To: <mailman.1019594711.6915.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > The well-defined resync points are the 2.5.N releases.  If -pre goes away,
>> > then the dot-releases might need to come a little closer together, that's all.
>> 
>> I agree.
>> 
>> I've told myself that I shouldn't have done "-preX" releases at all in
>> 2.5.x - the "real" numbers have become diluted by them, and I suspect the
>> -pre's are really just because I got used to making them during the
>> over-long 2.4.x time.
> 
> I believe -pre's are still important. Daily snapshots are too likely to be
> broken, and "real" releases are different from -pre ones (with *usefull*
> difference): you can ignore -pre release, but you can't ignore real release
> (because real releases are relative to each other).

Pavel, I think it is an delusion. In practical terms we have
a string of -pre and traditional releases which differ really
little in terms of reliability. I number of 2.5.x without -pre
fail to compile different non-core modules. 2.5.9 hangs on boot
on my machine, while -preX worked.

Marcelo pays more attention to stabilizing suffixless releases,
and as well he should. However, I do not see how this can
be meaningfuly done in 2.5.x. I am not going to shed any tears
over the demise of -pre in unstable series, provided that
releases get spaced tighter, with smaller patch size between them.

-- Pete
