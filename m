Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266603AbRGGWBB>; Sat, 7 Jul 2001 18:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266600AbRGGWAv>; Sat, 7 Jul 2001 18:00:51 -0400
Received: from fenrus.demon.co.uk ([158.152.228.152]:14295 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S266603AbRGGWAj>;
	Sat, 7 Jul 2001 18:00:39 -0400
Message-Id: <m15J07v-000OzlC@amadeus.home.nl>
Date: Sat, 7 Jul 2001 23:00:35 +0100 (BST)
From: arjan@fenrus.demon.nl
To: lk@tantalophile.demon.co.uk (Jamie Lokier)
Subject: Re: [Acpi] Re: ACPI fundamental locking problems
cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010707235329.A10256@pcep-jamie.cern.ch>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010707235329.A10256@pcep-jamie.cern.ch> you wrote:
>> Would it be possible to use a cramfs image in vmlinux (i.e. real
>> filesystem image, not an in-kernel-structures fs like ramfs), and map
>> it directly from the kernel image (it would have to be suitably aligned,
>> of course)?

> Yes that would work, and it would work on machines with less RAM too.
> You would want to remove the cramfs filesystem code when you're done though.

Until you pxe-boot your kernel over the network........
