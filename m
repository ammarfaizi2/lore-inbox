Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263527AbTDXCxu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 22:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263549AbTDXCxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 22:53:50 -0400
Received: from siaab1ab.compuserve.com ([149.174.40.2]:28352 "EHLO
	siaab1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S263527AbTDXCxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 22:53:46 -0400
Date: Wed, 23 Apr 2003 23:02:02 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [ANNOUNCE] desc.c -- dump the i386 descriptor tables
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304232305_MC3-1-35C1-C1D1@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Sample output:


 desc.c -- dump linux descriptor tables, version 0.50

 GDT at c0306280, 32 entries:

#00: base=00000000 limit=0000 flags=0000 <G=0 P=0 S=0 DPL=0 Empty>
#01: base=00000000 limit=0000 flags=0000 <G=0 P=0 S=0 DPL=0 Empty>
#02: base=00000000 limit=0000 flags=0000 <G=0 P=0 S=0 DPL=0 Empty>
#03: base=00000000 limit=0000 flags=0000 <G=0 P=0 S=0 DPL=0 Empty>
#04: base=00000000 limit=0000 flags=0000 <G=0 P=0 S=0 DPL=0 Empty>
#05: base=00000000 limit=0000 flags=0000 <G=0 P=0 S=0 DPL=0 Empty>
#06: base=00000000 limit=0000 flags=0000 <G=0 P=0 S=0 DPL=0 Empty>
#07: base=00000000 limit=0000 flags=0000 <G=0 P=0 S=0 DPL=0 Empty>
#08: base=00000000 limit=0000 flags=0000 <G=0 P=0 S=0 DPL=0 Empty>
#09: base=00000000 limit=0000 flags=0000 <G=0 P=0 S=0 DPL=0 Empty>
#10: base=00000000 limit=0000 flags=0000 <G=0 P=0 S=0 DPL=0 Empty>
#11: base=00000000 limit=0000 flags=0000 <G=0 P=0 S=0 DPL=0 Empty>
#12: base=00000000 limit=ffff flags=cf9b <G=1 P=1 S=1 DPL=0 Code>
#13: base=00000000 limit=ffff flags=cf93 <G=1 P=1 S=1 DPL=0 Data>
#14: base=00000000 limit=ffff flags=cffb <G=1 P=1 S=1 DPL=3 Code>
#15: base=00000000 limit=ffff flags=cff3 <G=1 P=1 S=1 DPL=3 Data>
#16: base=c0353800 limit=00eb flags=008b <G=0 P=1 S=0 DPL=0 Busy TSS>
#17: base=c0307c70 limit=0027 flags=0082 <G=0 P=1 S=0 DPL=0 LDT>
#18: base=00000000 limit=0000 flags=c09a <G=1 P=1 S=1 DPL=0 Code>
#19: base=00000000 limit=0000 flags=809a <G=1 P=1 S=1 DPL=0 Code>
#20: base=00000000 limit=0000 flags=8092 <G=1 P=1 S=1 DPL=0 Data>
#21: base=00000000 limit=0000 flags=8092 <G=1 P=1 S=1 DPL=0 Data>
#22: base=00000000 limit=0000 flags=8092 <G=1 P=1 S=1 DPL=0 Data>
#23: base=00000000 limit=0000 flags=409a <G=0 P=1 S=1 DPL=0 Code>
#24: base=00000000 limit=0000 flags=009a <G=0 P=1 S=1 DPL=0 Code>
#25: base=00000000 limit=0000 flags=4092 <G=0 P=1 S=1 DPL=0 Data>
#26: base=00000000 limit=0000 flags=0000 <G=0 P=0 S=0 DPL=0 Empty>
#27: base=00000000 limit=0000 flags=0000 <G=0 P=0 S=0 DPL=0 Empty>
#28: base=00000000 limit=0000 flags=0000 <G=0 P=0 S=0 DPL=0 Empty>
#29: base=00000000 limit=0000 flags=0000 <G=0 P=0 S=0 DPL=0 Empty>
#30: base=00000000 limit=0000 flags=0000 <G=0 P=0 S=0 DPL=0 Empty>
#31: base=c0355600 limit=00eb flags=0089 <G=0 P=1 S=0 DPL=0 Available TSS>

 IDT at c0353000, 256 entries:

#000[0x00]: flags=8f<P,DPL0,trp> sel=60<GDT#12,RPL0> off=c0109840
#001[0x01]: flags=8e<P,DPL0,int> sel=60<GDT#12,RPL0> off=c01098d0
#002[0x02]: flags=8e<P,DPL0,int> sel=60<GDT#12,RPL0> off=c01098fc
#003[0x03]: flags=ef<P,DPL3,trp> sel=60<GDT#12,RPL0> off=c0109978
#004[0x04]: flags=ef<P,DPL3,trp> sel=60<GDT#12,RPL0> off=c0109984
#005[0x05]: flags=ef<P,DPL3,trp> sel=60<GDT#12,RPL0> off=c0109990
#006[0x06]: flags=8f<P,DPL0,trp> sel=60<GDT#12,RPL0> off=c010999c
#007[0x07]: flags=8f<P,DPL0,trp> sel=60<GDT#12,RPL0> off=c0109898
#008[0x08]: flags=85<P,DPL0,tsk> sel=f8<GDT#31,RPL0> off=00000000
#009[0x09]: flags=8f<P,DPL0,trp> sel=60<GDT#12,RPL0> off=c01099a8
#010[0x0a]: flags=8f<P,DPL0,trp> sel=60<GDT#12,RPL0> off=c01099b4
#011[0x0b]: flags=8f<P,DPL0,trp> sel=60<GDT#12,RPL0> off=c01099c0
#012[0x0c]: flags=8f<P,DPL0,trp> sel=60<GDT#12,RPL0> off=c01099cc
#013[0x0d]: flags=8f<P,DPL0,trp> sel=60<GDT#12,RPL0> off=c01099d8
#014[0x0e]: flags=8e<P,DPL0,int> sel=60<GDT#12,RPL0> off=c01099f0
#015[0x0f]: flags=8f<P,DPL0,trp> sel=60<GDT#12,RPL0> off=c0109a08
#016[0x10]: flags=8f<P,DPL0,trp> sel=60<GDT#12,RPL0> off=c0109880
#017[0x11]: flags=8f<P,DPL0,trp> sel=60<GDT#12,RPL0> off=c01099e4
#018[0x12]: flags=8f<P,DPL0,trp> sel=60<GDT#12,RPL0> off=c01099fc
#019[0x13]: flags=8f<P,DPL0,trp> sel=60<GDT#12,RPL0> off=c010988c
...
#032[0x20]: flags=8e<P,DPL0,int> sel=60<GDT#12,RPL0> off=c0108da0
#033[0x21]: flags=8e<P,DPL0,int> sel=60<GDT#12,RPL0> off=c0108da8
#034[0x22]: flags=8e<P,DPL0,int> sel=60<GDT#12,RPL0> off=c0108db0
#035[0x23]: flags=8e<P,DPL0,int> sel=60<GDT#12,RPL0> off=c0108db8
#036[0x24]: flags=8e<P,DPL0,int> sel=60<GDT#12,RPL0> off=c0108dc0
#037[0x25]: flags=8e<P,DPL0,int> sel=60<GDT#12,RPL0> off=c0108dc8
#038[0x26]: flags=8e<P,DPL0,int> sel=60<GDT#12,RPL0> off=c0108dd0
#039[0x27]: flags=8e<P,DPL0,int> sel=60<GDT#12,RPL0> off=c0108dd8
#040[0x28]: flags=8e<P,DPL0,int> sel=60<GDT#12,RPL0> off=c0108de0
#041[0x29]: flags=8e<P,DPL0,int> sel=60<GDT#12,RPL0> off=c0108de8
#042[0x2a]: flags=8e<P,DPL0,int> sel=60<GDT#12,RPL0> off=c0108df0
#043[0x2b]: flags=8e<P,DPL0,int> sel=60<GDT#12,RPL0> off=c0108df8
#044[0x2c]: flags=8e<P,DPL0,int> sel=60<GDT#12,RPL0> off=c0108e00
#045[0x2d]: flags=8e<P,DPL0,int> sel=60<GDT#12,RPL0> off=c0108e08
#046[0x2e]: flags=8e<P,DPL0,int> sel=60<GDT#12,RPL0> off=c0108e10
#047[0x2f]: flags=8e<P,DPL0,int> sel=60<GDT#12,RPL0> off=c0108e18
#048[0x30]: flags=8e<P,DPL0,int> sel=60<GDT#12,RPL0> off=c0108e40
#049[0x31]: flags=8e<P,DPL0,int> sel=60<GDT#12,RPL0> off=c0108da0
#050[0x32]: flags=8e<P,DPL0,int> sel=60<GDT#12,RPL0> off=c0108e50
...

===========================================================================
=====

#define PROG_MSG " desc.c -- dump linux descriptor tables"
#define VERSION  "0.50"
/*
	Author: Chuck Ebbert <76306.1226ompuserve.com>
*/
#include <stdio.h>
#include <fcntl.h>
#include <sys/types.h>

typedef struct {
	unsigned short limit;
	unsigned int base;
} __attribute__ ((packed)) dtr_t;

typedef struct {
	unsigned short off1;
	unsigned short sel;
	unsigned char none,flags;
	unsigned short off2;
} __attribute__ ((packed)) idt_entry_t;

typedef struct {
	unsigned a,b;
} __attribute__ ((packed)) gdt_entry_t;

/* read/write from kmem */
#define BUILD_IO_FN(fn_name, fn_fn) \
	static int fn_name(int fd, int offset, void *buf, int size) { \
	if (lseek(fd, offset, 0) != offset) return 0; \
		if (fn_fn(fd, buf, size) != size) return 0; \
	return size; \
	}
BUILD_IO_FN(rkm, read)
BUILD_IO_FN(wkm, write)

void perr(char *err) { /* exit with err msg */
	perror(err), exit(1);
}
/* read/write wrapper with err handling */
#define xkm(f, p1, p2, p3, p4, msg) { \
	int _p4 = (p4); if ((f)((p1), (p2), (p3), _p4) != _p4) perr(msg); }
#define TEST_BIT(v,b) ( !!(v & (1 << b)) )

main() {
	unsigned sys_call_off, sct, fn, sel, flags, a, b, base, num;
	dtr_t idtr, gdtr;
	idt_entry_t idte;
	gdt_entry_t gdte;
	int kmem, i, t, found = 0;
	unsigned char *p;

	printf(PROG_MSG ", version " VERSION "\n\n");

	kmem = open("/dev/kmem", O_RDONLY);
	if (kmem < 0) perr("open kmem");

	asm("sgdt %0" : "=m" (gdtr));
	base = gdtr.base, num = (gdtr.limit + 1) >> 3;
	printf(" GDT at %08x, %d entries:\n\n", base, num);
	for (i = 0; i < num; i++) {
		xkm(rkm, kmem, base + 8*i, &gdte, sizeof(gdte), "rkm gdte");
		a = gdte.a, b = gdte.b, t = (b & 0x1f00) >> 8;
		printf("#%02d: base=%08x limit=%04x"
		       " flags=%04x <G=%d P=%d S=%d DPL=%d %s>\n", i,
		       (b & 0xff000000) | ((b & 0xff) << 16) | (a >> 16),
		       a & 0xffff, (b & 0x00ffff00) >> 8, TEST_BIT(b,23),
		       TEST_BIT(b,15), TEST_BIT(b,12), (b & 0x6000) >> 13,
		       (a == 0) & (b == 0) ? "Empty" :
					t == 0x0b ? "Busy TSS" :
		       			t == 0x09 ? "Available TSS" :
					t == 0x02 ? "LDT" :
					t == 0x0c ? "Call gate" :
					(t & 0x1c) == 0x18 ? "Code" :
					(t & 0x1c) == 0x1c ? "Conforming code" :
					(t & 0x1c) == 0x10 ? "Data" :
					(t & 0x1c) == 0x14 ? "Exp-down data" :
					"Unknown");
	}
	asm("sidt %0" : "=m" (idtr));
	base = idtr.base, num = (idtr.limit + 1) >> 3;
	printf("\n IDT at %08x, %d entries:\n\n", base, num);
	for (i = 0; i < num; i++) {
	xkm(rkm, kmem, base + 8*i, &idte, sizeof(idte), "rkm idte");
		sel = idte.sel, flags = idte.flags;
		printf("#%03d[0x%02x]: flags=%02x<%s,DPL%d,%s>"
		       " sel=%02x<%s#%02d,RPL%d> off=%08x\n", i, i,
		       flags, flags & 0x80 ? "P" : "NP", (flags & 0x60) >> 5,
		       (flags & 0x1f) == 0xe ? "int" :
		       		(flags & 0x1f) == 0xf ? "trp" : "tsk",
		       sel, sel & 4 ? "LDT" : "GDT", sel >> 3, sel & 3,
		       (unsigned)((idte.off2 << 16) | idte.off1));
	}
	close(kmem);
}


------
 Chuck
