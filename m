Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265547AbUAPUXH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 15:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265699AbUAPUXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 15:23:00 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:6666 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S265547AbUAPUWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 15:22:40 -0500
Message-ID: <4008480F.70206@techsource.com>
Date: Fri, 16 Jan 2004 15:22:39 -0500
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [OT] Redundancy eliminating file systems, breaking MD5, donating
 money to OSDL
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, I saw a slashdot article that pointed to a site dedicated to 
breaking MD5.  That is, so far, no one has found any two differing 
string which have the same MD5 cksum.  Logically, however, there WILL be 
collisions for any strings longer than the MD5 cksum itself -- we just 
haven't found any.  Well, there's some sort of contest where you can win 
money for breaking MD5 (I think).

Even further back, there was an LKML discussion about various sorts of 
compressing file systems.  One of the subthreads discussed identifying 
identical blocks (using MD5) and pointing them at the same physical 
block on disk.  Naturally, if there WERE two blocks with the same MD5, 
we'd want to check the raw data, just to be sure that there wasn't a 
false positive.

Think about it!  If we had a filesystem that actually DID this, and it 
was in the Linux kernel, it would spread far and wide.  It's bound to 
happen that someone will identify a collision.  We then report that to 
the committee offering the reward and then donate it to OSDL to help 
Linux development.



Yeah, I know... I'm a dork.

