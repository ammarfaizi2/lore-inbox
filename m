Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270625AbTGVKoK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 06:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270637AbTGVKoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 06:44:10 -0400
Received: from c210-49-26-171.randw1.nsw.optusnet.com.au ([210.49.26.171]:14790
	"EHLO mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id S270625AbTGVKoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 06:44:09 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16157.6400.38828.602041@wombat.chubb.wattle.id.au>
Date: Tue, 22 Jul 2003 20:59:12 +1000
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test1: Laptop runs hot, short battery life
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	Under recent 2.5 kernels, my laptop runs a lot hotter than
under 2.4.20 -- the fans seem to go continuously, the disc never
powers down, and consequently battery life is around half what it is
with 2.4.20.

I'm using XFS, mounted with the	`noatime' option, and a 5-minute
xfs_sync value, in both cases.

The laptop has ACPI only, no APM.  On battery, the processor (a 2GHz
Pentium 4) is dropped to 1GHz and put into ACPI C3 state.

Does anyone have any ideas about what's changed, and how it can be
fixed to get better battery life again?   Maybe XFS is
syncing its logs more often, or something.

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories,   all slightly different.
