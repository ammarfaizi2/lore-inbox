Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262500AbSKRM5J>; Mon, 18 Nov 2002 07:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262480AbSKRMzl>; Mon, 18 Nov 2002 07:55:41 -0500
Received: from 2-023.ctame701-2.telepar.net.br ([200.181.170.23]:41476 "EHLO
	brinquendo.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S262481AbSKRMzU>; Mon, 18 Nov 2002 07:55:20 -0500
Date: Mon, 18 Nov 2002 11:02:18 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] smbfs: fixup header cleanups: forward declare struct sock, add include/uio.h
Message-ID: <20021118130218.GH2093@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
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

	Now there are six outstanding changesets.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.895, 2002-11-18 10:43:55-02:00, acme@conectiva.com.br
  o smbfs: fixup header cleanups: forward declare struct sock, add include/uio.h


 proto.h   |    1 +
 request.h |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)


diff -Nru a/fs/smbfs/proto.h b/fs/smbfs/proto.h
--- a/fs/smbfs/proto.h	Mon Nov 18 10:57:18 2002
+++ b/fs/smbfs/proto.h	Mon Nov 18 10:57:18 2002
@@ -3,6 +3,7 @@
  */
 
 struct smb_request;
+struct sock;
 
 /* proc.c */
 extern int smb_setcodepage(struct smb_sb_info *server, struct smb_nls_codepage *cp);
diff -Nru a/fs/smbfs/request.h b/fs/smbfs/request.h
--- a/fs/smbfs/request.h	Mon Nov 18 10:57:18 2002
+++ b/fs/smbfs/request.h	Mon Nov 18 10:57:18 2002
@@ -1,6 +1,7 @@
+#include <linux/list.h>
 #include <linux/types.h>
+#include <linux/uio.h>
 #include <linux/wait.h>
-#include <linux/list.h>
 
 struct smb_request {
 	struct list_head rq_queue;	/* recvq or xmitq for the server */

===================================================================


This BitKeeper patch contains the following changesets:
1.895
## Wrapped with gzip_uu ##


begin 664 bkpatch15365
M'XL(`*[CV#T``]55T4[;,!1]KK_B2CQN37R=.'&S%3%@VA"3AICX`-=QEX@T
M[FP'-BD?/R>PCD(W!.*%)/*#3W3NN?><.'MPX;0M)E*M--F#S\;Y8J),JY6O
MKV2DS"I:V`"<&Q.`N#(K'1^>QG6KFJ[4;LHB3@)\)KVJX$I;5TPP2C8[_M=:
M%Y/SCY\NOGPX)V0^AZ-*MM_U-^UA/B?>V"O9E.Y`^JHQ;>2M;-U*^[%POWFU
M9Y2R<'/,$\JS'C.:YKW"$E&FJ$O*4I&E9.CAX+[V>RR(*)"EC+,>4YXS<@P8
MB1D'RF+$&`4@+=*DX'Q*64$I["2%-PRFE!S"RS9P1!08<*O%TA6PK']V:ZBT
M++4%U6C9=NMAV]AK:4LHM6JDU>"\[90'9]3E6Y!E";?6Q%UMHHJ<`J9,4'+V
M=_!D^L2+$"HIV8?U8.GN3I<N'F7':VM\J+MI>%A0],AR/@OKC"9:<IYEBS))
MU>[A[B:[-2[AV"=($Q;T='8AVP.OG7=>^CJ(VI)B]8\N8'_$Y,@IY1RSGB+R
MO%\@385(1<E5PGA(P"-BMNGNR`F&"CYF^[[P(>(O/C3R2-M;9#,V8TE(5]:S
MF6`W:<\?9!W_GW5\-5F_2<97F-KK\0G9/7O@RC/R?\(!R9WJ[[;MWD1C,/QE
M4_E,NKRG2<:ST6_V5+_#V8:OP^_QR_N7W9O1/,=P&@S?NRT'[YNZ[7[&33VP
E[9,3W`&.DO;)<1*PS>]/55I=NFXU%SQ9,D8%^0VRXQ^^<`<`````
`
end
