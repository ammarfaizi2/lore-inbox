Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267795AbTANFnB>; Tue, 14 Jan 2003 00:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267796AbTANFnB>; Tue, 14 Jan 2003 00:43:01 -0500
Received: from fmr01.intel.com ([192.55.52.18]:34262 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S267795AbTANFm7>;
	Tue, 14 Jan 2003 00:42:59 -0500
Subject: [BUG FIX] e100 initialization issue on STL2 motherboard
From: Louis Zhuang <louis.zhuang@linux.co.intel.com>
To: jgarzik@redhat.com, scott.feldman@intel.com
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Intel Crop.
Message-Id: <1042523515.3951.12.camel@hawk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 14 Jan 2003 13:51:55 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Jeff,
	The patch will increase waiting time in SCB initialization. It will
resolve the issue on STL2 motherboard. Pls apply. 
-- 
Yours truly,
Louis Zhuang
---------------
Fault Injection Test Harness Project
BK tree: http://fault-injection.bkbits.net/linux-2.5
Home Page: http://sf.net/projects/fault-injection

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1019, 2003-01-14 13:45:36+08:00, louis@hawk.sh.intel.com
  fix e100 initialization issue on STL2 motherboard


 e100.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/net/e100/e100.h b/drivers/net/e100/e100.h
--- a/drivers/net/e100/e100.h	Tue Jan 14 13:46:26 2003
+++ b/drivers/net/e100/e100.h	Tue Jan 14 13:46:26 2003
@@ -100,7 +100,7 @@
 
 #define E100_MAX_NIC 16
 
-#define E100_MAX_SCB_WAIT	100	/* Max udelays in wait_scb */
+#define E100_MAX_SCB_WAIT	5000	/* Max udelays in wait_scb */
 #define E100_MAX_CU_IDLE_WAIT	50	/* Max udelays in wait_cus_idle */
 
 /* HWI feature related constant */

===================================================================


This BitKeeper patch contains the following changesets:
1.1019
## Wrapped with gzip_uu ##


begin 664 bkpatch4832
M'XL(`#*D(SX``\U4:VO;,!3]'/V*"_W6$OM>V7)20T;2!UMIRTH?;-^":LNU
M%ML:EM(7_O%3G)%22O9B@TG"$KK2T3WG'KP#-U:UZ:`R2VW9#GPPUJ6#4CXL
M`EL&NG&J"C)3^\BE,3X2EJ9687\ZY($8%IKYV(5T60GWJK7I@()HL^.>OJIT
M<'G\_N9L=LG89`*'I6SNU)5R,)DP9]I[6>5V*EU9F29PK6QLK9Q</=EMCG8<
MD?LN:!2A2#I*,!YU&>5$,B:5(X_'2<RLDTVEGJ:U;)S.3*M>,7@-%R%1[`'C
M*.G\;1&S(Z"`D/8!HQ`II!@H2F.11LD>CE-$Z#E/WR@#>P1#9`?P=\D<L@P*
M_0B*_-.ZT4[+2C]+ITT#VMJE`K^XNC[C4!M7JO;6R#9GI\!%A)Q=O.C,AK_9
M&$.)[!U\N9/MLUZLY,Q;N5#6%*ZGDK=Z5>FP42Y<I==_@G)-+,(1CCGG48>C
M?2&Z0JJ"N,!1,LYX,8ZWR?@CU._%BCVUE5R4]$[:<F'EJW^3^@:V57DI?PKH
ML\:($W).'8G]9&TQ3F\,AK]@,/IO#+8NP$<8M@_]\(:YV%:+/_#>D1<-B)VL
MIYU<%;I1<.SAYN>SS_.KPX/YI]G)]4`@XB#<A7/Y",M<5?+)>A;P(+6;V^P6
;=L.7_U)6JFQAE_5D7,1"B$*P;QI*PE?V!```
`
end


