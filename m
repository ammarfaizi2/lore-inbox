Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129944AbQKJX6j>; Fri, 10 Nov 2000 18:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131750AbQKJX6a>; Fri, 10 Nov 2000 18:58:30 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:4101 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129944AbQKJX6T>; Fri, 10 Nov 2000 18:58:19 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: John Jasen <jjasen1@umbc.edu>
Date: Sat, 11 Nov 2000 10:57:52 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14860.35712.974904.824230@notabene.cse.unsw.edu.au>
Cc: Richard Henderson <rth@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: compiling md/lvm on 2.4.0-test9-test11-pre2 for alpha
In-Reply-To: message from John Jasen on Friday November 10
In-Reply-To: <Pine.SGI.4.21L.01.0011101747510.502569-100000@irix2.gl.umbc.edu>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday November 10, jjasen1@umbc.edu wrote:
> 
> Any suggestions?

Yes, send the details to the author of the code, as detemined from
 the comment above it:
    Richard Henderson (rth@redhat.com)

After having written:
> 
> I've tried this on -test9, test10, and test11-pre2, all with similar
> results.
> 
> I've checked the kernel mailing list archives, and didn't see anything
> pertinent.
> 
> I'm getting the following errors: (in this case, attempting to make them
> as a module)
> 
> <snip>
> make -C md modules
> make[2]: Entering directory `/usr/src/linux-2.4.0-test11-pre2/drivers/md'
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.0-test11-pre2/include -Wall
> -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
> -mno-fp-regs -ffixed-8 -mcpu=ev6 -Wa,-mev6 -DMODULE   -DEXPORT_SYMTAB -c 
> xor.c
> xor.c: In function `xor_block_alpha':
> xor.c:1791: inconsistent operand constraints in an `asm'
> xor.c: In function `xor_block_alpha_prefetch':
> xor.c:2213: inconsistent operand constraints in an `asm'
> make[2]: *** [xor.o] Error 1
> make[2]: Leaving directory `/usr/src/linux-2.4.0-test11-pre2/drivers/md'
> make[1]: *** [_modsubdir_md] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.4.0-test11-pre2/drivers'
> make: *** [_mod_drivers] Error 2
> </snip>
> 
> This is running Redhat 6.2, with updates, compiling 2.4.0-test11-pre2,
> with gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release).
> 
> --
> -- John E. Jasen (jjasen1@umbc.edu)
> -- You can have it: right; cheap; now. Pick any two.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
