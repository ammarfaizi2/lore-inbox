Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281916AbSALCZ1>; Fri, 11 Jan 2002 21:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282213AbSALCZR>; Fri, 11 Jan 2002 21:25:17 -0500
Received: from pat.uio.no ([129.240.130.16]:54921 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S281916AbSALCZE>;
	Fri, 11 Jan 2002 21:25:04 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15423.40571.772367.676896@charged.uio.no>
Date: Sat, 12 Jan 2002 03:24:59 +0100
To: Hans-Peter Jansen <hpj@urpla.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [NFS] some strangeness (at least) with linux-2.4.17-NFS_ALL patch
In-Reply-To: <15423.39344.864108.741338@charged.uio.no>
In-Reply-To: <20020111131528.44F8613E6@shrek.lisa.de>
	<15422.65459.871735.203004@charged.uio.no>
	<20020111191744.7A9CE1426@shrek.lisa.de>
	<15423.39344.864108.741338@charged.uio.no>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Trond Myklebust <trond.myklebust@fys.uio.no> writes:

     > Are you sure that you didn't mess up the fixups with
     > 2.4.18-pre1? That might explain things, since you would be
     > messing with nfs_refresh_inode. What you need to do against
     > 2.4.18-pre1 is first to revert the patch
     > linux-2.4.17-fattr.dif. After that you should be able to apply
     > linux-2.4.17-NFS_ALL.dif directly without any rejections...

Please also note that the version of linux-2.4.17-NFS_ALL.dif that
appeared on my site dated prior to 20th December had a bug within
nfs_refresh_inode that cause corruption of file attributes.
Is it possible that you might be using this buggy version?

Cheers,
  Trond
