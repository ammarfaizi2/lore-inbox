Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267488AbSKQKIU>; Sun, 17 Nov 2002 05:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267487AbSKQKIU>; Sun, 17 Nov 2002 05:08:20 -0500
Received: from 2-103.ctame701-2.telepar.net.br ([200.181.170.103]:16396 "EHLO
	brinquendo.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S267480AbSKQKH1>; Sun, 17 Nov 2002 05:07:27 -0500
Date: Sun, 17 Nov 2002 08:14:14 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@debian.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] intermezzo: fix up header file cleanups
Message-ID: <20021117101413.GD27924@conectiva.com.br>
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


ChangeSet@1.848, 2002-11-17 07:33:35-02:00, acme@conectiva.com.br
  Fix up after header file cleanups: add <linux/mount.h> to
  intermezzo that got it implicitly before.


 intermezzo_fs.h |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/include/linux/intermezzo_fs.h b/include/linux/intermezzo_fs.h
--- a/include/linux/intermezzo_fs.h	Sun Nov 17 07:34:24 2002
+++ b/include/linux/intermezzo_fs.h	Sun Nov 17 07:34:24 2002
@@ -54,6 +54,7 @@
 #ifdef __KERNEL__
 # include <linux/smp.h>
 # include <linux/fsfilter.h>
+# include <linux/mount.h>
 # include <linux/slab.h>
 # include <linux/vmalloc.h>
 # include <linux/smp_lock.h>

===================================================================


This BitKeeper patch contains the following changesets:
1.848
## Wrapped with gzip_uu ##


begin 664 bkpatch9178
M'XL(`*!BUST``]U476O;,!1]CG[%A3Z.V/=*_HJ92];NDPX6,OHTQE!EI3:S
M+6/+65O\XZ=D60)9*-W87F8+!+Z^1^?H'.X97/>Z2R=2U9J=P5O3VW2B3*.5
M+=?24Z;V;CI76!KC"GYA:NU?7/EEHZHAU_V4>R%SY86TJH"U[OIT0I[8?['W
MK4XGRU=OKM^_6#*697!9R.96?]06LHQ9TZUEE?=S:8O*-)[M9-/7VFX/'O>_
MCAR1NS>D6&`8C11A$(^*<B(9D,Z1!TD4L(V&^3'W(Q0BBG$F4(0CT8P2]A+(
M2X($D/M$/L6`<2I$*L(I\A013H+",X(IL@OXNP(NF8+7Y1T,+<B5U1T46N9N
M6Y65!E5IV0QMGX+,<WA>E<UPY]=F:*Q7G#LBKK=L7%.M'QX,V$):N#462K?J
MMBI5::M[N-$KTVF/70$1=^H7!S_8]#<?QE`B.X=VX_3I"]C%Q/]!]D#ORZKW
MBOVE<!2"@A&3),`QUI&.PB3*11R'B0I.&_`$Y)W30O`1(Q'/MNE[M&V3R'\K
MAJW+SLQK!^^U_>#I?/CT,T&?GR()^0QYB"(>,7`G;,,;_Q)=_I]'=^OF!YAV
MW[;+)7'QN+%_$.UW803DQM@.]YCT8>:I0JNO_5!G%+DQDDC-O@,D.`<A4P4`
!````
`
end

----- End forwarded message -----
