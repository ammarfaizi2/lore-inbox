Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261929AbREOQdZ>; Tue, 15 May 2001 12:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261931AbREOQdO>; Tue, 15 May 2001 12:33:14 -0400
Received: from relay.freedom.net ([207.107.115.209]:42763 "HELO
	relay.freedom.net") by vger.kernel.org with SMTP id <S261929AbREOQc7>;
	Tue, 15 May 2001 12:32:59 -0400
X-Freedom-Envelope-Sig: linux-kernel@vger.kernel.org AQHREhGy8ga5tIZx6JDip+YRC83Cxb4Pdsg2eDoEltW4x9Khuj9JrsrJ
Date: Tue, 15 May 2001 10:32:21 -0600
Old-From: cacook@freedom.net
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: write to dvd ram
Content-Type: text/plain; charset = "us-ascii" 
Content-Transfer-Encoding: 7bit
From: cacook@freedom.net
Message-Id: <20010515163306Z261929-1104+1244@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No one has a minute to help me with this (compile?) problem?  Linus ?





-------- Original Message --------
Subject: Re: write to dvd ram
Date: Fri, 11 May 2001 07:57:56 -0600
From: @.
To: linux-kernel@vger.kernel.org
In-Reply-To: <91FD33983070D21188A10008C728176C09421202@LDMS6003> <20010508145400Z132655-406+505@vger.kernel.org> <20010508100129.19740@dragon.linux.ix.netcom.com> <20010508195030.J505@suse.de>

Only udf I could find that was compatible with kernel 2.4.2 was the udf-0.9.3 tarball.  It does have a 2.4 directory.  I am restricted in which kernel I can use, as I must have a patch for fibrechannel.  My compile craps out with the listing below; I can't make any sense out of it.

I have used Linux for several years as my firewall, and in December 2k I decided to make it my workstation.  Since that time I have worked on configuring it at least a few hours each workday afternoon. (RedHat Fisher, then Wolverine)  Now I am not a dummy, but I'm not a coder either, and I have just not been able to get this system running, and am now up against two problems I cannot solve: this DVDRAM | UDF issue corrupting my disks (Why is udf-0.9.1 in Wolverine, wrecking my DVDRAM data?  And how can I install udf as a module when it's already in kernel?), and Wine setup.  No one has
answered my questions on the kernel IRCs nor Wine mailinglist -- they're fairly cross with newbies who have actually  read/followed the docs.  Often when I ask a question I get taken down like an elk by a lion.  This isn't supposed to be natural selection people.  Supposed to =bring= ppl to Linux;  don't they know the damage they do to Linux by blowing off their steam?  Most newbies won't slap them back down;  they'll just go away quietly & then put down Linux to others.

I haven't even yet gotten to learning/configuring Sane, LDAP, Postfix, IPTables, VPN, nor intrusion detection, much less database & production functions.

I just don't know how I'm going to make this work =practically=  as much as I want it;  RedHat just seems to require unlimited volumes of time.  After months I am precisely nowhere, and stuck with Windows, and discouraged; looks like I have at least another year of =configuring= at this rate.
--
C.

The best way out is always through.
      - Robert Frost  A Servant to Servants, 1914


Linux UDF Configuration Script

The default responses for each question are correct for most users.

Linux source directory [/usr/src/linux]: /usr/src/linux-2.4.2-temp
Alternate target install directory []: /lib/modules/2.4.2-0.1.49
C compiler name [gcc]:
Linker name [ld -m elf_i386]:
UDF Write Support (y/n) [y]:
Compiler flags for debugging [-g]:

The UDF driver needs to be compiled to match the kernel it will be used with, or it may fail to load.  If you are not sure what to do, please consult the UDF manual.

How would you like to set kernel-specific options?
    1 - Read from the currently running kernel
    2 - Read from the Linux source tree
Enter option (1-2) [1]: 2

Kernel configuration options:
    Symmetric multiprocessing support is disabled.
    Max physical memory in MB is
    Advanced Power Management (APM) support is enabled.
    Networking support is enabled.
    Module version checking is enabled.

The kernel source tree is version 2.4.2-0.1.49.
The current kernel build date is Wed Apr 18 20:53:37 MDT 2001.

Your module utilities are version 2.4.2.
make[1]: Entering directory `/usr/send-rec/download/udf-0.9.3/module'
gcc -MD -O2 -Wall -Wstrict-prototypes -pipe -DMODVERSIONS -include /usr/src/linux-2.4.2-temp/include/linux/modversions.h -g -D__KERNEL__ -DMODULE -I../include -I. -I/usr/src/linux-2.4.2-temp/include  -DUDFFS_RW=1 -DCONFIG_UDF_FS_EXT -c -o balloc.o ../linux-2.4/balloc.c
../linux-2.4/balloc.c:115:17: warning: pasting "(" and ""block_group (%d) > nr_groups (%d)\n"" does not give a valid preprocessing token
../linux-2.4/balloc.c:160:17: warning: pasting "(" and ""nonexistent device"" does not give a valid preprocessing token
../linux-2.4/balloc.c:168:17: warning: pasting "(" and ""%d < %d || %d + %d > %d\n"" does not give a valid preprocessing token
../linux-2.4/balloc.c:198:25: warning: pasting "(" and ""bit %ld already set\n"" does not give a valid preprocessing token
../linux-2.4/balloc.c:199:25: warning: pasting "(" and ""byte=%2x\n"" does not give a valid preprocessing token
../linux-2.4/balloc.c:203:54: macro "DQUOT_FREE_BLOCK" passed 3 arguments, but takes just 2
../linux-2.4/balloc.c:239:17: warning: pasting "(" and ""nonexistent device\n"" does not give a valid preprocessing token
../linux-2.4/balloc.c:268:59: macro "DQUOT_PREALLOC_BLOCK" passed 3 arguments, but takes just 2
../linux-2.4/balloc.c:272:25: warning: pasting "(" and ""bit already cleared for
 block %d\n"" does not give a valid preprocessing token
../linux-2.4/balloc.c:273:54: macro "DQUOT_FREE_BLOCK" passed 3 arguments, but takes just 2
../linux-2.4/balloc.c:310:17: warning: pasting "(" and ""nonexistent device\n""
does not give a valid preprocessing token
../linux-2.4/balloc.c:407:43: macro "DQUOT_ALLOC_BLOCK" passed 3 arguments, but takes just 2
../linux-2.4/balloc.c:420:17: warning: pasting "(" and ""bit already cleared for
 block %d\n"" does not give a valid preprocessing token
../linux-2.4/balloc.c:454:9: warning: pasting "(" and ""ino=%ld, bloc=%d, offset
=%d, count=%d\n"" does not give a valid preprocessing token
../linux-2.4/balloc.c:460:17: warning: pasting "(" and ""nonexistent device"" do
es not give a valid preprocessing token
../linux-2.4/balloc.c:471:17: warning: pasting "(" and ""%d < %d || %d + %d > %d
\n"" does not give a valid preprocessing token
../linux-2.4/balloc.c:479:42: macro "DQUOT_FREE_BLOCK" passed 3 arguments, but takes just 2
../linux-2.4/balloc.c: In function `udf_bitmap_free_blocks':
../linux-2.4/balloc.c:203: `DQUOT_FREE_BLOCK' undeclared (first use in this func
tion)
../linux-2.4/balloc.c:203: (Each undeclared identifier is reported only once
../linux-2.4/balloc.c:203: for each function it appears in.)
../linux-2.4/balloc.c: In function `udf_bitmap_prealloc_blocks':
../linux-2.4/balloc.c:268: `DQUOT_PREALLOC_BLOCK' undeclared (first use in this function)
../linux-2.4/balloc.c:273: `DQUOT_FREE_BLOCK' undeclared (first use in this func
tion)
../linux-2.4/balloc.c: In function `udf_bitmap_new_block':
../linux-2.4/balloc.c:407: `DQUOT_ALLOC_BLOCK' undeclared (first use in this fun
ction)
../linux-2.4/balloc.c: In function `udf_table_free_blocks':
../linux-2.4/balloc.c:479: `DQUOT_FREE_BLOCK' undeclared (first use in this func
tion)
../linux-2.4/balloc.c:705:9: warning: pasting "(" and ""ino=%ld, partition=%d, f
irst_block=%d, block_count=%d\n"" does not give a valid preprocessing token
../linux-2.4/balloc.c:711:17: warning: pasting "(" and ""nonexistent device\n""
does not give a valid preprocessing token
../linux-2.4/balloc.c:739:17: warning: pasting "(" and ""eloc=%d, elen=%d, first
_block=%d\n"" does not give a valid preprocessing token
../linux-2.4/balloc.c:772:9: warning: pasting "(" and ""alloc_count=%d\n"" does
not give a valid preprocessing token
../linux-2.4/balloc.c:787:9: warning: pasting "(" and ""ino=%ld, partition=%d, g
oal=%d\n"" does not give a valid preprocessing token
../linux-2.4/balloc.c:794:17: warning: pasting "(" and ""nonexistent device\n""
does not give a valid preprocessing token
../linux-2.4/balloc.c:875:17: warning: pasting "(" and ""cannot get block %d\n""
 does not give a valid preprocessing token
make[1]: *** [balloc.o] Error 1
make[1]: Leaving directory `/usr/send-rec/download/udf-0.9.3/module'
make: *** [udf.o] Error 2


Jens Axboe wrote:

> On Tue, May 08 2001, Ben Fennema wrote:
> > > The log is:
> > > Apr 15 20:58:27 hydra kernel: UDF-fs INFO UDF 0.9.1 (2000/02/29) Mounting
> > > volume 'UDF Volume', timestamp 2001/03/02 11:55 (1e98)
> >
> > At the very least, run 0.9.3 from sourceforce (or the cvs version) and
> > see if it works any better.
>
> I was just about to say the same thing, 0.9.3 works well for me. In fact
> so well, that I made a patch to bring 2.4.5-pre1 UDF up to date with
> current CVS earlier this afternoon (hint hint, Ben :-).
>
> *.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.5-pre1/
>
> udf-0.9.3-2.4.5p1-1.bz2
>
> --
> Jens Axboe
