Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271369AbTGWXR5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 19:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271383AbTGWXR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 19:17:57 -0400
Received: from c210-49-26-171.randw1.nsw.optusnet.com.au ([210.49.26.171]:3022
	"EHLO mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id S271369AbTGWXR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 19:17:56 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16159.6944.889606.686405@wombat.chubb.wattle.id.au>
Date: Thu, 24 Jul 2003 09:32:48 +1000
To: davidsen@tmr.com (bill davidsen)
CC: linux-kernel@vger.kernel.org, kravetz@us.ibm.com
Subject: Re: [Lse-tech] [patch 2.6.0-test1] per cpu times
Newsgroups: mail.linux-kernel
In-Reply-To: <bfmvvi$lba$1@gatekeeper.tmr.com>
References: <200307181835.42454.efocht@hpce.nec.com>
	<20030718111850.C1627@w-mikek2.beaverton.ibm.com>
	<bfmvvi$lba$1@gatekeeper.tmr.com>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "bill" == bill davidsen <davidsen@tmr.com> writes:
>>>>> "Mike" == Mike Kravetz  <kravetz@us.ibm.com>

Mike> On a somewhat related note ...  We (Big Blue) have a
Mike> performance reporting application that would like to know how
Mike> long a task sits on a runqueue before it is actually given the
Mike> CPU.  In other words, it wants to know how long the 'runnable
Mike> task' was delayed due to contention for the CPU(s).  Of
Mike> course, one could get an overall feel for this based on total
Mike> runqueue length.  However, this app would really like this
Mike> info on a per-task basis.

bill> This is certainly a useful number. 

This is exactly what's measured by the microstate accounting patches
I've been pushing to LKML, along with a few other useful statistics.

If you try it, please let me know: see
http://marc.theaimsgroup.com/?l=linux-kernel&m=105884469205748&w=2


--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories,   all slightly different.
