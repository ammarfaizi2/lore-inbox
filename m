Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271948AbRHVKPT>; Wed, 22 Aug 2001 06:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271949AbRHVKPK>; Wed, 22 Aug 2001 06:15:10 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:53003 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271948AbRHVKOx>; Wed, 22 Aug 2001 06:14:53 -0400
Subject: Re: 2.4.9 pc_keyb.c compile fails with gcc 3.0 on alpha
To: tomh@po.crl.go.jp (Tom Holroyd)
Date: Wed, 22 Aug 2001 11:17:51 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (kernel mailing list)
In-Reply-To: <Pine.LNX.4.30.0108221103420.11775-100000@holly.crl.go.jp> from "Tom Holroyd" at Aug 22, 2001 11:04:44 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ZV55-0001Gg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In file included from pc_keyb.c:36:
> /usr/src/linux-2.4.9/include/asm/keyboard.h:25: warning: `struct
> kbd_repeat' declared inside parameter list
> /usr/src/linux-2.4.9/include/asm/keyboard.h:25: warning: its scope is only
> this definition or declaration, which is probably not what you want.
> pc_keyb.c:545: variable `kbdrate' has initializer but incomplete type
> pc_keyb.c:546: warning: excess elements in struct initializer

Pull the relevant changes from the 2.4.8-ac tree.
