Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289315AbSAIKAC>; Wed, 9 Jan 2002 05:00:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289318AbSAIJ7v>; Wed, 9 Jan 2002 04:59:51 -0500
Received: from mons.uio.no ([129.240.130.14]:17878 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S289315AbSAIJ7b>;
	Wed, 9 Jan 2002 04:59:31 -0500
To: Nicolas.Fay@evotecoai.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: IRIX NFS server/ Linux NFS client problem
In-Reply-To: <OFCEFB95FA.A1E904F6-ONC1256B3C.00358EBC@evotecoai.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 09 Jan 2002 10:59:25 +0100
In-Reply-To: <OFCEFB95FA.A1E904F6-ONC1256B3C.00358EBC@evotecoai.com>
Message-ID: <shs4rlvc0aq.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Nicolas Fay <Nicolas.Fay@evotecoai.com> writes:

     > I'm wondering whether anybody experienced problems with Linux
     > NFS clients and IRIX NFS servers like this one:

     > I mount an xfs-filesystem located on an IRIX-machine v6.5.12 to
     > a Linux box (versions see below) using either Linux kernel-nfs
     > or module-nfs. Listing directory contents shows all the files

This is a known, and well documented glibc bug which they refuse to
fix. Please check the l-k archives before you post.

Just apply the workaround

   http://www.fys.uio.no/~trondmy/src/2.4.17/linux-2.4.17-seekdir.dif

and then use the 32bitclients export option on the IRIX server...

Cheers,
  Trond
