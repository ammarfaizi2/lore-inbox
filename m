Return-Path: <linux-kernel-owner+w=401wt.eu-S932151AbXAIPav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbXAIPav (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 10:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbXAIPav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 10:30:51 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:39038 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932151AbXAIPau (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 10:30:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=rOohR+4e8JP7Xiuisl38f3Lo3w7oSHP7qYIkLKqCSwd+exmX6ONnRxiL8kvXPdXUu5k5W5yxyTa38rMB8PGGmHL6hT8gBA7rF2K8a2bIJHvJLU0S3+QQU7qtAPUhjYqe+M9LB0gqNJ9uEeTv1kFI8o2cHq//zH1POnITq4MLrBQ=
Date: Tue, 9 Jan 2007 15:28:36 +0000
To: Maciej Rutecki <maciej.rutecki@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [Re: 2.6.20-rc3-mm1] BUG: at kernel/sched.c:3415 sub_preempt_count()
Message-ID: <20070109152757.GB13656@slug>
References: <20070104220200.ae4e9a46.akpm@osdl.org> <45A3A96B.7090802@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45A3A96B.7090802@gmail.com>
User-Agent: mutt-ng/devel-r804 (Linux)
From: Frederik Deweerdt <frederik.deweerdt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2007 at 03:40:43PM +0100, Maciej Rutecki wrote:
> [   24.311778] BUG: at kernel/sched.c:3415 sub_preempt_count()
> [   24.311794]  [<c018e07e>] generic_sync_sb_inodes+0x9e/0x2f0
> [   24.311823]  [<c018e373>] sync_inodes_sb+0x83/0xa0
> [   24.311840]  [<c0171a28>] fsync_super+0x8/0x20
> [   24.311864]  [<c0171a6c>] do_remount_sb+0x2c/0x140
> [   24.311881]  [<c0171f41>] get_sb_single+0x61/0xd0
> [   24.311895]  [<c01afb30>] sysfs_fill_super+0x0/0xb0
> [   24.311916]  [<c0171e13>] vfs_kern_mount+0x43/0x90
> [   24.311929]  [<c01afb30>] sysfs_fill_super+0x0/0xb0
> [   24.311944]  [<c0171e73>] kern_mount+0x13/0x20
> [   24.311957]  [<c03b311f>] sysfs_init+0x6f/0xb0
> [   24.311984]  [<c03b2790>] mnt_init+0xc0/0x200
> [   24.311999]  [<c03b2377>] vfs_caches_init+0xd7/0x170
> [   24.312015]  [<c01ef758>] idr_init+0x48/0x50
> [   24.312041]  [<c039ca68>] start_kernel+0x1a8/0x360
> [   24.312057]  [<c039c4b0>] unknown_bootoption+0x0/0x260
> [   24.312071]  =======================
See:
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc3/2.6.20-rc3-mm1/hot-fixes/
This should fix it.
Regards,
Frederik
> 
> 
> 
> -- 
> Maciej Rutecki <maciej.rutecki@gmail.com>
> http://www.unixy.pl
> LTG - Linux Testers Group
> (http://www.stardust.webpages.pl/ltg/wiki/)







