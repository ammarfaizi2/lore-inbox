Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267482AbSKQKJJ>; Sun, 17 Nov 2002 05:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267487AbSKQKIb>; Sun, 17 Nov 2002 05:08:31 -0500
Received: from 2-103.ctame701-2.telepar.net.br ([200.181.170.103]:17420 "EHLO
	brinquendo.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S267481AbSKQKHk>; Sun, 17 Nov 2002 05:07:40 -0500
Date: Sun, 17 Nov 2002 08:14:27 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@debian.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] jffs2: fix up header file cleanups
Message-ID: <20021117101427.GE27924@conectiva.com.br>
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

Resending, my ISP relay is b0rked, sorry...

Linus,

	Please pull from:

master.kernel.org:/home/acme/BK/includes-2.5

	In this tree there will be several similar changesets.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.849, 2002-11-17 07:37:45-02:00, acme@conectiva.com.br
  Fix up after header file cleanups: add <linux/mount.h> to
  jffs2 that got it implicitly before.


 super.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/fs/jffs2/super.c b/fs/jffs2/super.c
--- a/fs/jffs2/super.c	Sun Nov 17 07:38:01 2002
+++ b/fs/jffs2/super.c	Sun Nov 17 07:38:01 2002
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/fs.h>
+#include <linux/mount.h>
 #include <linux/jffs2.h>
 #include <linux/pagemap.h>
 #include <linux/mtd/mtd.h>

===================================================================


This BitKeeper patch contains the following changesets:
1.849
## Wrapped with gzip_uu ##


begin 664 bkpatch11665
M'XL(`'ECUST``]U4VXK;,!!]CKYB((\EMD:2+S'-DN[VRA8:4O8#9%F.W;4M
M8\GI+OCCJZ1+%K+I0\L^51H0:$:C,W,.,X<[JX=L)E6KR1P^&^NRF3*=5J[>
MRT"9-L@'[]@:XQUA95H=7M^&=:>:L=!VP8*(>/=&.E7!7@\VFV'`3S?NL=?9
M;/OAT]W7=UM"5BNXJ62WT]^U@]6*.#/L95/8M7158[K`#;*SK7;'CZ=3Z,0H
M97Y'F'`:Q1/&5"23P@)1"M0%92*-!3G4L#['?I8%$1.ZY)Q'$R+#E+P'#%*Q
M!,I"Q!`3H$G&DTQ$"\HR2N%B4GB#L*#D&EZW@!NBX&/]`&,/LG1Z@$K+PA]E
MW6A0C9;=V-L,9%'`VZ;NQH>P-6/G@NK*`_%O?Y2E9>`JZ6!G'-3>VKZI5>V:
M1\AU:08=D%OPA0M*-L]4D,5?+D*HI.0*^@/)EVLO;7B$$]JQUT.@3BU@%%.^
MG%`P)J9EJA2G2:)SS$49I9?;?3G9$Y6)8%,<B9@>Y74>>5#9JZ,D^<XKW:V+
MNNA<,:K[P`R[/X"D-&4\8I[TF/ND1[TQ^D)N[/^5VV]ROL%B^'DT+Y_-"Y[^
D08)?&`*2^=,H.H?X/)54I=6]'=L53V,>E5B27Q)U6P_U!```
`
end

----- End forwarded message -----
