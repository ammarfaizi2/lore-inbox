Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131679AbQKWAn2>; Wed, 22 Nov 2000 19:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132283AbQKWAnR>; Wed, 22 Nov 2000 19:43:17 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63757 "EHLO
        www.linux.org.uk") by vger.kernel.org with ESMTP id <S131679AbQKWAnL>;
        Wed, 22 Nov 2000 19:43:11 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011230010.AAA02797@raistlin.arm.linux.org.uk>
Subject: Re: silly [< >] and other excess
To: acahalan@cs.uml.edu (Albert D. Cahalan)
Date: Thu, 23 Nov 2000 00:10:03 +0000 (GMT)
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
In-Reply-To: <200011222354.eAMNs1564115@saturn.cs.uml.edu> from "Albert D. Cahalan" at Nov 22, 2000 06:54:01 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert D. Cahalan writes:
> > c1e97ee0:                                                        c00251f8 c280007c
> > c1e97f00: 60000013 ffffffff c1e97fac c1e97f18  c0026194 c280006c c1e37000 c1e38000
> 
> [ --- CHOP --- ]
> 
> All these numbers get looked up.

These numbers should NOT get looked up - if they are, then very
useful information will be lost; they are not only references to
kernel functions, but also kernel data and read only data within
the kernel text segment.  The result will be a totally undeciperal
garbage.

Again, care to put the effort into klogd/ksymoops to handle the
architecture special cases?
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
