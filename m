Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271915AbRHVCEv>; Tue, 21 Aug 2001 22:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271920AbRHVCEm>; Tue, 21 Aug 2001 22:04:42 -0400
Received: from ns1.crl.go.jp ([133.243.3.1]:58366 "EHLO ns1.crl.go.jp")
	by vger.kernel.org with ESMTP id <S271915AbRHVCEc>;
	Tue, 21 Aug 2001 22:04:32 -0400
Date: Wed, 22 Aug 2001 11:04:44 +0900 (JST)
From: Tom Holroyd <tomh@po.crl.go.jp>
To: kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.4.9 pc_keyb.c compile fails with gcc 3.0 on alpha
Message-ID: <Pine.LNX.4.30.0108221103420.11775-100000@holly.crl.go.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In file included from pc_keyb.c:36:
/usr/src/linux-2.4.9/include/asm/keyboard.h:25: warning: `struct
kbd_repeat' declared inside parameter list
/usr/src/linux-2.4.9/include/asm/keyboard.h:25: warning: its scope is only
this definition or declaration, which is probably not what you want.
pc_keyb.c:545: variable `kbdrate' has initializer but incomplete type
pc_keyb.c:546: warning: excess elements in struct initializer
pc_keyb.c:546: warning: (near initialization for `kbdrate')
pc_keyb.c:548: warning: excess elements in struct initializer
pc_keyb.c:548: warning: (near initialization for `kbdrate')
pc_keyb.c: In function `parse_kbd_rate':
pc_keyb.c:574: dereferencing pointer to incomplete type
pc_keyb.c:575: dereferencing pointer to incomplete type
pc_keyb.c:575: invalid use of undefined type `struct kbd_repeat'
pc_keyb.c:576: dereferencing pointer to incomplete type
pc_keyb.c:577: dereferencing pointer to incomplete type
pc_keyb.c:577: invalid use of undefined type `struct kbd_repeat'
pc_keyb.c:579: dereferencing pointer to incomplete type
pc_keyb.c:585: dereferencing pointer to incomplete type
pc_keyb.c:590: dereferencing pointer to incomplete type
pc_keyb.c:591: dereferencing pointer to incomplete type
pc_keyb.c: At top level:
pc_keyb.c:606: conflicting types for `pckbd_rate'
/usr/src/linux-2.4.9/include/asm/keyboard.h:25: previous declaration of
`pckbd_rate'
pc_keyb.c: In function `pckbd_rate':
pc_keyb.c:611: storage size of `old_rep' isn't known
pc_keyb.c:612: sizeof applied to an incomplete type
pc_keyb.c:614: sizeof applied to an incomplete type
pc_keyb.c:615: sizeof applied to an incomplete type
pc_keyb.c:611: warning: unused variable `old_rep'
pc_keyb.c: At top level:
pc_keyb.c:545: storage size of `kbdrate' isn't known
make[3]: *** [pc_keyb.o] Error 1


