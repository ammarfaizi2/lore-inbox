Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264329AbRGRXQs>; Wed, 18 Jul 2001 19:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264345AbRGRXQ2>; Wed, 18 Jul 2001 19:16:28 -0400
Received: from attila.bofh.it ([213.92.8.2]:31691 "HELO attila.bofh.it")
	by vger.kernel.org with SMTP id <S264329AbRGRXQW>;
	Wed, 18 Jul 2001 19:16:22 -0400
Date: Thu, 19 Jul 2001 00:25:20 +0200
From: "Marco d'Itri" <md@Linux.IT>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nfs_refresh_inode: inode number mismatch
Message-ID: <20010719002520.A5112@wonderland.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <shsd76zsxd2.fsf@charged.uio.no>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 17, Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

 >     > Jul 18 00:15:07 newsserver kernel: nfs_refresh_inode: inode
 >     > number mismatch Jul 18 00:15:07 newsserver kernel: expected
 >     > (0x3b30ac75/0x48d5), got (0x3b30ac75/0x8d04)

 >     > I've got a flood of these messages while talking to a procom
 >     > NAS this.  Should I worry? Upgrade/patch the kernel? Yell at
 >     > procom tech support?

 >Have you applied any extra patches to NFS? I remember one of my
No, the kernel is plain unpatched 2.4.5.

 >If, on the other hand, you're using a clean kernel, I'd look into what
 >the server is doing. It sounds like it's doing the same thing that the
 >userland `nfs-server' does: namely to recycle filehandles after a file
 >gets deleted...
Anything specific I can tell to their tech support?

Can I ignore these messages or I risk data corruption?

-- 
ciao,
Marco
