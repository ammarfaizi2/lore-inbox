Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267681AbTBECfq>; Tue, 4 Feb 2003 21:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267725AbTBECfq>; Tue, 4 Feb 2003 21:35:46 -0500
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:5877 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S267681AbTBECfp>; Tue, 4 Feb 2003 21:35:45 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15936.31404.460011.536725@wombat.chubb.wattle.id.au>
Date: Wed, 5 Feb 2003 13:45:00 +1100
To: Bryan Andersen <bryan@bogonomicon.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       vda@port.imtp.ilyichevsk.odessa.ua, root@chaos.analogic.com,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: gcc 2.95 vs 3.21 performance
In-Reply-To: <120432836@toto.iv>
X-Mailer: VM 7.07 under 21.4 (patch 10) "Military Intelligence" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Bryan" == Bryan Andersen <bryan@bogonomicon.net> writes:

Bryan> Personal opinion here but I know it is also held by many
Bryan> developers I know and work with.  I'd rather have a compiler
Bryan> that produces correct and fast code but ran slow than one that
Bryan> produces slow or bad code and runs fast.  Remember compilation
Bryan> is done far less often than run time execution.  Yes I too
Bryan> noticed a difference when I switched over to 3.2 but I also
Bryan> noticed some of my code speed up.

A different personal opinion:  I'd prefer a compiler than can be told
either to run fast and produce correct but suboptimal code or to
produce the fastest correct code it can.

While developing, the compile/test/think/edit cycle is dominated by compile
time for me.  So fast compilation is important while developing
algorithms.

--
Dr Peter Chubb				    peterc@gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories, all almost the same.
