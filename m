Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263290AbUCNFX0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 00:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263292AbUCNFX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 00:23:26 -0500
Received: from mail023.syd.optusnet.com.au ([211.29.132.101]:19675 "EHLO
	mail023.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263290AbUCNFXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 00:23:23 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16467.60450.471487.490560@wombat.chubb.wattle.id.au>
Date: Sun, 14 Mar 2004 16:22:42 +1100
To: William Lee Irwin III <wli@holomorphy.com>
CC: Andi Kleen <ak@suse.de>, Ray Bryant <raybry@sgi.com>,
       lse-tech@lists.sourceforge.net,
       "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: Hugetlbpages in very large memory machines.......
In-Reply-To: <20040314000506.GE655@holomorphy.com>
References: <40528383.10305@sgi.com>
	<20040313034840.GF4638@wotan.suse.de>
	<20040313054910.GA655@holomorphy.com>
	<20040313161010.GB15118@wotan.suse.de>
	<20040314000506.GE655@holomorphy.com>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "William" == William Lee Irwin, <William> writes:

William> At some point in the past, I wrote:

William> On Sat, Mar 13, 2004 at 05:10:10PM +0100, Andi Kleen wrote:
>> Redesigning the low level TLB fault handling for this would not
>> count as "easily" in my book.

William> I make no estimate of ease of implementation of long mode
William> VHPT support.  The point of the above is that the virtual
William> placement constraint is an artifact of the implementation and
William> not inherent in hardware.

Ther's a patch available to enable long-format VHPT at
www.gelato.unsw.edu.au

We're waiting for 2.7 to open before pushing it in. The long-format
vpht is a prerequisite for other work we're doing on super-pagesand
TLB sharing.

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
