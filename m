Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267512AbRGMRiZ>; Fri, 13 Jul 2001 13:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267513AbRGMRiP>; Fri, 13 Jul 2001 13:38:15 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:54083 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267512AbRGMRiN>; Fri, 13 Jul 2001 13:38:13 -0400
Date: Fri, 13 Jul 2001 18:38:00 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Mike Black <mblack@csihq.com>
Cc: Andrew Morton <andrewm@uow.edu.au>,
        "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>,
        ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: 2.4.6 and ext3-2.4-0.9.1-246
Message-ID: <20010713183800.J13419@redhat.com>
In-Reply-To: <02ae01c10925$4b791170$e1de11cc@csihq.com> <3B4BD13F.6CC25B6F@uow.edu.au> <021801c10a03$62434540$e1de11cc@csihq.com> <3B4C729B.6352A443@uow.edu.au> <05c401c10ac1$0e81ad70$e1de11cc@csihq.com> <3B4D8B5D.E9530B60@uow.edu.au> <036e01c10b96$72ce57d0$e1de11cc@csihq.com> <111501c10ba3$664a1370$e1de11cc@csihq.com> <3B4F0273.1DF40F8E@uow.edu.au> <125101c10bc1$85eab630$e1de11cc@csihq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <125101c10bc1$85eab630$e1de11cc@csihq.com>; from mblack@csihq.com on Fri, Jul 13, 2001 at 01:30:34PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 13, 2001 at 01:30:34PM -0400, Mike Black wrote:
> Here's the oops:
> Message on console:
> yeti kernel: EXT3-fs error (device md(9,0)): ext3_new_inode: reserved inode
> or inode > inodes count - block_group = 0,inode=1
> 
> Here line 575:
>         J_ASSERT_JH(jh, !buffer_locked(jh2bh(jh)));

Many thanks.  Were there any other log messages at all?

Cheers,
 Stephen
