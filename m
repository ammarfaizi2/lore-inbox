Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289770AbSAOXur>; Tue, 15 Jan 2002 18:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289769AbSAOXum>; Tue, 15 Jan 2002 18:50:42 -0500
Received: from jalon.able.es ([212.97.163.2]:41978 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S289768AbSAOXtq>;
	Tue, 15 Jan 2002 18:49:46 -0500
Date: Wed, 16 Jan 2002 00:55:41 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Wakko Warner <wakko@animx.eu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unable to compile 2.4.14 on alpha
Message-ID: <20020116005541.C1838@werewolf.able.es>
In-Reply-To: <20020114212550.A17323@animx.eu.org> <20020115113213.A1539@werewolf.able.es> <20020115115530.A19073@animx.eu.org> <20020116002642.A1838@werewolf.able.es> <20020115185245.A20198@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: =?iso-8859-1?Q?=3C20020115185245=2EA20198?=
	=?iso-8859-1?B?QGFuaW14LmV1Lm9yZz47IGZyb20gd2Fra29AYW5pbXguZXUub3JnIG9u?=
	=?iso-8859-1?B?IG1p6Sw=?= ene 16, 2002 at 00:52:45 +0100
X-Mailer: Balsa 1.3.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20020116 Wakko Warner wrote:
>Ok, 2.4.17:
>gcc -D__KERNEL__ -I/usr/src/2.4.17/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev4 -Wa,-mev6 -DMODULE   -DEXPORT_SYMTAB -c DAC960.c
>DAC960.c: In function `DAC960_V2_EnableMemoryMailboxInterface':
>DAC960.c:1054: internal error--unrecognizable insn:
>(insn 949 477 474 (set (reg:DI 2 $2)
>        (plus:DI (reg:DI 30 $30)
>            (const_int 4398046511104 [0x40000000000]))) -1 (nil)
>    (nil))

ev5 ? No idea about alphas. gcc version ?

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.18-pre3-beo #5 SMP Sun Jan 13 02:14:04 CET 2002 i686
