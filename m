Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265370AbUEZJAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265370AbUEZJAN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 05:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265369AbUEZJAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 05:00:13 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:1920 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265373AbUEZI7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 04:59:55 -0400
Date: Wed, 26 May 2004 10:06:58 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200405260906.i4Q96wgx000663@81-2-122-30.bradfords.org.uk>
To: Anthony DiSante <orders@nodivisions.com>, linux-kernel@vger.kernel.org
In-Reply-To: <40B43B5F.8070208@nodivisions.com>
References: <40B43B5F.8070208@nodivisions.com>
Subject: Re: why swap at all?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Anthony DiSante <orders@nodivisions.com>:
> As a general question about ram/swap and relating to some of the issues in 
> this thread:
> 
> 	~500 megs cached yet 2.6.5 goes into swap hell
> 
> Consider this: I have a desktop system with 256MB ram, so I make a 256MB 
> swap partition.  So I have 512MB "memory" and if some process wants more, 
> too bad, there is no more.
> 
> Now I buy another 256MB of ram, so I have 512MB of real memory.  Why not 
> just disable my swap completely now?  I won't have increased my memory's 
> size at all, but won't I have increased its performance lots?
> 
> Or, to make it more appealing, say I initially had 512MB ram and now I have 
> 1GB.  Wouldn't I much rather not use swap at all anymore, in this case, on 
> my desktop?

In my experience, it's perfectly possible to run a typical desktop system with
no swap at all.  Certainly the 'double the amount of physical RAM' guideline
has been taken far too literally in my opinion.

As you point out, if a typical system works fine with 512 Mb of storage, it
shouldn't matter what the mix of physical and virtual memory is.  Of course,
it will make a difference to performance, and there is a minimum practical
amount of real RAM because some things are unswapable, but in my opinion it
is absolutely wrong to size swap partitions simply by looking at the amount of 
physical RAM in a system and not considering the requirements of the workload.

Double the physical RAM is usually more than enough these days, and because
most of the time the negative effects of too little swap are more noticable
than too much swap, this 'rule' seems to work well enough.

See my recent posts in another thread about solving computing problems by
learning solutions to common scenarios and not learning about computers in a
generic way - in my opinion, the widespread inefficiency of swap space is a
classic example of how this simply doesn't work very well.

Instead of trying to work out how much swap space is needed for a particular
hardware configuation, I suggest that users look at the workload first.

Infact, it's generally sensible to think about the workload before buying any
hardware.

John.
