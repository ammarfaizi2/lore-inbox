Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129192AbQKMGAI>; Mon, 13 Nov 2000 01:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129401AbQKMF76>; Mon, 13 Nov 2000 00:59:58 -0500
Received: from mail.sun.ac.za ([146.232.128.1]:26117 "EHLO mail.sun.ac.za")
	by vger.kernel.org with ESMTP id <S129192AbQKMF7t>;
	Mon, 13 Nov 2000 00:59:49 -0500
Date: Mon, 13 Nov 2000 07:59:43 +0200 (SAST)
From: Hans Grobler <grobh@sun.ac.za>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: test11pre3: MD module compile fail, sysctl.h again
Message-ID: <Pine.LNX.4.21.0011130757210.19245-100000@ccs.sun.ac.za>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make -C md modules
make[2]: Entering directory `/usr/src/linux-2.4.0-test11-pre3/drivers/md'
kgcc -D__KERNEL__ -I/usr/src/linux-2.4.0-test11-pre3/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe  -march=i686 -DMODULE -DMODVERSIONS -include /usr/src/linux-2.4.0-test11-pre3/include/linux/modversions.h   -DEXPORT_SYMTAB -c md.c
In file included from md.c:33:
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:35: parse error before `size_t'
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:35: warning: no semicolon at end of struct or union
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:37: parse error before `newlen'
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:37: warning: type defaults to `int' in declaration of `newlen'
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:37: warning: data definition has no type or storage class
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:39: parse error before `}'
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:598: syntax error before `long'
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:604: parse error before `size_t'
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:606: warning: function declaration isn't a prototype
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:609: parse error before `size_t'
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:609: warning: `struct file' declared inside parameter list
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:609: warning: its scope is only this definition or declaration,
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:609: warning: which is probably not what you want.
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:609: warning: function declaration isn't a prototype
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:612: parse error before `size_t'
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:612: warning: `struct file' declared inside parameter list
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:612: warning: function declaration isn't a prototype
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:614: parse error before `size_t'
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:614: warning: `struct file' declared inside parameter list
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:614: warning: function declaration isn't a prototype
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:616: parse error before `size_t'
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:616: warning: `struct file' declared inside parameter list
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:616: warning: function declaration isn't a prototype
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:618: parse error before `size_t'
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:618: warning: `struct file' declared inside parameter list
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:618: warning: function declaration isn't a prototype
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:620: parse error before `size_t'
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:620: warning: `struct file' declared inside parameter list
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:620: warning: function declaration isn't a prototype
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:622: parse error before `size_t'
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:622: warning: `struct file' declared inside parameter list
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:622: warning: function declaration isn't a prototype
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:624: parse error before `size_t'
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:624: warning: `struct file' declared inside parameter list
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:624: warning: function declaration isn't a prototype
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:627: parse error before `size_t'
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:628: warning: function declaration isn't a prototype
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:632: parse error before `size_t'
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:633: warning: function declaration isn't a prototype
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:684: parse error before `mode_t'
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:684: warning: no semicolon at end of struct or union
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:686: `proc_handler' redeclared as different kind of symbol
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:609: previous declaration of `proc_handler'
/usr/src/linux-2.4.0-test11-pre3/include/linux/sysctl.h:691: parse error before `}'
md.c:83: elements of array `raid_table' have incomplete type
md.c:84: warning: excess elements in struct initializer after `raid_table[0]'
md.c:84: warning: excess elements in struct initializer after `raid_table[0]'
md.c:85: warning: excess elements in struct initializer after `raid_table[0]'
md.c:85: warning: excess elements in struct initializer after `raid_table[0]'
md.c:85: warning: excess elements in struct initializer after `raid_table[0]'
md.c:85: warning: excess elements in struct initializer after `raid_table[0]'
md.c:85: warning: excess elements in struct initializer after `raid_table[0]'
md.c:86: warning: excess elements in struct initializer after `raid_table[1]'
md.c:86: warning: excess elements in struct initializer after `raid_table[1]'
md.c:87: warning: excess elements in struct initializer after `raid_table[1]'
md.c:87: warning: excess elements in struct initializer after `raid_table[1]'
md.c:87: warning: excess elements in struct initializer after `raid_table[1]'
md.c:87: warning: excess elements in struct initializer after `raid_table[1]'
md.c:87: warning: excess elements in struct initializer after `raid_table[1]'
md.c:88: warning: excess elements in struct initializer after `raid_table[2]'
md.c:89: invalid use of undefined type `struct ctl_table'
md.c:91: elements of array `raid_dir_table' have incomplete type
md.c:92: warning: excess elements in struct initializer after `raid_dir_table[0]'
md.c:92: warning: excess elements in struct initializer after `raid_dir_table[0]'
md.c:92: warning: excess elements in struct initializer after `raid_dir_table[0]'
md.c:92: warning: excess elements in struct initializer after `raid_dir_table[0]'
md.c:92: warning: excess elements in struct initializer after `raid_dir_table[0]'
md.c:92: warning: excess elements in struct initializer after `raid_dir_table[0]'
md.c:93: warning: excess elements in struct initializer after `raid_dir_table[1]'
md.c:94: invalid use of undefined type `struct ctl_table'
md.c:96: elements of array `raid_root_table' have incomplete type
md.c:97: warning: excess elements in struct initializer after `raid_root_table[0]'
md.c:97: warning: excess elements in struct initializer after `raid_root_table[0]'
md.c:97: warning: excess elements in struct initializer after `raid_root_table[0]'
md.c:97: warning: excess elements in struct initializer after `raid_root_table[0]'
md.c:97: warning: excess elements in struct initializer after `raid_root_table[0]'
md.c:97: warning: excess elements in struct initializer after `raid_root_table[0]'
md.c:98: warning: excess elements in struct initializer after `raid_root_table[1]'
md.c:99: invalid use of undefined type `struct ctl_table'
{standard input}: Assembler messages:
{standard input}:8: Warning: Ignoring changed section attributes for .modinfo
make[2]: *** [md.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.0-test11-pre3/drivers/md'
make[1]: *** [_modsubdir_md] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.0-test11-pre3/drivers'
make: *** [_mod_drivers] Error 2

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
