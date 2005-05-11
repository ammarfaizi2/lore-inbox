Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261992AbVEKQy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbVEKQy6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 12:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbVEKQy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 12:54:57 -0400
Received: from gw.unix-scripts.info ([213.41.176.169]:25288 "EHLO
	gw.unix-scripts.info") by vger.kernel.org with ESMTP
	id S261992AbVEKQy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 12:54:29 -0400
Message-ID: <428238B7.7070207@apartia.fr>
Date: Wed, 11 May 2005 18:54:15 +0200
From: Laurent CARON <lcaron@apartia.fr>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Zeno Davatz <zdavatz@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel Panic - not syncing: VFS: Unable to mount root fs on unknown-block(8,3)
References: <40a4ed5905051107255848f6b1@mail.gmail.com>
In-Reply-To: <40a4ed5905051107255848f6b1@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zeno Davatz a écrit :

>Hi
>
>I'm trying to set up a new server with 2*200GB HD's, 2*Intel Xeon 3.4
>GHz and an Intel SE7520BD2 Motherboard (SATA).
>
>I can boot perfectly fine from my Gentoo 2005.0 - minimal-install CD.
>The system is up and running except when I want to boot from the
>harddisk (root=/dev/sda3 boot=/dev/sda1, both on jfs). I can proof
>that by mounting the new system when I boot from CD and do a chroot.
>
>I even tried by compiling the kernel with the /proc/config.gz from the
>above CD. Same result as in the subject line:
>Kernel Panic - not syncing: VFS: Unable to mount root fs on unknown-block(8,3)
>
>Yes, I did run lilo -v and that went smoothly; and I do get the Lilo
>manager in the beginning, but after that and some messages: Kernel
>panic...
>
>I'm on 2.6.11.8 from kernel.org
>
>  
>
did you try using Linux root=/dev/hda3 boot=/dev/hda1 ?
