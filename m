Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286499AbRLUAYO>; Thu, 20 Dec 2001 19:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286500AbRLUAYE>; Thu, 20 Dec 2001 19:24:04 -0500
Received: from mons.uio.no ([129.240.130.14]:3551 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S286499AbRLUAXy>;
	Thu, 20 Dec 2001 19:23:54 -0500
To: Dave Jones <davej@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, andrea@suse.de,
        davej@codemonkey.org.uk, Chuck Lever <cel@monkey.org>
Subject: Re: Possible O_DIRECT problems ?
In-Reply-To: <20011221000806.A26849@suse.de>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 21 Dec 2001 01:23:45 +0100
In-Reply-To: <20011221000806.A26849@suse.de>
Message-ID: <shssna58lpq.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Dave Jones <davej@suse.de> writes:

     > Andrea, lk,
     >  I just experimented with O_DIRECT in conjunction with fsx,
     > and the results aren't pretty.

     > Over NFS it survives around 921 operations, all local
     > filesystems (ext2,ext3,reiser tested) just 6 operations.  I've
     > put the source to a modified fsx at
     > http://www.codemonkey.org.uk/cruft/fsx-odirect.c

Dave,

   O_DIRECT for NFS isn't yet merged into the kernel. Are these Chuck
Lever's NFS patches you've been testing?

Cheers,
   Trond
