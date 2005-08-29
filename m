Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751337AbVH2XJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbVH2XJS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 19:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbVH2XJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 19:09:17 -0400
Received: from mail12.syd.optusnet.com.au ([211.29.132.193]:42671 "EHLO
	mail12.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751337AbVH2XJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 19:09:15 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17171.38290.829050.71419@wombat.chubb.wattle.id.au>
Date: Tue, 30 Aug 2005 09:09:06 +1000
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Holger Kiehl <Holger.Kiehl@dwd.de>
Cc: linux-raid <linux-raid@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Where is the performance bottleneck?
In-Reply-To: <Pine.LNX.4.61.0508291811480.24072@diagnostix.dwd.de>
References: <Pine.LNX.4.61.0508291811480.24072@diagnostix.dwd.de>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Holger" == Holger Kiehl <Holger.Kiehl@dwd.de> writes:

Holger> Hello I have a system with the following setup:

	(4-way CPUs, 8 spindles on two controllers)

Try using XFS.

See http://scalability.gelato.org/DiskScalability_2fResults --- ext3
is single threaded and tends not to get the full benefit of either the
multiple spindles nor the multiple processors.

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
