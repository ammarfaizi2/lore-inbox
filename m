Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262788AbVHEAMC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbVHEAMC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 20:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262789AbVHEAMC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 20:12:02 -0400
Received: from mail17.syd.optusnet.com.au ([211.29.132.198]:49566 "EHLO
	mail17.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262788AbVHEAL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 20:11:59 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17138.44726.845760.992792@wombat.chubb.wattle.id.au>
Date: Fri, 5 Aug 2005 10:11:34 +1000
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Clemens Koller <clemens.koller@anagramm.de>,
       LKML List <linux-kernel@vger.kernel.org>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: How to get the physical page addresses from a kernel virtual	address for DMA SG List?
In-Reply-To: <1123163846.12009.15.camel@localhost.localdomain>
References: <42F20CEC.60206@anagramm.de>
	<Pine.LNX.4.61.0508040900300.3410@chaos.analogic.com>
	<42F21A86.8030408@anagramm.de>
	<1123163846.12009.15.camel@localhost.localdomain>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You may want to take a look at the user-mode driver infrastructure
patches, which do almost exactly what you're trying to do.

Get them from
http://www.gelato.unsw.edu.au/cgi-bin/viewcvs.cgi/cvs/kernel/usrdrivers/kernel-2.6.12-rc3/

-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
