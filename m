Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311369AbSCMU4n>; Wed, 13 Mar 2002 15:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311370AbSCMU4d>; Wed, 13 Mar 2002 15:56:33 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:9973 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S311369AbSCMU4Y>; Wed, 13 Mar 2002 15:56:24 -0500
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 13 Mar 2002 13:55:37 -0700
To: David Rees <dbr@greenhydrant.com>, linux-kernel@vger.kernel.org
Subject: Re: mke2fs (and mkreiserfs) core dumps
Message-ID: <20020313205537.GC429@turbolinux.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020313123114.A11658@greenhydrant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020313123114.A11658@greenhydrant.com>
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 13, 2002  12:31 -0800, David Rees wrote:
> I've got an interesting situation here where mke2fs and mkreiserfs core dump
> with the message: File size limit exceeded (core dumped)

This is a ulimit bug caused by the kernel and libc 2.1.  If you log into
the system as root at the console (no su) it should work.

> The kernel is 2.4.18-rc4 + Trond's NFS_ALL patch.

I thought that the fix for this was in the 2.4.18 kernel, but I guess
not.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

