Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263461AbTEMXro (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 19:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263521AbTEMXro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 19:47:44 -0400
Received: from adsl-64-123-58-8.dsl.stlsmo.swbell.net ([64.123.58.8]:49283
	"EHLO base.torri.linux") by vger.kernel.org with ESMTP
	id S263461AbTEMXre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 19:47:34 -0400
Subject: Compile error including asm/uaccess.h
From: Stephen Torri <storri@sbcglobal.net>
To: bug-glibc@gnu.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-NoGAMevDhR9e3/9wwL+9"
Organization: 
Message-Id: <1052871028.15836.24.camel@base>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 13 May 2003 19:10:28 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NoGAMevDhR9e3/9wwL+9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

    GLIBC VERSION: 2.3.1

    HOST MACHINE and OPERATING SYSTEM: i686 Gentoo Linux 1.4.2.9

    KERNEL VERSION: 2.4.18

    TARGET MACHINE and OPERATING SYSTEM, if different from HOST: Same

    COMPILER NAME AND VERSION (AND PATCHLEVEL): g++ 3.2.2

    DOES THE PROBLEM AFFECT:
        COMPILATION? Yes.
        LINKING? No
        EXECUTION? No
        OTHER (please specify)? No

    SYNOPSIS:

Receiving a compiler error when attempting to include asm/uacccess.h

    DESCRIPTION:

I am compiling a program that is written in C++ so the g++ compiler is
being used to compile the source. On of the headers of a dependent
library is including asm/uaccess.h. When I attempt to compile this
program I get parse errors.

=3D=3D=3D=3D=3D=3D Errors (C++) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

In file included from /usr/include/linux/sched.h:14,
                 from /usr/include/asm/uaccess.h:8,
                 from test.cpp:1:
/usr/include/linux/timex.h:173: field `time' has incomplete type
In file included from /usr/include/linux/sched.h:17,
                 from /usr/include/asm/uaccess.h:8,
                 from test.cpp:1:
/usr/include/asm/system.h:238: parse error before `new'
/usr/include/asm/system.h: In function `long unsigned int
__cmpxchg(...)':
/usr/include/asm/system.h:241: `size' undeclared (first use this
function)
/usr/include/asm/system.h:241: (Each undeclared identifier is reported
only=20
   once for each function it appears in.)
/usr/include/asm/system.h:245: parse error before `)' token
/usr/include/asm/system.h:251: parse error before `)' token
/usr/include/asm/system.h:257: parse error before `)' token
/usr/include/asm/system.h:261: `old' undeclared (first use this
function)
In file included from /usr/include/asm/smp.h:15,
                 from /usr/include/linux/smp.h:14,
                 from /usr/include/linux/sched.h:23,
                 from /usr/include/asm/uaccess.h:8,
                 from test.cpp:1:
/usr/include/asm/fixmap.h: At global scope:
/usr/include/asm/fixmap.h:77: type specifier omitted for parameter
`pgprot_t'
/usr/include/asm/fixmap.h:77: parse error before `)' token
In file included from /usr/include/asm/smp.h:21,
                 from /usr/include/linux/smp.h:14,
                 from /usr/include/linux/sched.h:23,
                 from /usr/include/asm/uaccess.h:8,
                 from test.cpp:1:
/usr/include/asm/apic.h:85: `pm_dev_t' was not declared in this scope
/usr/include/asm/apic.h:85: parse error before `long'
In file included from /usr/include/linux/sched.h:23,
                 from /usr/include/asm/uaccess.h:8,
                 from test.cpp:1:
/usr/include/linux/smp.h:29: parse error before `)' token
In file included from /usr/include/asm/processor.h:11,
                 from /usr/include/linux/sched.h:87,
                 from /usr/include/asm/uaccess.h:8,
                 from test.cpp:1:
/usr/include/asm/math_emu.h: In function `void FASTCALL(...)':
/usr/include/asm/math_emu.h:6: non-local function `int
restore_i387_soft(void*,=20
   FASTCALL(...)::_fpstate*)' uses local type `FASTCALL(...)::_fpstate'
/usr/include/asm/math_emu.h:7: non-local function `int
save_i387_soft(void*,=20
   FASTCALL(...)::_fpstate*)' uses local type `FASTCALL(...)::_fpstate'
In file included from /usr/include/linux/sched.h:87,
                 from /usr/include/asm/uaccess.h:8,
                 from test.cpp:1:
/usr/include/asm/processor.h:73: non-local variable
`FASTCALL(...)::cpuinfo_x86=20
   boot_cpu_data' uses local type `FASTCALL(...)::cpuinfo_x86'
/usr/include/asm/processor.h:77: non-local variable
`FASTCALL(...)::cpuinfo_x86=20
   cpu_data[]' uses local type `FASTCALL(...)::cpuinfo_x86'
/usr/include/asm/processor.h:97: non-local function `void=20
   identify_cpu(FASTCALL(...)::cpuinfo_x86*)' uses local type `
   FASTCALL(...)::cpuinfo_x86'
/usr/include/asm/processor.h:98: non-local function `void=20
   print_cpu_info(FASTCALL(...)::cpuinfo_x86*)' uses local type `
   FASTCALL(...)::cpuinfo_x86'
/usr/include/asm/processor.h:126: cannot declare static function inside
another=20
   function
/usr/include/asm/processor.h: In function `void cpuid(int, int*, int*,
int*,=20
   int*)':
/usr/include/asm/processor.h:139: cannot declare static function inside
another=20
   function
/usr/include/asm/processor.h: In function `unsigned int
cpuid_eax(unsigned=20
   int)':
/usr/include/asm/processor.h:149: cannot declare static function inside
another=20
   function
/usr/include/asm/processor.h: In function `unsigned int
cpuid_ebx(unsigned=20
   int)':
/usr/include/asm/processor.h:159: cannot declare static function inside
another=20
   function
/usr/include/asm/processor.h: In function `unsigned int
cpuid_ecx(unsigned=20
   int)':
/usr/include/asm/processor.h:169: cannot declare static function inside
another=20
   function
/usr/include/asm/processor.h: In function `unsigned int
cpuid_edx(unsigned=20
   int)':
/usr/include/asm/processor.h:206: cannot declare static function inside
another=20
   function
/usr/include/asm/processor.h: In function `void set_in_cr4(long unsigned
int)':
/usr/include/asm/processor.h:216: cannot declare static function inside
another=20
   function
/usr/include/asm/processor.h: In function `void clear_in_cr4(long
unsigned=20
   int)':
/usr/include/asm/processor.h:432: non-local function `void=20
   release_thread(clear_in_cr4(long unsigned int)::task_struct*)' uses
local=20
   type `clear_in_cr4(long unsigned int)::task_struct'
/usr/include/asm/processor.h:439: non-local function `void=20
   copy_segments(clear_in_cr4(long unsigned int)::task_struct*,=20
   clear_in_cr4(long unsigned int)::mm_struct*)' uses local type `
   clear_in_cr4(long unsigned int)::task_struct'
/usr/include/asm/processor.h:440: non-local function `void=20
   release_segments(clear_in_cr4(long unsigned int)::mm_struct*)' uses
local=20
   type `clear_in_cr4(long unsigned int)::mm_struct'
/usr/include/asm/processor.h:446: cannot declare static function inside
another=20
   function
/usr/include/asm/processor.h: In function `long unsigned int=20
   thread_saved_pc(clear_in_cr4(long unsigned int)::thread_struct*)':
/usr/include/asm/processor.h:450: non-local function `long unsigned int=20
   get_wchan(clear_in_cr4(long unsigned int)::task_struct*)' uses local
type `
   clear_in_cr4(long unsigned int)::task_struct'
/usr/include/asm/processor.h:479: cannot declare static function inside
another=20
   function
In file included from /usr/include/asm/uaccess.h:9,
                 from test.cpp:1:
/usr/include/linux/prefetch.h: In function `void prefetch(const void*)':
/usr/include/linux/prefetch.h:48: cannot declare static function inside
another=20
   function
In file included from test.cpp:1:
/usr/include/asm/uaccess.h: In function `void prefetchw(const void*)':
/usr/include/asm/uaccess.h:63: cannot declare static function inside
another=20
   function
/usr/include/asm/uaccess.h: In function `int verify_area(int, const
void*, long=20
   unsigned int)':
/usr/include/asm/uaccess.h:64: `current' undeclared (first use this
function)
/usr/include/asm/uaccess.h:64: `EFAULT' undeclared (first use this
function)
/usr/include/asm/uaccess.h:310: cannot declare static function inside
another=20
   function
/usr/include/asm/uaccess.h: In function `long unsigned int=20
   __generic_copy_from_user_nocheck(void*, const void*, long unsigned
int)':
/usr/include/asm/uaccess.h:317: cannot declare static function inside
another=20
   function
/usr/include/asm/uaccess.h: In function `long unsigned int=20
   __generic_copy_to_user_nocheck(void*, const void*, long unsigned
int)':
/usr/include/asm/uaccess.h:548: cannot declare static function inside
another=20
   function
/usr/include/asm/uaccess.h: In function `long unsigned int=20
   __constant_copy_to_user(void*, const void*, long unsigned int)':
/usr/include/asm/uaccess.h:557: cannot declare static function inside
another=20
   function
/usr/include/asm/uaccess.h: In function `long unsigned int=20
   __constant_copy_from_user(void*, const void*, long unsigned int)':
/usr/include/asm/uaccess.h:561: `memset' undeclared (first use this
function)
/usr/include/asm/uaccess.h:567: cannot declare static function inside
another=20
   function
/usr/include/asm/uaccess.h: In function `long unsigned int=20
   __constant_copy_to_user_nocheck(void*, const void*, long unsigned
int)':
/usr/include/asm/uaccess.h:574: cannot declare static function inside
another=20
   function


    REPEAT BY:

Here a test programs that I did:

#include <asm/uaccess.h>

int main (){
	return 0;
}



    SAMPLE FIX/WORKAROUND:

None.

Stephen


--=20
Stephen Torri <storri@sbcglobal.net>

--=-NoGAMevDhR9e3/9wwL+9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+wYl0mXRzpT81NcgRAr8IAKCJMP8i1Ls7Al5Yb1LDLxjWzyTM6wCePB3s
pQyhIe63Xd/Rhq9aPbig2zI=
=f+6Y
-----END PGP SIGNATURE-----

--=-NoGAMevDhR9e3/9wwL+9--

