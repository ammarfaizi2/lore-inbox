Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280980AbRKGWAQ>; Wed, 7 Nov 2001 17:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280954AbRKGWAH>; Wed, 7 Nov 2001 17:00:07 -0500
Received: from zeus.kernel.org ([204.152.189.113]:48361 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S280980AbRKGV7z>;
	Wed, 7 Nov 2001 16:59:55 -0500
From: arjan@fenrus.demon.nl
To: rl@math.technion.ac.il (Zvi Har'El)
Subject: Re: ext3 vs resiserfs vs xfs
cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.33.0111072302460.12525-100000@leeor.math.technion.ac.il>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Message-Id: <E161aYo-0000ch-00@fenrus.demon.nl>
Date: Wed, 07 Nov 2001 21:48:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.GSO.4.33.0111072302460.12525-100000@leeor.math.technion.ac.il> you wrote:
> On Wed, 7 Nov 2001, Andreas Dilger wrote:

> /dev/root / ext2 rw 0 0

ext2! 

> /dev/hda6 /home ext3 rw 0 0

> How do  fix the situation at this stage? I am using Redhat 7.2 with kernel
> 2.4.9-13

Be sure to use the initrd as used by default in when you install the kernel. 
Are you using lilo ?   If so add

initrd /boot/initrd-2.4.9-13.img

to the lilo.conf in the relevant kernel section.

Greetings,
  Arjan van de Ven
