Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265983AbUEUWci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265983AbUEUWci (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 18:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265950AbUEUWci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 18:32:38 -0400
Received: from mail002.syd.optusnet.com.au ([211.29.132.32]:1437 "EHLO
	mail002.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266054AbUEUWcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 18:32:35 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16555.58996.710139.844507@wombat.chubb.wattle.id.au>
Date: Thu, 20 May 2004 08:57:56 +1000
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Justin Pryzby <justinpryzby@users.sourceforge.net>
Cc: Peter Chubb <peter@chubb.wattle.id.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5, 2.6.6-rc2 sluggish interrupts
In-Reply-To: <20040519212149.GA1075@andromeda>
References: <E1BJOXM-0007zu-6H@andromeda>
	<20040519191900.GA1052@andromeda>
	<20040519192414.GA1210@andromeda>
	<20040519212149.GA1075@andromeda>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Justin" == Justin Pryzby <justinpryzby@users.sourceforge.net> writes:

Justin> Found a solution: disable cpufreq.  
The alternative may be to use a more stable timesource than the TSC
(which varies in rate when cpufreq is enabled)

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*

