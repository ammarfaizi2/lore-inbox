Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265042AbRFURFt>; Thu, 21 Jun 2001 13:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265043AbRFURFj>; Thu, 21 Jun 2001 13:05:39 -0400
Received: from mons.uio.no ([129.240.130.14]:17864 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S265042AbRFURFY>;
	Thu, 21 Jun 2001 13:05:24 -0400
To: Chris Mason <mason@suse.com>
Cc: Christian Robottom Reis <kiko@async.com.br>, NFS@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: [reiserfs-list] NFS insanity
In-Reply-To: <424880000.993131958@tiny>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 21 Jun 2001 16:58:52 +0200
In-Reply-To: Chris Mason's message of "Thu, 21 Jun 2001 09:59:18 -0400"
Message-ID: <shselsdyj4j.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Chris Mason <mason@suse.com> writes:

     > Sounds like some of the problems fixed in 2.4.5 and 2.4.6pre
     > kernels, where NFS data didn't get flushed right away, but I
     > thought that only involved mmap'd files.

Ordinary 'cp' should work fine: it uses 'read' and 'write' - not mmap.

Cheers,
  Trond
