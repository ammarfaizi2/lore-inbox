Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262453AbSJWBVO>; Tue, 22 Oct 2002 21:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262454AbSJWBVO>; Tue, 22 Oct 2002 21:21:14 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:1263 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S262453AbSJWBVL>; Tue, 22 Oct 2002 21:21:11 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15797.64245.366204.917107@wombat.chubb.wattle.id.au>
Date: Wed, 23 Oct 2002 11:27:17 +1000
To: linux-kernel@vger.kernel.org, ajoshi@unixbox.com,
       jsimmons@maxwell.earthlink.net
Subject: radeon framebuffer code doesn't compile (2.5.44 kernel)
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When trying to compile the radeon framebuffer code in 2.5.44 I see
compilation errors (appended).  My guess is that it hasn't been
updated to match the current fb.h.


drivers/video/radeonfb.c:605: unknown field `fb_get_fix' specified in initializer
drivers/video/radeonfb.c:605: warning: initialization from incompatible pointer type
drivers/video/radeonfb.c:606: unknown field `fb_get_var' specified in initializer
drivers/video/radeonfb.c:606: warning: initialization from incompatible pointer type
drivers/video/radeonfb.c: In function `radeon_set_dispsw':
drivers/video/radeonfb.c:1385: structure has no member named `type'
drivers/video/radeonfb.c:1386: structure has no member named `type_aux'
drivers/video/radeonfb.c:1387: structure has no member named `ypanstep'
drivers/video/radeonfb.c:1388: structure has no member named `ywrapstep'
drivers/video/radeonfb.c:1397: structure has no member named `visual'
drivers/video/radeonfb.c:1398: structure has no member named `line_length'
drivers/video/radeonfb.c:1405: structure has no member named `visual'
drivers/video/radeonfb.c:1406: structure has no member named `line_length'
drivers/video/radeonfb.c:1413: structure has no member named `visual'
drivers/video/radeonfb.c:1414: structure has no member named `line_length'
drivers/video/radeonfb.c:1421: structure has no member named `visual'
drivers/video/radeonfb.c:1422: structure has no member named `line_length'
drivers/video/radeonfb.c: In function `radeonfb_get_fix':
drivers/video/radeonfb.c:1514: structure has no member named `type'
drivers/video/radeonfb.c:1515: structure has no member named `type_aux'
drivers/video/radeonfb.c:1516: structure has no member named `visual'
drivers/video/radeonfb.c:1522: structure has no member named `line_length'
drivers/video/radeonfb.c: In function `radeonfb_set_var':
drivers/video/radeonfb.c:1578: structure has no member named `line_length'
drivers/video/radeonfb.c:1579: structure has no member named `visual'
drivers/video/radeonfb.c:1590: structure has no member named `line_length'
drivers/video/radeonfb.c:1591: structure has no member named `visual'
drivers/video/radeonfb.c:1606: structure has no member named `line_length'
drivers/video/radeonfb.c:1607: structure has no member named `visual'
drivers/video/radeonfb.c:1619: structure has no member named `line_length'
drivers/video/radeonfb.c:1620: structure has no member named `visual'
drivers/video/radeonfb.c: At top level:
drivers/video/radeonfb.c:2487: warning: `fbcon_radeon8' defined but not used
drivers/video/radeonfb.c:598: warning: `radeon_read_OF' declared `static' but never defined
drivers/video/radeonfb.c:1710: warning: `radeonfb_set_cmap' defined but not used
