Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263326AbSL1Ox4>; Sat, 28 Dec 2002 09:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264010AbSL1Ox4>; Sat, 28 Dec 2002 09:53:56 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:11794 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S263326AbSL1Oxx>; Sat, 28 Dec 2002 09:53:53 -0500
Date: Sat, 28 Dec 2002 13:01:59 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: "David S. Miller" <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] sparc32: add missing __{start,stop}___param to vmlinux.lds.S
Message-ID: <20021228150158.GA27349@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Pete Zaitcev <zaitcev@redhat.com>,
	"David S. Miller" <davem@redhat.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Please consider pulling from:

bk://kernel.bkbits.net/acme/sparc-2.5

- Arnaldo


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.963, 2002-12-28 12:49:54-02:00, acme@conectiva.com.br
  o sparc: add missing __{start,stop}___param to vmlinux.lds.S
  
  Rusty missed this one.


 vmlinux.lds.S |    3 +++
 1 files changed, 3 insertions(+)


diff -Nru a/arch/sparc/vmlinux.lds.S b/arch/sparc/vmlinux.lds.S
--- a/arch/sparc/vmlinux.lds.S	Sat Dec 28 12:50:20 2002
+++ b/arch/sparc/vmlinux.lds.S	Sat Dec 28 12:50:20 2002
@@ -48,6 +48,9 @@
   __setup_start = .;
   .init.setup : { *(.init.setup) }
   __setup_end = .;
+  __start___param = .;
+  __param : { *(__param) }
+  __stop___param = .;
   __initcall_start = .;
   .initcall.init : {
 	*(.initcall1.init) 

===================================================================


This BitKeeper patch contains the following changesets:
1.963
## Wrapped with gzip_uu ##


begin 664 bkpatch28505
M'XL(`"RZ#3X``]546VO;,!A]CG[%!WW9+;)NMF4/CZS=V$8'"PE]#HJLU::U
M%2PE6ZG[WZ<X)6O+TK++RVQAD#Z=3T?G''P$9\YT^4CIQJ`C^&B=ST?:MD;[
M>J.PM@U>=J$PLS84HLHV)CH^C=Q*=7K,<(Q";:J\KF!C.I>/*.;[%7^U,OEH
M]O[#V>>W,X2*`DXJU9Z;N?%0%,C;;J,N2S=1OKJT+?:=:EUC_'!JO]_:,T)8
M>&.:<A(G/4V(2'M-2TJ5H*8D3,A$H&[M_-5D^]6V6PW$U?I!%\J8)))D/.EC
MDL8I>@<49PD'PB+*(B:!LEQD>2S&A.6$P%:5R4,UX"6%,4''\&\O<((T6!B$
MS4&5)32U<W5[#HO%M?.J\Z^<MZN;Q6(1MJ@FG`Z;YK)NU]]QX(#G`1[&;"O#
M`#4E^*IV$-AC=`HQD8*CZ4\+T/@W'X2((NC-$]<.]*M=/*([].YH(`CC?4)2
MGO6IE'%0PV3)\FNBT^S7>A]HB>=[3ZD0DF:]D)+1(6>'$$_'[F_HHU)M3#-I
MU][AMFXO%&Z#^X^SIY11$H>FO>"4B2&1E-X/I,QI]G@@^7\8R)U;7V#<?1M&
M"-CTH'%_$-9/,0&.(+`=R.YI%H!?#\N[:0[7\.+9[>PYW-PB[.H^8/]3TY71
4%V[=%,(L65KR)?H!BO.-J$,%````
`
end
