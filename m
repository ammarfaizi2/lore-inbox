Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312411AbSDSNqP>; Fri, 19 Apr 2002 09:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312442AbSDSNqO>; Fri, 19 Apr 2002 09:46:14 -0400
Received: from mons.uio.no ([129.240.130.14]:6568 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S312411AbSDSNqN>;
	Fri, 19 Apr 2002 09:46:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Organization: Dept. of Physics, University of Oslo
To: "Jehanzeb Hameed" <u990056@giki.edu.pk>
Subject: Re: regarding NFS
Date: Fri, 19 Apr 2002 15:46:03 +0200
X-Mailer: KMail [version 1.3.2]
Cc: "Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0204181338050.19147-100000@penguin.transmeta.com> <E16yXRh-0005k9-00@charged.uio.no> <002a01c1e749$9901b7a0$e53ca8c0@hostel6.resnet.giki.edu.pk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16yYiB-0006NG-00@charged.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19. April 2002 04:26, Jehanzeb Hameed wrote:
> > No. inode->i_mapping is initialized by the VFS, not the NFS client
> > filesystem. (see linux/fs/inode.c:clean_inode())
> >
> > Cheers,
> >   Trond
>
> but then why does RAMFS assign it..??

I didn't do RAMFS, so I have no idea. Perhaps they figured that the effect of 
the extra indirection was not too performance critical?

Cheers,
  Trond
