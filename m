Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318635AbSIFOWX>; Fri, 6 Sep 2002 10:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318643AbSIFOWX>; Fri, 6 Sep 2002 10:22:23 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:61400
	"EHLO Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S318635AbSIFOWW>; Fri, 6 Sep 2002 10:22:22 -0400
Date: Fri, 6 Sep 2002 07:26:44 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Wojciech Sas Cieciwa <cieciwa@alpha.zarz.agh.edu.pl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, mingo@elte.hu
Subject: Re: [long] 2.4.19 and O(1) Scheduler [PPC]
Message-ID: <20020906142644.GR761@opus.bloom.county>
References: <Pine.LNX.4.44L.0209061117490.26261-100000@alpha.zarz.agh.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0209061117490.26261-100000@alpha.zarz.agh.edu.pl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2002 at 11:22:54AM +0200, Wojciech Sas Cieciwa wrote:

> I try to compile kernel 2.4.19 with sched-2.4.19-rc2-A4.
> And: 
> 
> gcc -D__KERNEL__ -I/home/users/cieciwa/rpm/BUILD/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -D__powerpc__ -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring   -DKBUILD_BASENAME=main -c -o init/main.o init/main.c
> In file included from /home/users/cieciwa/rpm/BUILD/linux-2.4.19/include/linux/fs.h:26,
>                  from /home/users/cieciwa/rpm/BUILD/linux-2.4.19/include/linux/capability.h:17,
>                  from /home/users/cieciwa/rpm/BUILD/linux-2.4.19/include/linux/binfmts.h:5,
>                  from /home/users/cieciwa/rpm/BUILD/linux-2.4.19/include/linux/sched.h:9,
>                  from /home/users/cieciwa/rpm/BUILD/linux-2.4.19/include/linux/mm.h:4,
>                  from /home/users/cieciwa/rpm/BUILD/linux-2.4.19/include/linux/slab.h:14,
>                  from /home/users/cieciwa/rpm/BUILD/linux-2.4.19/include/linux/proc_fs.h:5,
>                  from init/main.c:15:
> /home/users/cieciwa/rpm/BUILD/linux-2.4.19/include/asm/bitops.h: In function `set_bit':
> /home/users/cieciwa/rpm/BUILD/linux-2.4.19/include/asm/bitops.h:42: parse error before `PPC405_ERR77'
> /home/users/cieciwa/rpm/BUILD/linux-2.4.19/include/asm/bitops.h:37: warning: unused variable `p'
> /home/users/cieciwa/rpm/BUILD/linux-2.4.19/include/asm/bitops.h:36: warning: unused variable `mask'
> [...]

You've got some incomplete PPC patch somewhere,  or you're trying to
compile for an IBM 40x board, which isn't supported by the kernel.org
trees yet.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
