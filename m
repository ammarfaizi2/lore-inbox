Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267804AbUJLUyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267804AbUJLUyR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 16:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267759AbUJLUx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 16:53:59 -0400
Received: from mmp-2.gci.net ([208.138.130.81]:65457 "EHLO mmp-2.gci.net")
	by vger.kernel.org with ESMTP id S267840AbUJLUt5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 16:49:57 -0400
Date: Tue, 12 Oct 2004 12:49:51 -0800
From: leif <leif@gci.net>
Subject: patch: usb serial driver pl2303
In-reply-to: <20020809192208.53108.qmail@web12103.mail.yahoo.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Message-id: <0I5H00HZWOJ8KG@mmp-2.gci.net>
Organization: General Communication, Inc
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Content-transfer-encoding: 7BIT
Thread-index: AcI/22wQ26DE/ad6Tr+grRo1MqfPV4ThgSsw
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a small patch to add support for the Microsoft branded Pharos GPS-360.

The device uses the same driver, just requires the additional 
product_id of 0xaaa0


Please reply directly, as I'm not subscribed.


Thanks,

Leif Sawyer

"It's pronounced Layf...you know, like Leif Garret? Don't you watch
 'I Love the 70's'? What kind of retro lover are you, anyway?"




begin 666 pl2303.diff
M9&EF9B M<G4@9')I=F5R<R]U<V(O<V5R:6%L+W!L,C,P,RYC(&1R:79E<G,O
M=7-B+W-E<FEA;"UN97<O<&PR,S S+F,-"BTM+2!L;G@R-CEP-"UO;&0O9')I
M=F5R<R]U<V(O<V5R:6%L+W!L,C,P,RYC"3(P,#0M,3 M,3(@,3(Z,S@Z-# N
M,S<R-#4V,S0P("TP.# P#0HK*RL@;&YX,C8Y<#0M;F5W+V1R:79E<G,O=7-B
M+W-E<FEA;"]P;#(S,#,N8PDR,# T+3$P+3$R(#$R.C,X.C0P+C,W,C0U-C,T
M," M,#@P, T*0$ @+38S+#8@*S8S+#<@0$ -"B!S=&%T:6,@<W1R=6-T('5S
M8E]D979I8V5?:60@:61?=&%B;&4@6UT@/2![#0H@"7L@55-"7T1%5DE#12A0
M3#(S,#-?5D5.1$]27TE$+"!03#(S,#-?4%)/1%5#5%])1"D@?2P-"B )>R!5
M4T)?1$5624-%*%!,,C,P,U]614Y$3U)?240L(%!,,C,P,U]04D]$54-47TE$
M7U)305$R*2!]+ T**PE[(%530E]$159)0T4H4$PR,S S7U9%3D1/4E])1"P@
M4$PR,S S7U!23T150U1?241?35-&5"D@?2P-"B )>R!54T)?1$5624-%*$E/
M1$%405]614Y$3U)?240L($E/1$%405]04D]$54-47TE$*2!]+ T*( E[(%53
M0E]$159)0T4H051%3E]614Y$3U)?240L($%414Y?4%)/1%5#5%])1"D@?2P-
M"B )>R!54T)?1$5624-%*$%414Y?5D5.1$]27TE$,BP@051%3E]04D]$54-4
M7TE$*2!]+ T*9&EF9B M<G4@9')I=F5R<R]U<V(O<V5R:6%L+W!L,C,P,RYH
M(&1R:79E<G,O=7-B+W-E<FEA;"UN97<O<&PR,S S+F@-"BTM+2!D<FEV97)S
M+W5S8B]S97)I86PO<&PR,S S+F@),C P-"TQ,"TQ,B Q,CHS.#HT,"XX-C(V
M,3 U.#@@+3 X,# -"BLK*R!D<FEV97)S+W5S8B]S97)I86PM;F5W+W!L,C,P
M,RYH"3(P,#0M,3 M,3(@,3(Z,S@Z-# N.#8R-C$P-3@X("TP.# P#0I 0" M
M,3 L-B K,3 L-R! 0 T*("-D969I;F4@4$PR,S S7U9%3D1/4E])1 DP># V
M-V(-"B C9&5F:6YE(%!,,C,P,U]04D]$54-47TE$"3!X,C,P,PT*("-D969I
M;F4@4$PR,S S7U!23T150U1?241?4E-!43(),'@P-&)B#0HK(V1E9FEN92!0
M3#(S,#-?4%)/1%5#5%])1%]-4T94"3!X86%A, T*( T*("-D969I;F4@051%
M3E]614Y$3U)?240)"3!X,#4U-PT*("-D969I;F4@051%3E]614Y$3U)?240R
*"0DP># U-#<-"@``
`
end

begin 666 smime.p7s
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
$````````
`
end


