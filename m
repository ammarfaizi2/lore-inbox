Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbVERXk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbVERXk6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 19:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbVERXk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 19:40:58 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:14596 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262406AbVERXk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 19:40:27 -0400
Date: Thu, 19 May 2005 01:40:22 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       ocfs2-devel@oss.oracle.com, torvalds@osdl.org, akpm@osdl.org,
       wim.coekaerts@oracle.com, lmb@suse.de
Subject: Re: [RFC] [PATCH] OCFS2
Message-ID: <20050518234022.GA5112@stusta.de>
References: <20050518223303.GE1340@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050518223303.GE1340@ca-server1.us.oracle.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 03:33:03PM -0700, Mark Fasheh wrote:
>...
> A full patch can be downloaded from:
> http://oss.oracle.com/projects/ocfs2/dist/files/patches/2.6.12-rc4/complete/ocfs2-configfs-all.patch
>...

Some comments on this patch:
- there's no reason to make JBD user-visible
- is there any reason why CONFIGFS_FS is user-visible?
- some global code might become static:
  run "make namespacecheck" after compiling the kernel and check
  the configfs and ocfs2 parts of the output

> Mark Fasheh

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

