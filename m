Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267476AbSKQJjv>; Sun, 17 Nov 2002 04:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267478AbSKQJjv>; Sun, 17 Nov 2002 04:39:51 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:30735 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S267476AbSKQJjr>; Sun, 17 Nov 2002 04:39:47 -0500
Date: Sun, 17 Nov 2002 07:46:37 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@debian.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] hugetlbfs: fix up header file cleanups
Message-ID: <20021117094637.GC27699@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@debian.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

	Please pull from:

master.kernel.org:/home/acme/BK/includes-2.5

	In this tree there will be several similar changesets.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.847, 2002-11-17 07:30:35-02:00, acme@conectiva.com.br
  Fix up after header file cleanups: add <linux/mount.h> to
  hugetlbfs that got it implicitly before.


 inode.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
--- a/fs/hugetlbfs/inode.c	Sun Nov 17 07:34:08 2002
+++ b/fs/hugetlbfs/inode.c	Sun Nov 17 07:34:08 2002
@@ -11,6 +11,7 @@
 #include <asm/current.h>
 #include <linux/sched.h>		/* remove ASAP */
 #include <linux/fs.h>
+#include <linux/mount.h>
 #include <linux/file.h>
 #include <linux/writeback.h>
 #include <linux/pagemap.h>

===================================================================


This BitKeeper patch contains the following changesets:
1.847
## Wrapped with gzip_uu ##


begin 664 bkpatch9137
M'XL(`)!BUST``]V476O;,!2&KZ-?<2"7(_8YEBU_L)2LW2<=-&3T:NQ"D>78
MU+:"+6<M^,=/2=<4LC"VL=W,%MCX2*_?H_=!4[CM=9=-I&HTF\)[T]MLHDRK
ME:UVTE.F\=:=*ZR,<06_-(WV+Z_]JE7UD.M^%G@1<^6EM*J$G>[Z;$(>/WZQ
M#UN=359OWMU^?+5B;#Z'JU*V&_U)6YC/F37=3M9YOY"VK$WKV4ZV?:/MX<?C
M<>H8(`;NCBCF&(F1!(;QJ"@GDB'I'(,P$2';][`X]7ZB0D0QID$2X4B!(&2O
M@;PDC`$#G\@G]Q)G'#,>S3#($.&L*+P@F"&[A+_;P!53\+:ZAV$+LK"Z@U++
MW#V*JM:@:BW;8=MG(/,<7M95.]S[C1E:ZY47SHA;6PX;;>MUT8,MI86-L5"Y
MT6SK2E6V?H"U+DRG/78-1"DE;/D<!YO]YL482F07(.^VS2*O-MKL>_[\M"-?
MQJ+WCX8<,";7GGK,`#E1PL,P&#$5B4M"J)PC7ZLU*15&ZORF_T3P$*I3P)&G
M(A`'T,[-WC/W#_PR64KI&*BZ1E:UUVK[2[*$"6+H(!QYS$5\0)'_`"+^WR`^
M!G8#L^[K83BPEF>S^P-`/Q`'8M/OA]6IU>=S2Y5:W?5#,\_3*!5%)-@WGDZN
%!A<%````
`
end
