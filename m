Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311380AbSCMViU>; Wed, 13 Mar 2002 16:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311378AbSCMViJ>; Wed, 13 Mar 2002 16:38:09 -0500
Received: from [208.48.139.185] ([208.48.139.185]:128 "HELO
	forty.greenhydrant.com") by vger.kernel.org with SMTP
	id <S311362AbSCMVhy>; Wed, 13 Mar 2002 16:37:54 -0500
Date: Wed, 13 Mar 2002 13:37:48 -0800
From: David Rees <dbr@greenhydrant.com>
To: linux-kernel@vger.kernel.org
Cc: Andreas Dilger <adilger@clusterfs.com>
Subject: Re: mke2fs (and mkreiserfs) core dumps
Message-ID: <20020313133748.A12472@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	linux-kernel@vger.kernel.org,
	Andreas Dilger <adilger@clusterfs.com>
In-Reply-To: <20020313123114.A11658@greenhydrant.com> <20020313205537.GC429@turbolinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020313205537.GC429@turbolinux.com>; from adilger@clusterfs.com on Wed, Mar 13, 2002 at 01:55:37PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2002 at 01:55:37PM -0700, Andreas Dilger wrote:
> On Mar 13, 2002  12:31 -0800, David Rees wrote:
> > I've got an interesting situation here where mke2fs and mkreiserfs core dump
> > with the message: File size limit exceeded (core dumped)
> 
> This is a ulimit bug caused by the kernel and libc 2.1.  If you log into
> the system as root at the console (no su) it should work.
> 
> > The kernel is 2.4.18-rc4 + Trond's NFS_ALL patch.
> 
> I thought that the fix for this was in the 2.4.18 kernel, but I guess
> not.

Thanks for the info.  This explains why I didn't have any problems
partitioning the 3ware's RAID, I was logged into the console.

Is there anyway I can avoid logging into the console?  It can be a PITA if
the machine happens to be far away.

Thanks,
Dave
