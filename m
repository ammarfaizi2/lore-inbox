Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289779AbSAOX5c>; Tue, 15 Jan 2002 18:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289781AbSAOXyn>; Tue, 15 Jan 2002 18:54:43 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:64647
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S290246AbSAOXyH>; Tue, 15 Jan 2002 18:54:07 -0500
Date: Tue, 15 Jan 2002 19:03:44 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unable to compile 2.4.14 on alpha
Message-ID: <20020115190344.A20283@animx.eu.org>
In-Reply-To: <20020114212550.A17323@animx.eu.org> <20020115113213.A1539@werewolf.able.es> <20020115115530.A19073@animx.eu.org> <20020116002642.A1838@werewolf.able.es> <20020115185245.A20198@animx.eu.org> <20020116005541.C1838@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20020116005541.C1838@werewolf.able.es>; from J.A. Magallon on Wed, Jan 16, 2002 at 12:55:41AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Ok, 2.4.17:
> >gcc -D__KERNEL__ -I/usr/src/2.4.17/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev4 -Wa,-mev6 -DMODULE   -DEXPORT_SYMTAB -c DAC960.c
> >DAC960.c: In function `DAC960_V2_EnableMemoryMailboxInterface':
> >DAC960.c:1054: internal error--unrecognizable insn:
> >(insn 949 477 474 (set (reg:DI 2 $2)
> >        (plus:DI (reg:DI 30 $30)
> >            (const_int 4398046511104 [0x40000000000]))) -1 (nil)
> >    (nil))
> 
> ev5 ? No idea about alphas. gcc version ?

the kernel was compiled with 2.95.4 which is in debian's woody.  I also
installed debian's gcc-3.0 package.  it does compile dac960.

No, it's an EV4.  gcc 2.95.2 did nothing but eat all my memory on this file.

just out of curiosity, I have this dac960 controller with alpha 2.70
firmware.  I know it says it needs 2.73, but the latest for alpha is 2.70. 
Any ideas if it'll work or not?

If I loose the contents of everything on this sytem, fine, I have another
disk with the system on it so I won't loose anything.  =)

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
