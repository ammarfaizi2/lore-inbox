Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265767AbSKLAxI>; Mon, 11 Nov 2002 19:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265798AbSKLAxI>; Mon, 11 Nov 2002 19:53:08 -0500
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:63692 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id <S265767AbSKLAxG>;
	Mon, 11 Nov 2002 19:53:06 -0500
Date: Tue, 12 Nov 2002 01:59:23 +0100
To: linux-kernel@vger.kernel.org
Cc: rusty@rustcorp.com.au
Subject: [PATCH] 2.5bk - make net/ipv6/af_inet6.c compile again.
Message-ID: <20021112005923.GA19877@gagarin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Anders Gustafsson <andersg@0x63.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty must have slipped, here is a patch that fixes compilation of
net/ipv6/af_inet6.c

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/
===================================================================


ChangeSet@1.857, 2002-11-12 01:50:10+01:00, andersg@0x63.nu
  Remove unmatched #endif


 af_inet6.c |    1 -
 1 files changed, 1 deletion(-)


diff -Nru a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
--- a/net/ipv6/af_inet6.c	Tue Nov 12 01:54:57 2002
+++ b/net/ipv6/af_inet6.c	Tue Nov 12 01:54:57 2002
@@ -547,7 +547,6 @@
 }
 #endif
 #endif
-#endif
 
 #if defined(MODULE) && defined(CONFIG_SYSCTL)
 extern void ipv6_sysctl_register(void);

===================================================================


This BitKeeper patch contains the following changesets:
1.857
## Wrapped with gzip_uu ##


begin 664 bkpatch11390
M'XL(`&%1T#T``[V576O;,!2&KZ-?(>AEB76.+,D?D-&OL8T.5C)Z-<90924Q
MB>U@*^D*9K]]<IJU:^LL6QBUC6W9\M%[WO-(/J+7C:W3@2XS6S=3<D3?5XU+
M!_!=A4&Y\NUQ5?DVFU6%9=M>;&[KTB[8S9S=+*I;XGM=:6=F=.W?I@,,PH<G
M[FYIT\'X[;OKCZ=C0D8C>C[3Y=1^MHZ.1L15]5HOLN9$N]FB*@-7Z[(IK-.!
MJ8KVH6O+`;C?)48A2-6B`A&U!C-$+=!FP$6L!-$SK7VHO"YTO@A*_]W3".@W
MS@%#U8H8>$@N*`:QC"APALB04\!40HIP[&\`Z#;?DZT;])C3(9`S^G]EGQ-#
MQ[:HUI:NRJ*SS6;TR)99/B&75(C(*[UZ](T,_W$C!#20-WM4G^7NTMJEK9EU
MAN73LJKMBP2B2&([T1$::;,00(=F8I[;M#M4YS^`!("6QX*+O:)\#5F^7"NF
M)]]RWU"!^5U3(I,6$6+>*GFC!-<)RDRH.$Q>:-H5Z5Z2Z"(I@`@WC/8EL!_7
MPQU\#-Q-L[\-ZS,/,98*9,N%`+G!.53/:8;7I_DTRSS"/9;_H(VI\Z5KV-Q4
MY22?LJ*[>@G4S2S=.KW(&^?)OT?D$QW6MYO#DWS56YH#9L2'1%%.^A227H4;
M+'JZ[Z?B8(1)O6K<W4EW-E6][((%>O7EUVA?_X0T8@2QYT*!"L6&"WRZRHDD
ME<DN+H`.\957N?NY]ZS6/0D>4.H+*8'BXT_*#VSFS:H8Q58FDT1S\A.OF4[J
$!0<`````
`
end
