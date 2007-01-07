Return-Path: <linux-kernel-owner+w=401wt.eu-S965172AbXAGVWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965172AbXAGVWW (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 16:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965171AbXAGVWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 16:22:22 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:63620 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965172AbXAGVWV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 16:22:21 -0500
Date: Sun, 07 Jan 2007 16:22:00 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Linux 2.6.20-rc4
In-reply-to: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>
Message-id: <200701071622.00557.gene.heskett@verizon.net>
Organization: Not detectable
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
User-Agent: KMail/1.9.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 07 January 2007 01:19, Linus Torvalds wrote:
>There's absolutely nothing interesting here, unless you want to play

Running on FC6, all uptodate as of yesterday, using LVM on an XP-2800 
Athlon & a gig of ram.

First boot of 2.6.20-rc4 here, in the messages scrolling by, the nptd 
startup failed.  But after fully booting and x was started, a restart 
worked, albeit it took several seconds for the startup phase.  NDI if it 
means anything or not.

And maybe I'm seeing the effects of this ext3 bug that's hurting 
kernel.org here, it seems the x startup has everything 100% serialized 
now and that's slow as snails.  A good 15-17 seconds from the background 
image being loaded to all the shells reopened I left open when I logged 
out of x, and gkrellm is all restarted.  With a cpu running at 2.1 ghz, 
and a 333mhz FSB, I'd think that should be 2, maybe 3 seconds.  And I 
think I can recall times like that when I was running ext2 in a past 
life.  I'm hoping whatever fixes kernel.org will filter back to us peons 
in due time.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2007 by Maurice Eugene Heskett, all rights reserved.
