Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317478AbSG3KY2>; Tue, 30 Jul 2002 06:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318101AbSG3KY1>; Tue, 30 Jul 2002 06:24:27 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:5793 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317478AbSG3KY1>;
	Tue, 30 Jul 2002 06:24:27 -0400
Date: Tue, 30 Jul 2002 12:26:38 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linuxconsole-dev@lists.sourceforge.net, vojtech@suse.cz
Subject: [patch] Small input fixes for 2.5.29 [1/2]
Message-ID: <20020730122638.A11153@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.448.1.1, 2002-07-28 14:04:15+03:00, johann.deneux@it.uu.se
  Small fix to assign continuous values to KEY_*.


===================================================================

 input.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

===================================================================

diff -Nru a/include/linux/input.h b/include/linux/input.h
--- a/include/linux/input.h	Tue Jul 30 12:25:20 2002
+++ b/include/linux/input.h	Tue Jul 30 12:25:20 2002
@@ -473,11 +473,11 @@
 #define KEY_RESTART		0x198
 #define KEY_SLOW		0x199
 #define KEY_SHUFFLE		0x19a
-#define KEY_BREAK		0x1ab
+#define KEY_BREAK		0x19b
 #define KEY_PREVIOUS		0x19c
 #define KEY_DIGITS		0x19d
 #define KEY_TEEN		0x19e
-#define KEY_TWEN		0x1af
+#define KEY_TWEN		0x19f
 
 #define KEY_MAX			0x1ff
 

===================================================================

This BitKeeper patch contains the following changesets:
1.448.1.1
## Wrapped with gzip_uu ##


begin 664 bkpatch11183
M'XL(`)!I1CT``[64:VO;,!2&/UN_0I!O*Y$E6;[$D)%>PC92MI"NC'T:BBS'
M;ARY6'(NPS]^LM,TI;0-NUD&<:37Q^_1>5`/WFI9Q<ZZO#-29*`'/Y;:Q(ZN
MM43BIXUG96EC-RM7TGU0N?.EFZO[V@"[/^5&9'`M*QT[!'F/*V9W+V-G-OYP
M>WT^`V`XA)<95PMY(PT<#H$IJS4O$CWB)BM*A4S%E5Y)PY$H5\VCM*$84SM\
M$GK8#QH28!8V@B2$<$9D@BF+`@8>C(W,)B_R1690+3;6_O,\(?4)\P+L-S[U
M_!!<08(8BQ!!!&+JXM"E$20LQBPF_AGV8HSA76ES*)1()>OM*+>I:Z0E/".P
MC\$%_+=U7`(!;U:\*&":;VUNR+7.%PJ*4IE<U66MH?U;+76[-QE___$.@0GT
M*0D#,#T>,.C_Y@,`YAB\/U%-KD11)](MK)7MG@"4/:ULP$@3,$:B)O7H/*)>
M$*022XZC5X[QK90AC0C!#$<-]L-!T"'THOPT3G]A_%6TWG2^QXQ:YY'M3(L9
MH<\)P]$)PBCLT_]"V/Z;Y(!2F78H7<S&YQ/(5=)%7[^-/[>055);`_)`8&YV
MK7XI=P<2.P#;_GR!_6K3O9:GZ<NM^@,PKU@80`(^[:=>(M-<R:-AQ\%;,IA;
E680[63<]E;65[%7I\;X2F11+7:^&<^$-`C_$X!=E/SR="@4`````
`
end

-- 
Vojtech Pavlik
SuSE Labs
