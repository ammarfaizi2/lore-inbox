Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261884AbVCXDq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbVCXDq3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 22:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbVCXDq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 22:46:29 -0500
Received: from fire.osdl.org ([65.172.181.4]:64452 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263010AbVCXDpx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 22:45:53 -0500
Date: Wed, 23 Mar 2005 19:45:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rechberger Markus <mrechberger@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ooops: 0000 [#1] PIONEER DVD-RW DVR-K12RA
Message-Id: <20050323194531.51e4013b.akpm@osdl.org>
In-Reply-To: <d9def9db0503231553405b6f5b@mail.gmail.com>
References: <d9def9db0503231553405b6f5b@mail.gmail.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rechberger Markus <mrechberger@gmail.com> wrote:
>
> Hi,
> 
> just got that message when I tried to mount a cd
> 
> ...
>
> EIP is at get_kobj_path_length+0x26/0x40
> eax: 00000000   ebx: 00000000   ecx: ffffffff   edx: ddc3414c
> esi: 00000001   edi: 00000000   ebp: ffffffff   esp: cd89bdd4
> ds: 007b   es: 007b   ss: 0068
> Process mount (pid: 5066, threadinfo=cd89a000 task=cd0595a0)
> Stack: d5666e00 c1430580 ffffffea ddc3414c c01ad15f ddc3414c 00000282 00000020 
>        d26f94b4 d5666e00 c1430580 ffffffea 00000000 c01adb98 ddc3414c 000000d0 
>        00000020 00000064 fffffff4 d5666e00 c1430580 ffffffea cd915000 c01adca8 
> Call Trace:
>  [<c01ad15f>] kobject_get_path+0x1f/0x80
>  [<c01adb98>] do_kobject_uevent+0x28/0x110
>  [<c01adca8>] kobject_uevent+0x28/0x30
>  [<c015bade>] bdev_uevent+0x2e/0x50
>  [<c015bc76>] kill_block_super+0x26/0x60
>  [<c015ad9e>] deactivate_super+0x6e/0xa0
>  [<c015bc21>] get_sb_bdev+0x121/0x150
>  [<c0172050>] alloc_vfsmnt+0x90/0xd0
>  [<dec43fc0>] isofs_get_sb+0x30/0x40 [isofs]
>  [<dec42cc0>] isofs_fill_super+0x0/0x6d0 [isofs]
>  [<c015be67>] do_kern_mount+0x57/0xe0
>  [<c017332c>] do_new_mount+0x9c/0xe0
>  [<c0173a47>] do_mount+0x157/0x1b0
>  [<c0173893>] copy_mount_options+0x63/0xc0
>  [<c0173e3f>] sys_mount+0x9f/0xe0
>  [<c01031af>] syscall_call+0x7/0xb

Is this repeatable?  If so, are you able to devise a formula which allows
others to releat it?

