Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269173AbUINDtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269173AbUINDtr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 23:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269176AbUINDkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 23:40:51 -0400
Received: from out010pub.verizon.net ([206.46.170.133]:2296 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S269162AbUINDhs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 23:37:48 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: journal aborted, system read-only
Date: Mon, 13 Sep 2004 23:37:46 -0400
User-Agent: KMail/1.7
Cc: "Stephen C. Tweedie" <sct@redhat.com>
References: <200409121128.39947.gene.heskett@verizon.net> <1095088378.2765.18.camel@sisko.scot.redhat.com>
In-Reply-To: <1095088378.2765.18.camel@sisko.scot.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409132337.46922.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [151.205.51.156] at Mon, 13 Sep 2004 22:37:47 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 September 2004 11:12, Stephen C. Tweedie wrote:
>Hi,
>
>On Sun, 2004-09-12 at 16:28, Gene Heskett wrote:
>> I just got up, and found advisories on every shell open that the
>> journal had encountered an error and aborted, converting my /
>> partition to read-only.
>
>...
>
>> The kernel is 2.6.9-rc1-mm4.  .config available on request.
>>
>> This is precious little info to go on, but basicly I'm wondering
>> if anyone else has encountered this?
>
>Well, we really need to see _what_ error the journal had encountered
> to be able to even begin to diagnose it.  But 2.6.9-rc1-mm3 and
> -mm4 had a bug in the journaling introduced by low-latency work on
> the checkpoint code; can you try -mm5 or back out
>"journal_clean_checkpoint_list-latency-fix.patch" and try again?

Since -mm5 killed my usb2.0 stuffs, (all my printers disappeared) I'm 
now building -mm4 after reverting this patch.

This must be a fairly rare occurance in the real world, it has not 
recurred.  (yet, gotta keep Murphy happy you know)  :-)

>Cheers,
> Stephen

-- 
Cheers & thanks Stephen, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
