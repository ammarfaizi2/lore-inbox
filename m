Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261853AbVCOUD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbVCOUD3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 15:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbVCOUAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 15:00:23 -0500
Received: from pop-a065d14.pas.sa.earthlink.net ([207.217.121.252]:34227 "EHLO
	pop-a065d14.pas.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S261851AbVCOT4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 14:56:30 -0500
Subject: [PATCH] Export dev_get_flags in net/core/dev.c to fix missing
	symbols
From: Alex Tribble <prat@rice.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Rice University
Message-Id: <1110916582.27963.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 15 Mar 2005 13:56:22 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.2186, 2005-03-15 13:46:12-06:00, prat@prat.homelinux.net
  Export dev_get_flags to fix missing symbols in ipv6.ko


 dev.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/net/core/dev.c b/net/core/dev.c
--- a/net/core/dev.c	2005-03-15 13:54:23 -06:00
+++ b/net/core/dev.c	2005-03-15 13:54:23 -06:00
@@ -3325,6 +3325,7 @@
 EXPORT_SYMBOL(dev_remove_pack);
 EXPORT_SYMBOL(dev_set_allmulti);
 EXPORT_SYMBOL(dev_set_promiscuity);
+EXPORT_SYMBOL(dev_get_flags);
 EXPORT_SYMBOL(dev_change_flags);
 EXPORT_SYMBOL(dev_set_mtu);
 EXPORT_SYMBOL(dev_set_mac_address);

===================================================================


This BitKeeper patch contains the following changesets:
1.2186
## Wrapped with gzip_uu ##


M'XL( &\]-T(  \V46VO;,!3'GZ-/(>C+QHBLBZ\I&5F[L(YU)*0K;(P1%%N^
M++%E)#F7X0\_Q27-TG64E3U,THMU_AR?_SD_= 9OM5"#7JVX 6?P2FIS]X%R
M68I5435;5(E]:":E#3F-5LX^Y.Q%CA:UTXGZ%'G JJ;<Q#E<"Z4'/8+8_8W9
MU6+0FXW?W5Z_F0$P',++G%>9N!$&#H? 2+7FJT2/N,E7LD)&\4J7PG 4R[*]
ME[848VJW1P*&/;\E/G:#-B8)(=PE(L'4#7WWF*VNXRC 2.IDA:3*3A-YF!$/
M!Q2SL"4LQ#YX"PFB)/0A]AS,'.)!P@:N/R"TC_T!QG#O>?1[=^ K OL87,!_
M:^,2Q'"\K:4R,!'K>2;,/%WQ3-O?P+38PK+0NJ@RJ'?E0JXT+"I8U&L?+27X
M8"OW@Q!,CVT&_;]< &".P>LG3%G[3BR5<&R)*/[56>39OM* N&W(O"!*PSAQ
M_63!HC^U\9%<W8Q(1.UN/>I&;H?.J>YI?IY1(TB;!5>C1J-B4>Z3?/V><?6C
M6'Y[M$I*""6>BZ/6C2*7=20]!(E&]OQ?(*52=<@X/$E4+*L4Q>=0FERH3:$%
MW,D&6O$!-)OE@-HF%U47-FJWQ[&H["MB#O@AR]_=M":PKS;=L3Q-'PSN&42^
M9XP&D(#QY^ED]FE^\^7CQ>3ZQ8FIE^?'=RC.1;S433E<<,:\Q,?@)^7<Y(WP
#!   
 


