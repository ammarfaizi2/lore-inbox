Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266108AbSIRLKy>; Wed, 18 Sep 2002 07:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266112AbSIRLKy>; Wed, 18 Sep 2002 07:10:54 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:35018 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S266108AbSIRLKx>; Wed, 18 Sep 2002 07:10:53 -0400
Message-ID: <3D8910D3.17F34657@toughguy.net>
Date: Wed, 18 Sep 2002 16:48:35 -0700
From: Bourne <bourne@toughguy.net>
X-Mailer: Mozilla 4.75 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Eric Tchepannou <tcheer@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: Question about the dd command
References: <18955.1032342092@www26.gmx.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Tchepannou wrote:
> 
> Hi all,
> 

> dd if=rootfs of=/dev/fd0 bs=1k seek=KERNEL_BLOCKS
> 
I am surprised to see that with a ls-command the rootfs.gz is invisible
> on the floppy, though the boot process from floppy works properly. 

That's Obvious. you do not have a filesystem on /dev/fd0 and hence 'ls'
wont work.

>Later i
> created an image of the floppy ( dd if=/dev/fd0 of=boot.img bs=10k count=144
> as in the Linux-Bootdisk-HOWTO ), created an iso file from it with mkisofs and
> copied it on CD. Now I can't boot the image from this CD!
> 
Try using xcdroast. 

-- 
The art of life is drawing sufficient conclusions from insufficient
premises
