Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272564AbRIKUV5>; Tue, 11 Sep 2001 16:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272563AbRIKUVi>; Tue, 11 Sep 2001 16:21:38 -0400
Received: from mons.uio.no ([129.240.130.14]:13302 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S272562AbRIKUVa>;
	Tue, 11 Sep 2001 16:21:30 -0400
To: "chen, xiangping" <chen_xiangping@emc.com>
Cc: "'nfs-request@lists.sourceforge.net'" 
	<nfs-request@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Questions on NFS client inode management.
In-Reply-To: <276737EB1EC5D311AB950090273BEFDD043BC5A2@elway.lss.emc.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 11 Sep 2001 22:21:34 +0200
In-Reply-To: "chen, xiangping"'s message of "Tue, 11 Sep 2001 14:30:18 -0400"
Message-ID: <shsk7z5zdf5.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == xiangping chen <chen> writes:

     > Hi, I have a question on inode management for NFS client.  It
     > seems that the inodes created on a NFS client for a mounted nfs
     > file system stays around until the file being removed. Is there
     > any limits on how many inodes are allowed in memory for NFS? 
     > What kind of behavior we expect if a malicious/careless
     > application just keeps creating new files and flood the kernel
     > memory with inodes created?

The same behaviour as for local files: as memory goes low, the
ordinary reclaiming schemes kick in, and all should be hunky-dory. Of
course in the *real world*, ...

Cheers,
   Trond
