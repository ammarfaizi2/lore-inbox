Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265477AbUHHOan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265477AbUHHOan (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 10:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265487AbUHHOan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 10:30:43 -0400
Received: from out002pub.verizon.net ([206.46.170.141]:31912 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S265477AbUHHOal
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 10:30:41 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Sun, 8 Aug 2004 10:30:38 -0400
User-Agent: KMail/1.6.82
Cc: Linus Torvalds <torvalds@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <20040806031815.GL12308@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408052022060.24588@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408052022060.24588@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408081030.39051.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [151.205.60.175] at Sun, 8 Aug 2004 09:30:40 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 August 2004 23:24, Linus Torvalds wrote:

[...]

>I'll commit the obvious one-liner fix, since it might explain _some_
>problems people have seen.
>
>		Linus

I had to reboot late last night, out of memory and things (like 
mozilla (1.7.2) were dying, but nothing in the logs.  Nearly out 
again, now ~40megs free but so far its stable & nothing in swap.  I'm 
getting the impression there is a memory leak somewhere.  OOm hasn't 
killed anything I am using at this time anyway.

Its running like an arthritic dog though, 3 units for seti yesterday, 
s/b 6 to 7.  The gkrellm2 cpu usage display looks plumb normal, so 
I'm a bit puzzled as to why the slowdown, the rest of the system 
'feels good'.

This is with just the 'one liner' on top of rc3 & non-verbose-debug.  
The question is, is rc3-mm1 ready for *me* to try?

I don't want to be the hangup, holding up forward progress, but it 
appears I (& maybe 1 or 2 others) may be exactly that with all this 
time sitting around waiting for the other shoe to drop.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
