Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262088AbUKVMt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262088AbUKVMt4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 07:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262083AbUKVMtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 07:49:06 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:44551 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262062AbUKVMs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 07:48:57 -0500
Date: Mon, 22 Nov 2004 13:48:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] Use -ffreestanding? (fwd)
Message-ID: <20041122124855.GK3007@stusta.de>
References: <20041122054959.GI3007@stusta.de> <Pine.LNX.4.53.0411220934480.21333@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0411220934480.21333@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 09:36:15AM +0100, Jan Engelhardt wrote:
> >Hi Andrew,
> >
> >for the kernel, it would be logical to use -ffreestanding. The kernel is
> >not a hosted environment with a standard C library.
> 
> Note the GCC docs:
> 
> Assert that compilation takes place in a freestanding environment. This
> implies -fno-builtin. [...]
> 
> This will break a lot of code, since there are many thing that depend upon GCC
> builtin magic AFAICS.
>...

Which code in the kernel is broken by this change?

Note that explicitely using a gcc builtin is still possible.

> Jan Engelhardt

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

