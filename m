Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263488AbTDGPcl (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 11:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263492AbTDGPcl (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 11:32:41 -0400
Received: from zork.zork.net ([66.92.188.166]:26000 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S263488AbTDGPcj (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 11:32:39 -0400
To: bboett@bboett.dyndns.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.66 not compiling
From: Sean Neakums <sneakums@zork.net>
X-Worst-Pick-Up-Line-Ever: "Hey baby, wanna peer with my leafnode instance?"
X-Message-Flag: Message text advisory: AMPHIBOLY, SALACIOUS IMAGININGS
X-Mailer: Norman
X-Groin-Mounted-Steering-Wheel: "Arrrr... it's driving me nuts!"
X-Alameda: WHY DOESN'T ANYONE KNOW ABOUT ALAMEDA?  IT'S RIGHT NEXT TO
 OAKLAND!!!
Organization: The Emadonics Institute
Mail-Followup-To: bboett@bboett.dyndns.org, linux-kernel@vger.kernel.org
Date: Mon, 07 Apr 2003 16:44:12 +0100
In-Reply-To: <20030407153006.GC1088@adlp.org> (Bruno Boettcher's message of
 "Mon, 7 Apr 2003 17:30:06 +0200")
Message-ID: <6ud6jy1feb.fsf@zork.zork.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.2 (gnu/linux)
References: <20030407153006.GC1088@adlp.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

commence  Bruno Boettcher quotation:

> when trying to make a make bzImage i get :
>
> make -f scripts/Makefile.build obj=fs/cramfs
>   gcc -Wp,-MD,fs/cramfs/.inode.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=inode -DKBUILD_MODNAME=cramfs -c -o fs/cramfs/.tmp_inode.o fs/cramfs/inode.c
> fs/cramfs/inode.c: In function `get_cramfs_inode':
> fs/cramfs/inode.c:54: incompatible types in assignment
> make[2]: *** [fs/cramfs/inode.o] Fehler 1
>
>
> not the faintest idea on what did get wrong... so if someone has an
> idea... i will take it :D 

If you don't actually need cramfs, just configure it out.  Distro
kernel configs tend to be kitchen-sinkish.

-- 
Sean Neakums - <sneakums@zork.net>
