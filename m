Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262289AbVCVDXC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262289AbVCVDXC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 22:23:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262266AbVCVDWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 22:22:32 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:14829 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S262329AbVCVDUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 22:20:37 -0500
Date: Mon, 21 Mar 2005 22:20:36 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: 2.6.11-mm2 vs audio for kino and tvtime, now 2.6.12-rc1-mm1
In-reply-to: <20050321185623.5fb2592c.akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Reply-to: gene.heskett@verizon.net
Message-id: <200503212220.36347.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200503082326.28737.gene.heskett@verizon.net>
 <200503212135.07063.gene.heskett@verizon.net>
 <20050321185623.5fb2592c.akpm@osdl.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 March 2005 21:56, Andrew Morton wrote:
>Gene Heskett <gene.heskett@verizon.net> wrote:
>> ...
>> tvtime works, no audio glitches in the startup.  This is a
>> pcHDTV-3000 card, running in Never Twice Same Color mode as yet.
>>
>> xsane works normally I believe, doing a preview scan ok.
>
>Whew.

:)

>> kino works, but doesn't really want to time share with the much
>> cpu hungrier tvtime, this results a very noticeable lag in the
>> preview video coming in directly from the cameras imager via
>> firewire, and sometimes an outright freeze of 2-3 seconds duration
>> when kmail is makeing a mail fetch run.
>
>Is that unexpected?

No. 

>Are there other kernels which you found better 
> behaved in this regard?  There are CPU scheduler changes in -mm,
> but they're unlikely to affect UP or small SMP.

Only 2.6.12-rc1 is comparable in "feel", and it will take me a while  
to reach a conclusion.  Stay tuned...
  
>> spcagui works once I'd reinstalled the spca50x stuff
>>
>> /. pops right up in mozilla-1.7.5, also in firefox
>>
>> Those seem to be the main things of interest right now, to me.
>>
>> Anything else I should specifically check on this UP machine?
>>
>> As I add content to this message, I am occasionally seeing lags
>> between what I type and its showing up on the screen but its
>> certainly better than 2.6.10 or 11 was by quite a ways.  This is
>> related to the kino lags in that I believe its kmail's net access
>> that is causeing them.
>
>hm, OK.  Is much disk I/O happening during the lags?

Not really, its spamassassins &^%$#@ perl scripts that are eating the 
cpu I think.

>> Overall, I don't have any instant squawks Andrew.  Looks good,
>> generally feels good.  Itches might develop later though.  I'm
>> using the cfq scheduler, were there any changes of note there?
>
>Relative to 2.6.121-mm2?  Yes, CFQ underwent radical changes.
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
