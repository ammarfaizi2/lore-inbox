Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbUK2WOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbUK2WOQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 17:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261829AbUK2WOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 17:14:16 -0500
Received: from mail05.syd.optusnet.com.au ([211.29.132.186]:47795 "EHLO
	mail05.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261830AbUK2WOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 17:14:12 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16811.40687.892939.304185@wombat.chubb.wattle.id.au>
Date: Tue, 30 Nov 2004 09:13:03 +1100
To: Jeff Dike <jdike@addtoit.com>
Cc: grendel@caudium.net, linux-kernel@vger.kernel.org
Subject: Re: user- vs kernel-level resource sandbox for Linux? 
In-Reply-To: <200411292000.iATK0qOF004026@ccure.user-mode-linux.org>
References: <20041129101919.GB9419@beowulf.thanes.org>
	<200411292000.iATK0qOF004026@ccure.user-mode-linux.org>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jeff" == Jeff Dike <jdike@addtoit.com> writes:

Jeff> grendel@caudium.net said:
>> I would appreciate any pointers to the userland solutions for that
>> problem (if any exist) before I resort to Xen/UML.

Jeff> UML would be exactly what you're looking for.

Jeff> 				Jeff

apart from the performance hit :-(

There have been a number of different approaches proposed in the past
to limit real memory usage per-process; search for RSS limit in the
archives.

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*

