Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316819AbSEaTqx>; Fri, 31 May 2002 15:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316822AbSEaTqw>; Fri, 31 May 2002 15:46:52 -0400
Received: from [195.39.17.254] ([195.39.17.254]:21662 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316819AbSEaTqv>;
	Fri, 31 May 2002 15:46:51 -0400
Date: Fri, 31 May 2002 10:47:47 +0000
From: Pavel Machek <pavel@suse.cz>
To: Paul Mackerras <paulus@samba.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix platforms without suspend
Message-ID: <20020531104747.A37@toy.ucw.cz>
In-Reply-To: <15604.48752.953866.585175@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> At the moment, any architecture that doesn't have <asm/suspend.h>
> won't compile.  The patch below changes <linux/suspend.h> so it only
> looks for <asm/suspend.h> if CONFIG_SOFTWARE_SUSPEND is set.
> 
> Linus, it would be good if you would apply this to your tree so that
> architectures other than i386 will compile.

This is wrong, because suspend-to-RAM also needs asm/suspend.h, and already
fixed the right way in the main tree.
									Pavel

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

