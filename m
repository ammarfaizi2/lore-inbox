Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317576AbSGOS3U>; Mon, 15 Jul 2002 14:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317578AbSGOS3T>; Mon, 15 Jul 2002 14:29:19 -0400
Received: from 212.Red-80-35-44.pooles.rima-tde.net ([80.35.44.212]:3968 "EHLO
	DervishD.pleyades.net") by vger.kernel.org with ESMTP
	id <S317576AbSGOS3R>; Mon, 15 Jul 2002 14:29:17 -0400
Date: Mon, 15 Jul 2002 20:39:15 +0200
Organization: Pleyades
To: mvolaski@aecom.yu.edu, linux-kernel@vger.kernel.org
Subject: Re: Mount corrupts an ext2 filesystem on a RAM disk
Message-ID: <3D3316D3.mail1J41H5VK0@viadomus.com>
References: <a05111619b958ac72d6b3@[129.98.90.227]>
In-Reply-To: <a05111619b958ac72d6b3@[129.98.90.227]>
User-Agent: nail 9.31 6/18/02
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
From: DervishD <raul@pleyades.net>
Reply-To: DervishD <raul@pleyades.net>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Maurice :)

>Also, later on I learned that one must "cd" into the mounted ramdisk
>to cause the corruption.

    I've reproduced all your steps and my ramdisk didn't get
corrupted. See below.

>I do the following to setup a ram disk on /dev/ram0...
>dd if=/dev/zero of=/dev/ram0 bs=1k count=4096
>mkfs.ext2 /dev/ram0 -m 0 -N 4096

    Identical commands issued...

>I mount it and already the lost+found directory is not there.

    Mine is OK. The lost+found is there. I don't suffer any of the
other problems you tell, neither.

    Maybe you have bad ram chips, or a damaged mke2fs (unlikely), but
the kernel seems to work OK. I've tested with 2.4.18 and 2.4.17.

    Raúl
