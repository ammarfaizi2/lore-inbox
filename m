Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263031AbVCDTVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263031AbVCDTVl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 14:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263023AbVCDTRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 14:17:55 -0500
Received: from mailwasher.lanl.gov ([192.65.95.54]:5335 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S262999AbVCDTHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 14:07:41 -0500
Message-ID: <4228B1EB.4040503@mesatop.com>
Date: Fri, 04 Mar 2005 12:07:23 -0700
From: Steven Cole <elenstev@mesatop.com>
User-Agent: Thunderbird 1.0 (Multics)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jens Axboe <axboe@suse.de>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
References: <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org> <422751C1.7030607@pobox.com> <20050303181122.GB12103@kroah.com> <20050303151752.00527ae7.akpm@osdl.org> <20050303234523.GS8880@opteron.random> <20050303160330.5db86db7.akpm@osdl.org> <20050304025746.GD26085@tolot.miese-zwerge.org> <20050303213005.59a30ae6.akpm@osdl.org> <1109924470.4032.105.camel@tglx.tec.linutronix.de> <20050304005450.05a2bd0c.akpm@osdl.org> <20050304091612.GG14764@suse.de> <20050304012154.619948d7.akpm@osdl.org> <Pine.LNX.4.58.0503040956420.25732@ppc970.osdl.org> <4228A9B9.4060308@pobox.com>
In-Reply-To: <4228A9B9.4060308@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.0.111621
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Linus Torvalds wrote:
> 
>> I've long since decided that there's no point to making "-pre". What's 
>> the difference between a "-pre" and a daily -bk snapshot? Really?
> 
> 
> Several non-BK developers use the first -rc1 as a merge point.
> 
> Others simply trust that _Linus_ has a lot more smarts than an automated 
> script, about deciding when a good testing point should occur.  Holy 
> Penguin Pee has value, they feel.
> 
> 
>> So when I do a release, it _is_ an -rc. The fact that people have 
>> trouble understanding this is not _my_ fault.
> 
> 
> If you want people to start testing, a good first step would be 
> understanding why this is so.
> 
> Users have been trained that -rc means "serious bugfixes only".  You are 
> trying to re-train them.  That just won't work.
> 
> When you do an -rc1 or -rc2, it is not serious bugfixes only. 
> _Especially_ rc1.  rc1 is in no way "bugfixes only."  Non-BK developers 
> just treat the first couple -rc's as a merge point, while the rest of us 
> BK developers have already gone into "send bugfixes only" mode.
> 
> You are fighting an uphill battle against user perceptions and training.
> 
>     Jeff
> 

Here's an idea which might just be too simple, but here it is anyway:

Modifiy the bk snapshot scripts to name the 2.6.x series snapshots as -PREy
instead of -BKy.  That way, the general population of users will see
the -bk snapshots as -pre releases.  According to Linus, pre == bk.  So,
name them as such.

Linus, wait for at least two weeks before releasing the first -rc.
That way, the bulk on the thundering herd of patches will be hopefully
be merged by then.  And users will have 2.6.x-PRE[1..14] to test.
The hard part for the kernel.org script writer might be to disable
the -bk/-pre snapshot once the first -rc is out.

Since your _intent_ is that an -rc really be an -rc, make it so.  It
shouldn't take more than a release or two to train the maintainers
that the post-2.6.11 -rc's are _really_ release candidates.

Steven

