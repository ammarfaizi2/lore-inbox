Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279798AbRKMWsu>; Tue, 13 Nov 2001 17:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279787AbRKMWsk>; Tue, 13 Nov 2001 17:48:40 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:15885 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S278617AbRKMWsZ>;
	Tue, 13 Nov 2001 17:48:25 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: mjacob@feral.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Announce: modutils 2.4.11 is available 
In-Reply-To: Your message of "Tue, 13 Nov 2001 10:46:05 -0800."
             <Pine.BSF.4.21.0111131045540.78620-100000@beppo> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 14 Nov 2001 09:48:14 +1100
Message-ID: <19387.1005691694@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2001 10:46:05 -0800 (PST), 
Matthew Jacob <mjacob@feral.com> wrote:
>gcc -O2 -Wall -I./../include -D_GNU_SOURCE  -DCONFIG_ROOT_CHECK_OFF=0
>-DCOMMON_3264 -DELF_MACHINE_H='"elf_ppc64.h"' -DARCH_ppc64 -DONLY_64 -c -o
>obj_ppc64_64.o obj_ppc64.c
>In file included from ../include/obj.h:34,
>                 from obj_ppc64.c:25:
>../include/elf_ppc64.h:89: unbalanced `#endif'
>make[1]: *** [obj_ppc64_64.o] Error 1

My fault, remove the last two lines of include/elf_ppc64.h.

