Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbVJaD4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbVJaD4S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 22:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbVJaD4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 22:56:18 -0500
Received: from warden2-p.diginsite.com ([209.195.52.120]:47031 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S1751329AbVJaD4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 22:56:17 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <Pine.LNX.4.64.0510291229330.3348@g5.osdl.org>
References: <20051029182228.GA14495@havoc.gtf.org> <20051029121454.5d27aecb.akpm@osdl.org><4363CB60.2000201@pobox.com> <Pine.LNX.4.64.0510291229330.3348@g5.osdl.org>
Date: Sun, 30 Oct 2005 19:55:40 -0800 (PST)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: [git patches] 2.6.x libata updates
In-Reply-To: <Pine.LNX.4.64.0510291229330.3348@g5.osdl.org>
Message-ID: <Pine.LNX.4.62.0510301952550.16065@qynat.qvtvafvgr.pbz>
References: <20051029182228.GA14495@havoc.gtf.org>
 <20051029121454.5d27aecb.akpm@osdl.org><4363CB60.2000201@pobox.com>
 <Pine.LNX.4.64.0510291229330.3348@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Oct 2005, Linus Torvalds wrote:

> On Sat, 29 Oct 2005, Jeff Garzik wrote:
>>
>> Even so, it's easy, to I'll ask him to test 2.6.14, 2.6.14-git1, and
>> (tonight's upcoming) 2.6.14-git2 (with my latest pull included) to see if
>> anything breaks.
>
> Side note: one of the downsides of the new "merge lots of stuff early in
> the development series" approach is that the first few daily snapshots end
> up being _huge_.
>
> So the -git1 and -git2 patches are/will be very big indeed.
>
> For example, patch-2.6.14-git1 literally ended up being a megabyte
> compressed. Right now my diff to 2.6.14 (after just two days) is 1.6MB
> compressed.
>
> Admittedly, some of it is due to things like the MIPS merge, but the point
> I'm trying to make is that it makes the daily snapshot diffs a lot less
> useful to people who try to figure out where something broke.
>
> Now, I've gotten several positive comments on how easy "git bisect" is to
> use, and I've used it myself, but this is the first time that patch users
> _really_ become very much second-class citizens, and you can't necessarily
> always do useful things with just the tar-trees and patches. That's sad,
> and possibly a really big downside.
>
> Don't get me wrong - I personally think that the new merge policy is a
> clear improvement, but it does have this downside.
>
> 			Linus

how about setting up something on a webserver (ideally kernel.org) to do 
the git bisect and output patches against the daily snapshots.

if a lot of people used it the load would be an issue, but if it's only 
used by a relativly few people tracking down bugs it's probably worth it.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
