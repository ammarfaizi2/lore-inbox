Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266058AbRGSUwz>; Thu, 19 Jul 2001 16:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266051AbRGSUwp>; Thu, 19 Jul 2001 16:52:45 -0400
Received: from ncc1701.cistron.net ([195.64.68.38]:52490 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S266047AbRGSUwf>; Thu, 19 Jul 2001 16:52:35 -0400
From: "Rob Turk" <r.turk@chello.nl>
Subject: 2.4.7-pre8 scc.c vector latch region allocation
Date: Thu, 19 Jul 2001 22:50:53 +0200
Organization: Cistron Internet Services B.V.
Message-ID: <9j7han$rc0$1@ncc1701.cistron.net>
X-Trace: ncc1701.cistron.net 995575959 28032 213.46.44.164 (19 Jul 2001 20:52:39 GMT)
X-Complaints-To: abuse@cistron.nl
X-Priority: 3
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

This patch fixes a failure in the scc.c driver to properly allocate the I/O
region for the interrupt vector latch, which is present on some ham radio
SCC cards, such as the PA0HZP card.

Rob Turk - PE1KOX



begin 666 scc_vec.patch
M+2TM(&QI;G5X+F]R9R]D<FEV97)S+VYE="]H86UR861I;R]S8V,N8PE4:'4@
M2G5L(#$Y(#(R.C0X.C V(#(P,#$**RLK(&QI;G5X+V1R:79E<G,O;F5T+VAA
M;7)A9&EO+W-C8RYC"51H=2!*=6P@,3D@,C Z-34Z-3@@,C P,0I 0" M,3<W
M-2PX("LQ-S<U+#@@0$ *( D)"0D)279E8UMH=V-F9RYI<G%=+G5S960@/2 Q
M.PH@"0D)?0H@"BT)"0EI9B H:'=C9F<N=F5C=&]R7VQA=&-H*2!["BT)"0D)
M:68@*"%R97%U97-T7W)E9VEO;BA696-T;W)?3&%T8V@L(#$L(")S8V,@=F5C
M=&]R(&QA=&-H(BDI"BL)"0EI9B H:'=C9F<N=F5C=&]R7VQA=&-H("8F("%6
M96-T;W)?3&%T8V@I('L**PD)"0EI9B H(7)E<75E<W1?<F5G:6]N*&AW8V9G
M+G9E8W1O<E]L871C:"P@,2P@(G-C8R!V96-T;W(@;&%T8V@B*2D*( D)"0D)
M<')I;G1K*$M%4DY?5T%23DE.1R B>C@U,S!D<G8Z('=A<FYI;F<L(&-A;FYO
M="!R97-E<G9E('9E8W1O<B!L871C:"!P;W)T(#!X)6QX7&XL(&1I<V%B;&5D
M+B(L(&AW8V9G+G9E8W1O<E]L871C:"D["B )"0D)96QS90H@"0D)"0E696-T
?;W)?3&%T8V@@/2!H=V-F9RYV96-T;W)?;&%T8V@["@``
`
end


