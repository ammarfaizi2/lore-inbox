Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313430AbSDKMJp>; Thu, 11 Apr 2002 08:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313479AbSDKMJo>; Thu, 11 Apr 2002 08:09:44 -0400
Received: from pat.uio.no ([129.240.130.16]:9879 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S313430AbSDKMJo>;
	Thu, 11 Apr 2002 08:09:44 -0400
To: Steffen Persvold <sp@scali.com>
Cc: <nfs@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <trond.myklebust@fys.uio.no>
Subject: Re: IRIX NFS server and Linux NFS client
In-Reply-To: <Pine.LNX.4.30.0204111218440.30970-100000@elin.scali.no>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 11 Apr 2002 14:09:22 +0200
Message-ID: <shs662yjv2l.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Steffen Persvold <sp@scali.com> writes:

     > I forgot to mention that NFSv3 works when an IRIX client mounts
     > the same directory (i.e the directory shows up as "nfs" and not
     > "nfs2" in the mount table on the IRIX client).

     > Could it be that IRIX only supports NFSv3 with TCP and not UDP
     > (I didn't try TCP mounting on the Linux client) ?

Have you applied

  http://www.fys.uio.no/~trondmy/src/2.4.18/linux-2.4.18-seekdir.dif

in order to work around the glibc-2.x readdir bugs?

Cheers,
  Trond
