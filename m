Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293203AbSCJTtz>; Sun, 10 Mar 2002 14:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293204AbSCJTto>; Sun, 10 Mar 2002 14:49:44 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:17319 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S293203AbSCJTt1>; Sun, 10 Mar 2002 14:49:27 -0500
Date: Sun, 10 Mar 2002 11:51:53 -0800
From: Hanna V Linder <hannal@us.ibm.com>
Reply-To: Hanna V Linder <hannal@us.ibm.com>
To: Paul Menage <pmenage@ensim.com>, viro@math.psu.edu,
        linux-kernel@vger.kernel.org
cc: Hanna Linder <hannal@us.ibm.com>
Subject: Re: [PATCH] 2.5.6 Fast Walk Dcache (improved) 
Message-ID: <3031260852.1015761112@[10.10.2.2]>
In-Reply-To: <E16jX4j-0007gz-00@pmenage-dt.ensim.com>
In-Reply-To: <E16jX4j-0007gz-00@pmenage-dt.ensim.com>
X-Mailer: Mulberry/2.1.1 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Friday, March 08, 2002 6:59 PM -0800 Paul Menage <pmenage@ensim.com> wrote:

>> I've reworked the patch somewhat to give the following features:
>>
>
> Oops - that was a slightly non-functional version of the patch, as
> exec_permission_lite() had somehow got renamed to exec_permission().
>
> Here's the correct one.
>
> diff -daur linux-2.5.6/fs/dcache.c linux-2.5.6.dcache/fs/dcache.c

Hi Paul,

	There seems to be a problem while booting with this patch applied
on an 8-way SMP (.config available). Here is where the boot process stops:

VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 232k freed
INIT: version 2.78 booting
                        Welcome to Red Hat Linux
                Press 'I' to enter interactive startup.
Mounting proc filesystem:  [  OK  ]
Configuring kernel parameters:  [  OK  ]
modprobe: modprobe: Can't open dependencies file /lib/modules/2.5.6/modules.dep (No such file or directory)
Setting clock  (localtime): Sun Mar 10 11:10:27 PST 2002 [  OK  ]
Loading default keymap (us): [  OK  ]

Hanna


