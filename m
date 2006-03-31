Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbWCaC4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWCaC4e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 21:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbWCaC4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 21:56:34 -0500
Received: from mail03.syd.optusnet.com.au ([211.29.132.184]:23984 "EHLO
	mail03.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750807AbWCaC4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 21:56:33 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17452.39418.693521.149502@wombat.chubb.wattle.id.au>
Date: Fri, 31 Mar 2006 13:54:50 +1100
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, balbir@in.ibm.com, greg@kroah.com,
       arjan@infradead.org, hadi@cyberus.ca, ak@suse.de,
       linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [Patch 0/8] per-task delay accounting
In-Reply-To: <442C140C.8040404@watson.ibm.com>
References: <442B271D.10208@watson.ibm.com>
	<20060329210314.3db53aaa.akpm@osdl.org>
	<20060330062357.GB18387@in.ibm.com>
	<20060329224737.071b9567.akpm@osdl.org>
	<442C140C.8040404@watson.ibm.com>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Shailabh" == Shailabh Nagar <nagar@watson.ibm.com> writes:

>> 
Shailabh> To this list we can also add

Shailabh>     Microstate accounting Peter Chubb
Shailabh> <peter@chubb.wattle.id.au> I don't know if Peter is still
Shailabh> interested in pursuing this or it was rejected.

It's still maintained in a sporadic sort of way --- I update it when
either I need it for something, or someone's downloaded it and asks
why it doesn't work agains kernel X.Y.Z.  I see a few downloads a
month.

My microstate accounting patch overlaps the delay accounting patch quite a
lot in functionality, (but I thnk mine is cleaner except for interrupt
time accounting... which the delay accounting patch doesn't do.  I
wanted to know how much time a thread *really* had on the processor,
subtracting off the time spent in interrupt handlers for some other
process).

-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
http://www.ertos.nicta.com.au           ERTOS within National ICT Australia
