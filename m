Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbTISFLo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 01:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbTISFLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 01:11:44 -0400
Received: from mail015.syd.optusnet.com.au ([211.29.132.161]:20903 "EHLO
	mail015.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261336AbTISFLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 01:11:42 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16234.36857.148623.797189@wombat.chubb.wattle.id.au>
Date: Fri, 19 Sep 2003 15:11:21 +1000
To: Grant Grundler <iod00d@hp.com>
Cc: Andi Kleen <ak@suse.de>, Peter Chubb <peterc@gelato.unsw.edu.au>,
       linux-ns83820@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
In-Reply-To: <20030919050429.GA3159@cup.hp.com>
References: <16234.33565.64383.838490@wombat.disy.cse.unsw.edu.au>
	<20030919043847.GA2996@cup.hp.com>
	<20030919044315.GC7666@wotan.suse.de>
	<20030919050429.GA3159@cup.hp.com>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Grant" == Grant Grundler <iod00d@hp.com> writes:

Grant> On Fri, Sep 19, 2003 at 06:43:15AM +0200, Andi Kleen wrote:

Grant> Same is true for TX/RX descriptor addresses.  Behavior is
Grant> undefined if the addresses for DMA are not 4-byte aligned.

Grant> Anyone know if that's true for NS83820?  I couldn't find which
Grant> driver controls that chip/NIC via a quick grep.

I believe it is, based on the experiments I've done here, and on
looking at the BSD driver.

Driver is drivers/net/ns83820.c

Peter C
