Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266400AbRG1GRb>; Sat, 28 Jul 2001 02:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266417AbRG1GRV>; Sat, 28 Jul 2001 02:17:21 -0400
Received: from d122251.upc-d.chello.nl ([213.46.122.251]:17681 "EHLO
	arnhem.blackstar.nl") by vger.kernel.org with ESMTP
	id <S266400AbRG1GRH>; Sat, 28 Jul 2001 02:17:07 -0400
From: bvermeul@devel.blackstar.nl
Date: Sat, 28 Jul 2001 08:19:55 +0200 (CEST)
To: Hans Reiser <reiser@namesys.com>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        kernel <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <3B61BF7D.306AAB45@namesys.com>
Message-ID: <Pine.LNX.4.33.0107280816200.23742-100000@devel.blackstar.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> You should not see old data being corrupted.  If you are seeing it with
> a recent ReiserFS version,
> we'd like your help in reproducing it.

It is not old data perse. I edited those files. They have been opened, and
written back. But it will shuffle every bit of data in those files, and
I'll find sourcecode in the object file, *.d files, etc. The source file
itself is mostly garbled as well.

I can see if I can come up with a module as simple as possible to
reproduce this. (This is still a while(1); in kernel essentially, with
a couple of seconds between the hang and the compile/install cycle)

If you're interested, let me know, and I'll see if I can make a test-case
for you.

Bas Vermeulen

-- 
"God, root, what is difference?"
	-- Pitr, User Friendly

"God is more forgiving."
	-- Dave Aronson

