Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261313AbSJLSZn>; Sat, 12 Oct 2002 14:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261317AbSJLSZn>; Sat, 12 Oct 2002 14:25:43 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:15767 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S261313AbSJLSZm>; Sat, 12 Oct 2002 14:25:42 -0400
Date: Sat, 12 Oct 2002 13:31:30 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
cc: linux-kernel@vger.kernel.org, <torvalds@transmeta.com>,
       <user-mode-linux-devel@lists.sourceforge.net>
Subject: Re: [PATCH] 2.5.42: UML build error
In-Reply-To: <87smzbv7ml.fsf@goat.bogus.local>
Message-ID: <Pine.LNX.4.44.0210121330390.17947-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Oct 2002, Olaf Dietsche wrote:

> Though, it still gives one error right at the beginning:
> 
>   gcc -E -Wp,-MD,arch/um/.uml.lds.s.d_ -D__ASSEMBLY__ -D__KERNEL__ -Iinclude -nostdinc -iwithprefix include   -Ui386 -DSTART=$((0xc0000000 - ((0 + 1) * 0x20000000))) -DELF_ARCH=i386 -DELF_FORMAT=\"elf32-i386\" -P -C -Uum   -o arch/um/uml.lds.s arch/um/uml.lds.S 
> /bin/sh: scripts/fixdep: No such file or directory
> make: *** [arch/um/uml.lds.s] Error 1

Try a "make scripts" first, that should work around it. I'll fix it 
properly.


--Kai


