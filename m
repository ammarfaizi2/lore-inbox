Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263324AbUFXAyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263324AbUFXAyx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 20:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263413AbUFXAyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 20:54:53 -0400
Received: from mail006.syd.optusnet.com.au ([211.29.132.63]:32236 "EHLO
	mail006.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263324AbUFXAyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 20:54:52 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16602.9814.700745.300562@wombat.chubb.wattle.id.au>
Date: Thu, 24 Jun 2004 10:54:46 +1000
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: linux-kernel@vger.kernel.org
CC: Andrey Panin <pazke@donpac.ru>
Subject: Moving per-arch IRQ handling code into common directories
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Folks,
  Inside each arch-specific kernel/irq.c, there's a comment something like, 
  /* (mostly architecture independent, will move to kernel/irq.c in 2.5.) */

This obviously hasn't happened, even though there was a patch by
Andrey Panin floating about around a year ago.  Is there some
fundamental objection to consolidating the IRQ handling as far as
possible, or was it just that the patch didn't get high enough profile?


-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
