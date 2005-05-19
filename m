Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262478AbVESJri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262478AbVESJri (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 05:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbVESJrC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 05:47:02 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:39691 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262478AbVESJpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 05:45:22 -0400
Date: Thu, 19 May 2005 11:45:17 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Manish Singh <manish.singh@oracle.com>
Cc: Mark Fasheh <mark.fasheh@oracle.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org,
       linux-fsdevel@vger.kernel.org, ocfs2-devel@oss.oracle.com
Subject: Re: [Ocfs2-devel] Re: [RFC] [PATCH] OCFS2
Message-ID: <20050519094517.GD5112@stusta.de>
References: <20050518223303.GE1340@ca-server1.us.oracle.com> <20050518234022.GA5112@stusta.de> <20050519012658.GA27595@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050519012658.GA27595@ca-server1.us.oracle.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 06:26:58PM -0700, Manish Singh wrote:
> On Thu, May 19, 2005 at 01:40:22AM +0200, Adrian Bunk wrote:
> > On Wed, May 18, 2005 at 03:33:03PM -0700, Mark Fasheh wrote:
> > >...
> > > A full patch can be downloaded from:
> > > http://oss.oracle.com/projects/ocfs2/dist/files/patches/2.6.12-rc4/complete/ocfs2-configfs-all.patch
> > >...
> > 
> > Some comments on this patch:
> > - there's no reason to make JBD user-visible
> 
> Sure, the only reason I made it visible was because of the comment in
> there:
> 
> # CONFIG_JBD could be its own option (even modular), but until there are
> # other users than ext3, we will simply make it be the same as CONFIG_EXT3_FS
> 
> I don't really have a preference either way.

I'd say the comment is wrong.

> > - is there any reason why CONFIGFS_FS is user-visible?
> 
> It's a generic mechanism for userspace driven configuration of kernel
> functionality. There's nothing specific to OCFS2 about it. Other kernel
> subsystems/projects could use it too, for their own configuration
> mechanisms. More details are in configfs.txt, which is included in the
> above patch. Note the example used in the documentation text is an NBD
> driver.
>...

If other subsystems use it, they should select it.

> -Manish

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

