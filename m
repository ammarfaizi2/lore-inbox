Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbVBWXDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbVBWXDB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 18:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbVBWXCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 18:02:23 -0500
Received: from mail04.syd.optusnet.com.au ([211.29.132.185]:35491 "EHLO
	mail04.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261669AbVBWW7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 17:59:24 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16925.2739.232237.418632@wombat.chubb.wattle.id.au>
Date: Thu, 24 Feb 2005 09:58:59 +1100
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Alan Kilian <kilian@bobodyne.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Help enabling PCI interrupts on Dell/SMP and Sun/SMP systems.
In-Reply-To: <1109197066.9116.319.camel@desk>
References: <1109190273.9116.307.camel@desk>
	<Pine.LNX.4.61.0502231538230.5623@chaos.analogic.com>
	<1109197066.9116.319.camel@desk>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Alan" == Alan Kilian <kilian@bobodyne.com> writes:






Alan> 	kernel: SSE: Found a DeCypher card.  kernel: ACPI: PCI
Alan> interrupt 0000:13:03.0[A] -> GSI 36 (level, low) -> IRQ 217

If ACPI has set this device up to use interrupt 217, why are you
registering it on IRQ 5?

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
