Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278348AbRJMS3q>; Sat, 13 Oct 2001 14:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278347AbRJMS3h>; Sat, 13 Oct 2001 14:29:37 -0400
Received: from mons.uio.no ([129.240.130.14]:6016 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S278346AbRJMS3V>;
	Sat, 13 Oct 2001 14:29:21 -0400
To: Alan Hagge <ahagge@wbfa.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS issue: Irix server, Linux client - inode number mismatch
In-Reply-To: <3BC76818.BA84A90E@wbfa.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 13 Oct 2001 20:29:51 +0200
In-Reply-To: Alan Hagge's message of "Fri, 12 Oct 2001 15:00:56 -0700"
Message-ID: <shsbsjbs89s.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Alan Hagge <ahagge@wbfa.com> writes:

     > /usr/local/sgi/wbfa
     >         Oct 8 16:01:27 lrender2 kernel: nfs_refresh_inode:
     >         inode number
     > mismatch
     >         Oct 8 16:01:27 lrender2 kernel: expected
     >         (0x3000007/0x6467c36),
     > got (0x3000005/0x6467c36)

That means that the device number or 'fsid' suddenly has changed on
your server. That's a server bug.

Cheers,
   Trond
