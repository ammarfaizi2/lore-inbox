Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131527AbRCNTrh>; Wed, 14 Mar 2001 14:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131528AbRCNTr2>; Wed, 14 Mar 2001 14:47:28 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:34045 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S131525AbRCNTrM>; Wed, 14 Mar 2001 14:47:12 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200103141945.f2EJjF410285@webber.adilger.int>
Subject: Re: (struct dentry *)->vfsmnt;
In-Reply-To: <3AAFC708.752B2819@austin.ibm.com> from Dave Kleikamp at "Mar 14,
 2001 01:31:20 pm"
To: Dave Kleikamp <shaggy@austin.ibm.com>
Date: Wed, 14 Mar 2001 12:45:15 -0700 (MST)
CC: Andreas Dilger <adilger@turbolinux.com>,
        Alexander Viro <viro@math.psu.edu>,
        Linux kernel development list <linux-kernel@vger.kernel.org>,
        Linux FS development list <linux-fsdevel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Kleikamp writes:
> AIX stores all of this information in the LVM, not in the filesystem. 
> The filesystem itself has nothing to do with importing and exporting
> volume groups.  Having the information stored as part of LVM's metadata
> allows the utilities to only deal with LVM instead of every individual
> file system.

So you are saying that mount(8) writes into a field in the LVM LVCB or
something?  Might be possible on Linux LVM as well...

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
