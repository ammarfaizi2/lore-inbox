Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135916AbRDTNgD>; Fri, 20 Apr 2001 09:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135917AbRDTNfy>; Fri, 20 Apr 2001 09:35:54 -0400
Received: from [32.97.182.101] ([32.97.182.101]:43488 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S135916AbRDTNfg>;
	Fri, 20 Apr 2001 09:35:36 -0400
From: tom_gall@vnet.ibm.com
Message-ID: <3AE03ADE.9330EB68@vnet.ibm.com>
Date: Fri, 20 Apr 2001 13:34:22 +0000
Reply-To: tom_gall@vnet.ibm.com
Organization: IBM
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.2.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Galloway <jeff.galloway@rundog.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3 Compile Errors - Power Mac
In-Reply-To: <B7054E4B.424E%jeff.galloway@rundog.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Galloway wrote:
> 
> Sorry, Tom about the word doc faux pas.  I've set out my problem in plain
> text below.  I got my source from ftp.kernel.org.

Hi Jeff,

  Well that's problem #1. Source from kernel.org for 2.4 tends to not work on
PPC as it has been lagging on important patches and such. We're hoping to get
kernel.org caught up ASAP.

  Visit here to get the up to date and sometime bleeding edge source for PPC.

  http://www.fsmlabs.com/linuxppcbk.html

> Here's my problem:
> 
> Problem in compiling linux 2.4.3
> 
> Compile error message:
> 
> After the compiler message:
> 
>     gcc ­D__KERNEL__ -I/home/jeff/kernel/linux/include ­Wall
> ­Wstrict-prototypes ­O2 ­fomit-frame-pointer ­fno-strict-aliasing
> ­D__powerpc__ -fsigned-char ­msoft-float ­pipe ­ffixed-r2 ­Wno-uninitialized
> ­mmultiple ­mstring    -c ­o fork.o fork.c
> 
> Compiler error message:
> 
> fork.c: In function ?copy_mm¹:
> fork.c:353: fixed or forbidden register 68 (0) was spilled for class
> CR0_REGS.
> This may be due to a compiler bug or to impossible asm statements or
> clauses.

Which version of gcc do you have? You want either 2.95.2 or 2.95.3



> cpp: output pipe has been closed
> make[2]: *** [fork.o] Error 1
> make[2]: Leaving directory ?/home/jeff/kernel/linux/kernel¹
> make[1]: *** [first_rule] Error 2
> make[1]: Leaving directory ?/home/jeff/kernel/linux/kernel¹
> make: *** [_dir_kernel] Error 2
> 
> Compiling on Power Mac 7600, with dual processor (604e/180) installed,
> running kernel 2.2.18 compiled by Jeff Galloway, but otherwise a Yellow Dog
> distribution.

Ah YDL ... good stuff. Hope you are on 1.2 at least. 8-)

Regards,

Tom

-- 
Tom Gall - PowerPC Linux Team    "Where's the ka-boom? There was
Linux Technology Center           supposed to be an earth
(w) tom_gall@vnet.ibm.com         shattering ka-boom!"
(w) 507-253-4558                 -- Marvin Martian
(h) tgall@rochcivictheatre.org
http://oss.software.ibm.com/developerworks/opensource/linux
