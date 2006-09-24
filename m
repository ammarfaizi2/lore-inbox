Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750904AbWIXTEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbWIXTEM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 15:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbWIXTEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 15:04:12 -0400
Received: from pas38-1-82-67-71-117.fbx.proxad.net ([82.67.71.117]:40868 "EHLO
	siegfried.gbfo.org") by vger.kernel.org with ESMTP id S1750904AbWIXTEL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 15:04:11 -0400
Date: Sun, 24 Sep 2006 21:05:09 +0200 (CEST)
From: Jean-Marc Saffroy <saffroy@gmail.com>
X-X-Sender: saffroy@erda.mds
To: Lee Revell <rlrevell@joe-job.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: oops in :snd_pcm_oss:resample_expand+0x19c/0x1f0
In-Reply-To: <260d3bff0609241104o65218c3bwc59aef94eddbca53@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0609242018150.4838@erda.mds>
References: <Pine.LNX.4.64.0609241825280.4838@erda.mds>  <1159119561.2899.20.camel@mindpipe>
 <260d3bff0609241104o65218c3bwc59aef94eddbca53@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Sep 2006, Jean-Marc Saffroy wrote:

> On Sun, 2006-09-24 at 19:01 +0200, Jean-Marc Saffroy wrote:
>> Yes yes, I know the kernel is tainted "P" (courtesy of the infamous
>> Nvidia module), so flame me if you want, but some investigation leads
>> me to think it could be an issue in core kernel modules, so read on if
>> you still want the gory details. ;-)
>
> Please don't post tainted Oops reports to LKML.  It's not a political 
> issue, it's a technical one - a tainted kernel CANNOT be debugged.

Thank you for flaming. ;-) I thought the lines above would lead some 
people to read on and post an enlightening answer to the implicit question 
that followed, so I'll restate it below.

> Reproduce with an untainted kernel and repost.

Ok, I'll try.

In the mean time, maybe someone can try to answer my original question, 
that was: is there a race between snd_pcm_oss_change_params() reallocating 
a buffer and resample_expand() using another (possibly the same)?

Now I hope that my mail client does not taint the question as well. ;-)


Cheers,

-- 
saffroy@gmail.com
