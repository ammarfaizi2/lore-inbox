Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2993120AbWJUS1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993120AbWJUS1K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 14:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993139AbWJUS1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 14:27:10 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:48308 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S2993120AbWJUS1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 14:27:06 -0400
Date: Sat, 21 Oct 2006 14:26:48 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Robert Peterson <rpeterso@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       torvalds@osdl.org, viro@ftp.linux.org.uk, hch@infradead.org,
       sct@redhat.com, adilger@clusterfs.com
Subject: Re: [PATCH 05 of 23] ext3: change uses of f_{dentry, vfsmnt} to use f_path
Message-ID: <20061021182648.GC28179@filer.fsl.cs.sunysb.edu>
References: <b75a8d7cedacd1de45bc.1161411450@thor.fsl.cs.sunysb.edu> <453A17E0.7080301@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <453A17E0.7080301@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2006 at 07:51:44AM -0500, Robert Peterson wrote:
> Josef Jeff Sipek wrote:
> >From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
> >
> >This patch changes all the uses of f_{dentry,vfsmnt} to f_path.{dentry,mnt}
> >in the ext3 filesystem.
> >  
> Hey Jeff,
> 
> Don't forget about GFS2:  fs/gfs2/ops_file.c.

I'm aware. There are still about 500 instances of f_{dentry,vfsmnt}, but I
just wanted to see whether or not this would go anywhere. If it does, the
remaining instances will get fixed up too.

Josef "Jeff" Sipek.

-- 
Evolution, n.:
  A hypothetical process whereby infinitely improbable events occur with
  alarming frequency, order arises from chaos, and no one is given credit.
