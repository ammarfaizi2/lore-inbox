Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262246AbSJNWkd>; Mon, 14 Oct 2002 18:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262244AbSJNWkd>; Mon, 14 Oct 2002 18:40:33 -0400
Received: from pat.uio.no ([129.240.130.16]:35536 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S262246AbSJNWkc>;
	Mon, 14 Oct 2002 18:40:32 -0400
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>, nfsv4-wg@citi.umich.edu
Subject: Re: [NFS] [PATCH 20/19] A basic NFSv4 client for 2.5.x
References: <15787.18187.306840.862917@charged.uio.no>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 15 Oct 2002 00:46:25 +0200
In-Reply-To: <15787.18187.306840.862917@charged.uio.no>
Message-ID: <shsk7kkljum.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Trond Myklebust <trond.myklebust@fys.uio.no> writes:

     > This patch defines a new switch in fs/Config.in -
     >   CONFIG_NFS_V4: enables nfsv4 client

Please note: for those who are interested in trying this out, a patch
for the 'mount' program in util-linux-2.11r is available on

  http://www.fys.uio.no/~trondmy/src/NFSv4/mount-2.11r-nfsv4.patch

Note however that the NFS client is not yet fully functional, as it
lacks the upcall + RPCSEC_GSS. These features are forthcoming...

Cheers,
  Trond
