Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271758AbRICRa4>; Mon, 3 Sep 2001 13:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271760AbRICRar>; Mon, 3 Sep 2001 13:30:47 -0400
Received: from cc885639-a.flushing1.mi.home.com ([24.182.96.34]:56246 "HELO
	caesar.lynix.com") by vger.kernel.org with SMTP id <S271758AbRICRae>;
	Mon, 3 Sep 2001 13:30:34 -0400
Date: Mon, 3 Sep 2001 13:30:25 -0400
From: Subba Rao <subba9@home.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Problems installing FreeS/WAN 1.9.1 on kernel 2.4.9
Message-ID: <20010903133025.B31122@home.com>
Reply-To: Subba Rao <subba9@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could anyone here get FreeS/WAN 1.9.1 to compile on kernel 2.4.9?
My kernel compilation is ending with tons of warnings and errors. Before
installing the FreeS/WAN code, I have customized kernel 2.4.9 and installed it
without any problems.

Here is what I did so far:

	1. tar xzvf freeswan-1.91.tar.gz (in /usr/src)
	2. cd freeswan-1.91
	3. make insert
	4. make programs
	5. make install
	6. cd ../linux
	7. make depend; make bzImage

My distribution is Slackware 8 runnning kernel 2.4.9

I have listed the errors, once build goes into ipsec directory.

If anyone got the ipsec compiled into kernel 2.4.9, please let me know how you
did it.

TIA.
-- 

Subba Rao
subba9@home.com
http://members.home.net/subba9/

GPG public key ID CCB7344E
Key fingerprint = A8DD 4CBA 1E9B D962 A55B  2B55 BAFE 92C5 CCB7 344E

----------------------------Error Messages----------------------------------

make -C ipsec
make[2]: Entering directory `/usr/src/linux/net/ipsec'
make -C libfreeswan
make[3]: Entering directory `/usr/src/linux/net/ipsec/libfreeswan'
make all_targets
make[4]: Entering directory `/usr/src/linux/net/ipsec/libfreeswan'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686  -I. -g -Wall  -Wpointer-arith  -Wstrict-prototypes -Wbad-function-cast   -c -o ultoa.o ultoa.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686  -I. -g -Wall  -Wpointer-arith  -Wstrict-prototypes -Wbad-function-cast   -c -o addrtoa.o addrtoa.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686  -I. -g -Wall  -Wpointer-arith  -Wstrict-prototypes -Wbad-function-cast   -c -o subnettoa.o subnettoa.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686  -I. -g -Wall  -Wpointer-arith  -Wstrict-prototypes -Wbad-function-cast   -c -o subnetof.o subnetof.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686  -I. -g -Wall  -Wpointer-arith  -Wstrict-prototypes -Wbad-function-cast   -c -o goodmask.o goodmask.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686  -I. -g -Wall  -Wpointer-arith  -Wstrict-prototypes -Wbad-function-cast   -c -o datatot.o datatot.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686  -I. -g -Wall  -Wpointer-arith  -Wstrict-prototypes -Wbad-function-cast   -c -o rangetoa.o rangetoa.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686  -I. -g -Wall  -Wpointer-arith  -Wstrict-prototypes -Wbad-function-cast   -c -o satoa.o satoa.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686  -I. -g -Wall  -Wpointer-arith  -Wstrict-prototypes -Wbad-function-cast   -c -o pfkey_v2_parse.o pfkey_v2_parse.c
In file included from /usr/src/linux/include/linux/highmem.h:5,
                 from /usr/src/linux/include/linux/skbuff.h:27,
                 from /usr/src/linux/include/linux/netdevice.h:146,
                 from pfkey_v2_parse.c:38:
/usr/src/linux/include/asm/pgalloc.h: In function `get_pgd_slow':
/usr/src/linux/include/asm/pgalloc.h:53: warning: cast does not match function type
/usr/src/linux/include/asm/pgalloc.h: In function `pte_alloc_one':
/usr/src/linux/include/asm/pgalloc.h:101: warning: cast does not match function type
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686  -I. -g -Wall  -Wpointer-arith  -Wstrict-prototypes -Wbad-function-cast   -c -o pfkey_v2_build.o pfkey_v2_build.c
In file included from /usr/src/linux/include/linux/highmem.h:5,
                 from /usr/src/linux/include/linux/skbuff.h:27,
                 from /usr/src/linux/include/linux/netdevice.h:146,
                 from pfkey_v2_build.c:38:
/usr/src/linux/include/asm/pgalloc.h: In function `get_pgd_slow':
/usr/src/linux/include/asm/pgalloc.h:53: warning: cast does not match function type
/usr/src/linux/include/asm/pgalloc.h: In function `pte_alloc_one':
/usr/src/linux/include/asm/pgalloc.h:101: warning: cast does not match function type
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686  -I. -g -Wall  -Wpointer-arith  -Wstrict-prototypes -Wbad-function-cast   -c -o pfkey_v2_ext_bits.o pfkey_v2_ext_bits.c
In file included from /usr/src/linux/include/linux/highmem.h:5,
                 from /usr/src/linux/include/linux/skbuff.h:27,
                 from /usr/src/linux/include/linux/netdevice.h:146,
                 from pfkey_v2_ext_bits.c:38:
/usr/src/linux/include/asm/pgalloc.h: In function `get_pgd_slow':
/usr/src/linux/include/asm/pgalloc.h:53: warning: cast does not match function type
/usr/src/linux/include/asm/pgalloc.h: In function `pte_alloc_one':
/usr/src/linux/include/asm/pgalloc.h:101: warning: cast does not match function type
rm -f libkernel.a
ar  rcs libkernel.a ultoa.o addrtoa.o subnettoa.o subnetof.o goodmask.o datatot.o rangetoa.o satoa.o pfkey_v2_parse.o pfkey_v2_build.o pfkey_v2_ext_bits.o
make[4]: Leaving directory `/usr/src/linux/net/ipsec/libfreeswan'
make[3]: Leaving directory `/usr/src/linux/net/ipsec/libfreeswan'
make -C zlib
make[3]: Entering directory `/usr/src/linux/net/ipsec/zlib'
make all_targets
make[4]: Entering directory `/usr/src/linux/net/ipsec/zlib'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686  -g -Wall  -Wpointer-arith  -Wstrict-prototypes -Wbad-function-cast  -DIPCOMP_PREFIX -DASMV  -c -o adler32.o adler32.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686  -g -Wall  -Wpointer-arith  -Wstrict-prototypes -Wbad-function-cast  -DIPCOMP_PREFIX -DASMV  -c -o deflate.o deflate.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686  -g -Wall  -Wpointer-arith  -Wstrict-prototypes -Wbad-function-cast  -DIPCOMP_PREFIX -DASMV  -c -o infblock.o infblock.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686  -g -Wall  -Wpointer-arith  -Wstrict-prototypes -Wbad-function-cast  -DIPCOMP_PREFIX -DASMV  -c -o infcodes.o infcodes.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686  -g -Wall  -Wpointer-arith  -Wstrict-prototypes -Wbad-function-cast  -DIPCOMP_PREFIX -DASMV  -c -o inffast.o inffast.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686  -g -Wall  -Wpointer-arith  -Wstrict-prototypes -Wbad-function-cast  -DIPCOMP_PREFIX -DASMV  -c -o inflate.o inflate.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686  -g -Wall  -Wpointer-arith  -Wstrict-prototypes -Wbad-function-cast  -DIPCOMP_PREFIX -DASMV  -c -o inftrees.o inftrees.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686  -g -Wall  -Wpointer-arith  -Wstrict-prototypes -Wbad-function-cast  -DIPCOMP_PREFIX -DASMV  -c -o infutil.o infutil.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686  -g -Wall  -Wpointer-arith  -Wstrict-prototypes -Wbad-function-cast  -DIPCOMP_PREFIX -DASMV  -c -o trees.o trees.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686  -g -Wall  -Wpointer-arith  -Wstrict-prototypes -Wbad-function-cast  -DIPCOMP_PREFIX -DASMV  -c -o zutil.o zutil.c
gcc -D__ASSEMBLY__ -DNO_UNDERLINE -traditional -c match686.S -o match686.o
rm -f zlib.a
ar  rcs zlib.a adler32.o deflate.o infblock.o infcodes.o inffast.o inflate.o inftrees.o infutil.o trees.o zutil.o match686.o
make[4]: Leaving directory `/usr/src/linux/net/ipsec/zlib'
make[3]: Leaving directory `/usr/src/linux/net/ipsec/zlib'
make all_targets
make[3]: Entering directory `/usr/src/linux/net/ipsec'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686  -Ilibfreeswan -g -Wall  -Wpointer-arith  -Wstrict-prototypes -Wbad-function-cast   -c -o ipsec_init.o ipsec_init.c
In file included from /usr/src/linux/include/linux/highmem.h:5,
                 from /usr/src/linux/include/linux/skbuff.h:27,
                 from /usr/src/linux/include/linux/netdevice.h:146,
                 from ipsec_init.c:29:
/usr/src/linux/include/asm/pgalloc.h: In function `get_pgd_slow':
/usr/src/linux/include/asm/pgalloc.h:53: warning: cast does not match function type
/usr/src/linux/include/asm/pgalloc.h: In function `pte_alloc_one':
/usr/src/linux/include/asm/pgalloc.h:101: warning: cast does not match function type
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686  -Ilibfreeswan -g -Wall  -Wpointer-arith  -Wstrict-prototypes -Wbad-function-cast   -c -o ipsec_xform.o ipsec_xform.c
In file included from /usr/src/linux/include/linux/highmem.h:5,
                 from /usr/src/linux/include/linux/skbuff.h:27,
                 from /usr/src/linux/include/linux/netdevice.h:146,
                 from ipsec_xform.c:28:
/usr/src/linux/include/asm/pgalloc.h: In function `get_pgd_slow':
/usr/src/linux/include/asm/pgalloc.h:53: warning: cast does not match function type
/usr/src/linux/include/asm/pgalloc.h: In function `pte_alloc_one':
/usr/src/linux/include/asm/pgalloc.h:101: warning: cast does not match function type
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686  -Ilibfreeswan -g -Wall  -Wpointer-arith  -Wstrict-prototypes -Wbad-function-cast   -c -o ipsec_netlink.o ipsec_netlink.c
In file included from /usr/src/linux/include/linux/highmem.h:5,
                 from /usr/src/linux/include/linux/skbuff.h:27,
                 from /usr/src/linux/include/linux/netdevice.h:146,
                 from ipsec_netlink.c:28:
/usr/src/linux/include/asm/pgalloc.h: In function `get_pgd_slow':
/usr/src/linux/include/asm/pgalloc.h:53: warning: cast does not match function type
/usr/src/linux/include/asm/pgalloc.h: In function `pte_alloc_one':
/usr/src/linux/include/asm/pgalloc.h:101: warning: cast does not match function type
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686  -Ilibfreeswan -g -Wall  -Wpointer-arith  -Wstrict-prototypes -Wbad-function-cast   -c -o ipsec_radij.o ipsec_radij.c
In file included from /usr/src/linux/include/linux/highmem.h:5,
                 from /usr/src/linux/include/linux/skbuff.h:27,
                 from /usr/src/linux/include/linux/netdevice.h:146,
                 from ipsec_radij.c:28:
/usr/src/linux/include/asm/pgalloc.h: In function `get_pgd_slow':
/usr/src/linux/include/asm/pgalloc.h:53: warning: cast does not match function type
/usr/src/linux/include/asm/pgalloc.h: In function `pte_alloc_one':
/usr/src/linux/include/asm/pgalloc.h:101: warning: cast does not match function type
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686  -Ilibfreeswan -g -Wall  -Wpointer-arith  -Wstrict-prototypes -Wbad-function-cast   -c -o ipsec_tunnel.o ipsec_tunnel.c
In file included from /usr/src/linux/include/linux/highmem.h:5,
                 from /usr/src/linux/include/linux/skbuff.h:27,
                 from /usr/src/linux/include/linux/netdevice.h:146,
                 from ipsec_tunnel.c:30:
/usr/src/linux/include/asm/pgalloc.h: In function `get_pgd_slow':
/usr/src/linux/include/asm/pgalloc.h:53: warning: cast does not match function type
/usr/src/linux/include/asm/pgalloc.h: In function `pte_alloc_one':
/usr/src/linux/include/asm/pgalloc.h:101: warning: cast does not match function type
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686  -Ilibfreeswan -g -Wall  -Wpointer-arith  -Wstrict-prototypes -Wbad-function-cast   -c -o ipsec_rcv.o ipsec_rcv.c
In file included from /usr/src/linux/include/linux/highmem.h:5,
                 from /usr/src/linux/include/linux/skbuff.h:27,
                 from /usr/src/linux/include/linux/netdevice.h:146,
                 from ipsec_rcv.c:31:
/usr/src/linux/include/asm/pgalloc.h: In function `get_pgd_slow':
/usr/src/linux/include/asm/pgalloc.h:53: warning: cast does not match function type
/usr/src/linux/include/asm/pgalloc.h: In function `pte_alloc_one':
/usr/src/linux/include/asm/pgalloc.h:101: warning: cast does not match function type
ipsec_rcv.c: At top level:
ipsec_rcv.c:1554: warning: initialization from incompatible pointer type
ipsec_rcv.c:1565: warning: initialization from incompatible pointer type
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686  -Ilibfreeswan -g -Wall  -Wpointer-arith  -Wstrict-prototypes -Wbad-function-cast   -c -o sysctl_net_ipsec.o sysctl_net_ipsec.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686  -Ilibfreeswan -g -Wall  -Wpointer-arith  -Wstrict-prototypes -Wbad-function-cast   -c -o pfkey_v2.o pfkey_v2.c
pfkey_v2.c:73: warning: `min' redefined
/usr/src/linux/include/linux/kernel.h:116: warning: this is the location of the previous definition
In file included from /usr/src/linux/include/linux/highmem.h:5,
                 from /usr/src/linux/include/linux/skbuff.h:27,
                 from pfkey_v2.c:46:
/usr/src/linux/include/asm/pgalloc.h: In function `get_pgd_slow':
/usr/src/linux/include/asm/pgalloc.h:53: warning: cast does not match function type
/usr/src/linux/include/asm/pgalloc.h: In function `pte_alloc_one':
/usr/src/linux/include/asm/pgalloc.h:101: warning: cast does not match function type
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686  -Ilibfreeswan -g -Wall  -Wpointer-arith  -Wstrict-prototypes -Wbad-function-cast   -c -o pfkey_v2_parser.o pfkey_v2_parser.c
In file included from /usr/src/linux/include/linux/highmem.h:5,
                 from /usr/src/linux/include/linux/skbuff.h:27,
                 from /usr/src/linux/include/linux/netdevice.h:146,
                 from pfkey_v2_parser.c:33:
/usr/src/linux/include/asm/pgalloc.h: In function `get_pgd_slow':
/usr/src/linux/include/asm/pgalloc.h:53: warning: cast does not match function type
/usr/src/linux/include/asm/pgalloc.h: In function `pte_alloc_one':
/usr/src/linux/include/asm/pgalloc.h:101: warning: cast does not match function type
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686  -Ilibfreeswan -g -Wall  -Wpointer-arith  -Wstrict-prototypes -Wbad-function-cast   -DEXPORT_SYMTAB -c radij.c
radij.c:274: macro `min' used with only 2 args
In file included from /usr/src/linux/include/linux/highmem.h:5,
                 from /usr/src/linux/include/linux/skbuff.h:27,
                 from /usr/src/linux/include/linux/netdevice.h:146,
                 from radij.c:67:
/usr/src/linux/include/asm/pgalloc.h: In function `get_pgd_slow':
/usr/src/linux/include/asm/pgalloc.h:53: warning: cast does not match function type
/usr/src/linux/include/asm/pgalloc.h: In function `pte_alloc_one':
/usr/src/linux/include/asm/pgalloc.h:101: warning: cast does not match function type
radij.c: In function `rj_match':
radij.c:274: parse error before `__x'
radij.c:274: `__x' undeclared (first use in this function)
radij.c:274: (Each undeclared identifier is reported only once
radij.c:274: for each function it appears in.)
radij.c:274: `__y' undeclared (first use in this function)
make[3]: *** [radij.o] Error 1
make[3]: Leaving directory `/usr/src/linux/net/ipsec'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux/net/ipsec'
make[1]: *** [_subdir_ipsec] Error 2
make[1]: Leaving directory `/usr/src/linux/net'
make: *** [_dir_net] Error 2
----------------------------Error Messages----------------------------------

----- End forwarded message -----

-- 

Subba Rao
subba9@home.com
http://members.home.net/subba9/

GPG public key ID CCB7344E
Key fingerprint = A8DD 4CBA 1E9B D962 A55B  2B55 BAFE 92C5 CCB7 344E
