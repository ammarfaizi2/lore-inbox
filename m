Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbUK2WUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbUK2WUz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 17:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbUK2WTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 17:19:25 -0500
Received: from mail20.syd.optusnet.com.au ([211.29.132.201]:15233 "EHLO
	mail20.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261835AbUK2WS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 17:18:58 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16811.41030.901140.963491@wombat.chubb.wattle.id.au>
Date: Tue, 30 Nov 2004 09:18:46 +1100
To: Sam Ravnborg <sam@ravnborg.org>, Russell King <rmk@arm.linux.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Config files that aren't mach_defconfig...
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Sam,
   I've just finished porting Linux 2.6 to a new ARM board, that needs
a custom initramfs list.  My approach was to set
CONFIG_INITRAMFS_SOURCE to point to
"$(srctree)/arch/arm/configs/pleb2_initramfs" in the appropriate
defconfig for the board, as it's a default configuration item; but
Russell asks if there isn't a better place for a per-board default initramfs
script to live? 

What I'd like is for the appropriate default -- for this board --
script to be carried around and updated with the other configuration
files, somehow.

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
