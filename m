Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293549AbSCGH4N>; Thu, 7 Mar 2002 02:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293553AbSCGH4D>; Thu, 7 Mar 2002 02:56:03 -0500
Received: from h139n1fls24o900.telia.com ([213.66.143.139]:51934 "EHLO
	oden.fish.net") by vger.kernel.org with ESMTP id <S293549AbSCGHz4>;
	Thu, 7 Mar 2002 02:55:56 -0500
Date: Thu, 7 Mar 2002 08:56:36 +0100
From: Voluspa <voluspa@bigfoot.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.6-pre3 Kernel panic: VFS: Unable to mount root fs on 03:02
Message-Id: <20020307085636.4feb2372.voluspa@bigfoot.com>
In-Reply-To: <Pine.GSO.4.21.0203070127190.24127-100000@weyl.math.psu.edu>
In-Reply-To: <20020307072124.6365c8ac.voluspa@bigfoot.com>
	<Pine.GSO.4.21.0203070127190.24127-100000@weyl.math.psu.edu>
Organization: The Foggy One
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Mar 2002 01:29:30 -0500 (EST)
Alexander Viro <viro@math.psu.edu> wrote:

> Add
> 		printk("mount() -> %d\n", err);
> right before
>                 printk ("VFS: Cannot open root device \"%s\" or %s\n",
>                         root_device_name, kdevname (ROOT_DEV));
> in init/do_mounts.c and see what it prints.

(An hour of compile time later):

[...]
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
mount() -> -14
VFS: Cannot open root device "302" or 03:02
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 03:02

I'm writing this on the exact same partition setup with 2.4.18-pre7-ac2 so there's nothing wrong with how lilo handles the boot process.

Regards,
Mats Johannesson
Sweden
