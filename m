Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932385AbWAZSNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbWAZSNy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 13:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbWAZSNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 13:13:54 -0500
Received: from mail.gmx.de ([213.165.64.21]:16016 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932385AbWAZSNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 13:13:53 -0500
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-rc1-mm3 (soft lockup)
Date: Thu, 26 Jan 2006 19:13:50 +0100
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org
References: <20060124232406.50abccd1.akpm@osdl.org>
In-Reply-To: <20060124232406.50abccd1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601261913.50642.dominik.karall@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 25. January 2006 08:24, Andrew Morton wrote:
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2
>.6.16-rc1-mm3/

BUG: soft lockup detected on CPU#0!
CPU 0:
Modules linked in: udf nls_cp437 vfat fat ppp_deflate zlib_deflate bsd_comp 
ppp_async r8169 snd_bt87x
Pid: 0, comm: swapper Not tainted 2.6.16-rc1-mm3 #1
RIP: 0010:[<ffffffff81008eb6>] <ffffffff81008eb6>{default_idle+54}
RSP: 0018:ffffffff8158df40  EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffff810023e96150 RCX: ffffffff8158c000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffff81522758
RBP: 00001a33932ed598 R08: ffffffff8158c000 R09: ffff810023bc1e10
R10: ffff810023bc1e08 R11: 00000000ffffffff R12: 000000000008217e
R13: 0000000081008e80 R14: ffffffff81471000 R15: ffff8100023da6e0
FS:  00002b5f1f02ef10(0000) GS:ffffffff81582000(0000) knlGS:00000000f73786b0
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002aaaabd78000 CR3: 0000000023afd000 CR4: 00000000000006e0

Call Trace: <ffffffff81009108>{cpu_idle+104} <ffffffff8100803f>{rest_init+63}
       <ffffffff8158e875>{start_kernel+453} <ffffffff8158e2b6>{_sinittext+694}


If more information needed, let me know!

hth,
dominik
