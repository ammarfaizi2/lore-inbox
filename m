Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbVIMAJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbVIMAJH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 20:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbVIMAJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 20:09:07 -0400
Received: from mail15.syd.optusnet.com.au ([211.29.132.196]:23991 "EHLO
	mail15.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932381AbVIMAJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 20:09:05 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17190.6292.564137.462416@wombat.chubb.wattle.id.au>
Date: Tue, 13 Sep 2005 10:08:52 +1000
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Sam Ravnborg" <sam@ravnborg.org>, <linux-kernel@vger.kernel.org>
Subject: RE: new asm-offsets.h patch problems
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F045A9188@scsmsx401.amr.corp.intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F045A9188@scsmsx401.amr.corp.intel.com>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Tony" == Tony Luck <Luck> writes:

Tony> So I still don't understand what is really happening here.  I
Tony> left my build script running overnight ... working on a kernel
Tony> at the 357d596bd... commit (where Linus merged in my tree last
Tony> night).  This one has your "archprepare" patch already included.

There's something else wrong too ... make rebuilds everything every
time on IA64 now, rather than just the things that have changed (when
compiling with -O)

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
