Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268320AbRG3Vt5>; Mon, 30 Jul 2001 17:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268436AbRG3Vtr>; Mon, 30 Jul 2001 17:49:47 -0400
Received: from ns.caldera.de ([212.34.180.1]:29870 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S268320AbRG3Vth>;
	Mon, 30 Jul 2001 17:49:37 -0400
Date: Mon, 30 Jul 2001 23:49:34 +0200
From: Christoph Hellwig <hch@caldera.de>
To: Hans Reiser <reiser@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
Message-ID: <20010730234934.B20969@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200107281645.f6SGjA620666@ns.caldera.de> <3B653211.FD28320@namesys.com> <20010730210644.A5488@caldera.de> <3B65C3D4.FF8EB12D@namesys.com> <20010730224930.A18311@caldera.de> <3B65CFC5.A6B4FC08@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B65CFC5.A6B4FC08@namesys.com>; from reiser@namesys.com on Tue, Jul 31, 2001 at 01:21:09AM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 31, 2001 at 01:21:09AM +0400, Hans Reiser wrote:
> 
> The cost is not a crash, the cost is performance sucks.
> 

I give a damn for the performance if my filesystem doesn't prove stable.
And I think you can't deny that all reiserfs versions for 2.4 had issues
in that area. _IF_ reiserfs proves stable in the next time I don't see
any reason why this checks should stay in.

For example I've just turned of the debugging on my ext3-using boxens.
Not only ext3 has proven stable, but I also know that if it fails there
is still e2fsck which has proven absolutly reliable in the last years.

Another example is the write support I currently add to my freevxfs driver
(and no, I'm neither working for RedHat nor is it the VxFS module that
played a central role in your 3/2000 conspiration theories):  until it has
proven stable for a long time I will not even add a option to turn off
all the consistency checks I've added.  I'll give a damn if ext2, reiserfs
or VERITAS will beat me until it is stable.

>
> Are you going to leave it on for future versions of ReiserFS, or just for Linux
> 2.4.2? 

I'm not in a position to decide it.  But if I'm asked for my opion (again)
the answer will depend on wether reiserfs will be more stable than now
at that point.

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.
