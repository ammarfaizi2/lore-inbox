Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265058AbUD3EPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265058AbUD3EPN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 00:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265057AbUD3EPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 00:15:13 -0400
Received: from mail001.syd.optusnet.com.au ([211.29.132.142]:16578 "EHLO
	mail001.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265058AbUD3EPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 00:15:10 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16529.53960.24100.683096@wombat.chubb.wattle.id.au>
Date: Fri, 30 Apr 2004 14:15:04 +1000
To: Justin Pryzby <justinpryzby@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5, 2.6.6-rc2 sluggish interrupts
In-Reply-To: <689431378@toto.iv>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Justin" == Justin Pryzby <justinpryzby@users.sourceforge.net> writes:

Justin> --Q68bSM7Ycu6FN28Q Content-Type: text/plain; charset=us-ascii
Justin> Content-Disposition: inline Content-Transfer-Encoding:
Justin> quoted-printable

Justin> It feels to me like it always happens when the disk is
Justin> accessed (possibly just because I can _hear_ that), and it
Justin> seems like it happens when the disk hasn't been used in a
Justin> while.

Try 
    1.  booting with elevator=deadline
    2. hdparm -u /dev/hda

One of these might help.

Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
