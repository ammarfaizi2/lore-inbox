Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262452AbVESCbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262452AbVESCbX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 22:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262448AbVESCbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 22:31:22 -0400
Received: from smtpout.mac.com ([17.250.248.88]:26309 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262452AbVESCbK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 22:31:10 -0400
In-Reply-To: <20050518223303.GE1340@ca-server1.us.oracle.com>
References: <20050518223303.GE1340@ca-server1.us.oracle.com>
Mime-Version: 1.0 (Apple Message framework v728)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8E7D9068-5392-4479-9207-18C63618A133@mac.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       ocfs2-devel@oss.oracle.com, torvalds@osdl.org, akpm@osdl.org,
       wim.coekaerts@oracle.com, lmb@suse.de
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC] [PATCH] OCFS2
Date: Wed, 18 May 2005 22:30:56 -0400
To: Mark Fasheh <mark.fasheh@oracle.com>
X-Mailer: Apple Mail (2.728)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 18, 2005, at 18:33:03, Mark Fasheh wrote:
> Hello,
>
> This is OCFS2, a shared disk cluster file system which we hope will be
> included in the kernel.
>
> We think OCFS2 has many qualities which make it particularly
> interesting as a cluster file system:

[...snip...]

> -OCFS2 has a strong data locking model, which includes a shared mmap
>  implementation (shared writeable mappings are not yet supported) and
>  full AIO support.

Does this include support for UNIX sockets and named pipes?  One of
the issues I have with filesystems like AFS and NFS is that they
should theoretically make such things possible, but the code is not
implemented yet and does not appear it ever will be.  This is very
useful for home directories when using programs like "links" that
rely on being able to create UNIX sockets in .links/socket or
similar.


Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$  
r  !y?(-)
------END GEEK CODE BLOCK------



