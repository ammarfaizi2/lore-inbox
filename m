Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272305AbRH3QMd>; Thu, 30 Aug 2001 12:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272307AbRH3QMY>; Thu, 30 Aug 2001 12:12:24 -0400
Received: from [212.131.173.131] ([212.131.173.131]:13976 "HELO
	videoblaster.it") by vger.kernel.org with SMTP id <S272305AbRH3QMM>;
	Thu, 30 Aug 2001 12:12:12 -0400
Message-ID: <3B8E6055.42EF59FB@videoblaster.it>
Date: Thu, 30 Aug 2001 17:48:37 +0200
From: Roberto Gaggiotti <rgaggiotti@videoblaster.it>
Organization: Videoblaster S.r.l.
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.6 alpha)
X-Accept-Language: it, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel 2.4.9 on alphaev56
Content-Type: multipart/mixed;
 boundary="------------EC12844799952D7C4516E982"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------EC12844799952D7C4516E982
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

gcc -D__KERNEL__ -I/usr/src/linux-2.4.9/include -Wall
-Wstrict-prototypes -Wno-t
rigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe
-mno-fp
-regs -ffixed-8 -mcpu=ev56 -Wa,-mev6    -c -o pc_keyb.o pc_keyb.c
In file included from pc_keyb.c:36:
/usr/src/linux-2.4.9/include/asm/keyboard.h:25: warning: `struct
kbd_repeat' dec
lared inside parameter list
/usr/src/linux-2.4.9/include/asm/keyboard.h:25: warning: its scope is
only thisdefinition or declaration, which is probably not what you want.
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
make[3]: Leaving directory `/usr/src/linux-2.4.9/drivers/char'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.9/drivers/char'
make[1]: *** [_subdir_char] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.9/drivers'
make: *** [_dir_drivers] Error
2                                                

-----------------

Linux admin.private.net 2.4.6 #3 gio lug 12 20:38:25 CEST 2001 alpha
unknown
 
Gnu C                  3.0.1
Gnu make               3.79
binutils               2.11.2
util-linux             2.10h
mount                  2.10h
modutils               2.4.6
e2fsprogs              1.20-WIP
isdn4k-utils           3.1beta7
Linux C Library        2.1.3
Dynamic linker (ldd)   2.1.3
Linux C++ Library      3.0.1
Procps                 2.0.6
Net-tools              1.55
Console-tools          0.2.3
Sh-utils               2.0
cat: /proc/modules: File o directory inesistente
Modules
Loaded
--------------EC12844799952D7C4516E982
Content-Type: text/x-vcard; charset=us-ascii;
 name="rgaggiotti.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Roberto Gaggiotti
Content-Disposition: attachment;
 filename="rgaggiotti.vcf"

begin:vcard 
n:Gaggiotti;Roberto
x-mozilla-html:FALSE
url:www.videoblaster.it
org:Videoblaster S.r.l.
adr:;;Via Montebello, 71;Ancona;Italy;60127;
version:2.1
email;internet:rgaggiotti@videoblaster.it
x-mozilla-cpt:;0
fn:Roberto Gaggiotti
end:vcard

--------------EC12844799952D7C4516E982--

