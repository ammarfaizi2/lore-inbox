Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135977AbREGXjZ>; Mon, 7 May 2001 19:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135979AbREGXjP>; Mon, 7 May 2001 19:39:15 -0400
Received: from edtn006530.hs.telusplanet.net ([161.184.137.180]:56846 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S135977AbREGXi7>; Mon, 7 May 2001 19:38:59 -0400
Date: Mon, 7 May 2001 17:38:55 -0600
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Subject: Troubles with 8139too and 2.2.19
Message-ID: <20010507173855.A1205@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like tha 8139too, at least in 2.2.19, works fine when there
is one such card around but with NICs it detects both but fails to
set the second one correctly (complaints about incorrect IRQ, memory,
... - you name it).  Does anybody has some ideas what is going on here?

This was observed on Alpha, BTW, but this tidbit is likely not relevant
and, yes, we used pairs of other NICs before on similar machines.

Alternate rtl8139 module from that kernel cannot detect D-link DFE-538
card.  A version of this driver from http://www.scyld.com seems to be ok
(at least both cards start) once you will get it to compile. :-)

  Michal
