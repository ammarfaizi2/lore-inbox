Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265870AbUAEDr0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 22:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265871AbUAEDr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 22:47:26 -0500
Received: from mail002.syd.optusnet.com.au ([211.29.132.32]:30419 "EHLO
	mail002.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265870AbUAEDrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 22:47:25 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16376.56858.132710.846819@wombat.chubb.wattle.id.au>
Date: Mon, 5 Jan 2004 14:46:34 +1100
Cc: Soeren Sonnenburg <kernel@nn7.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
To: Willy TARREAU <willy@w.ods.org>
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
In-Reply-To: <20040104205411.GA219@pcw.home.local>
References: <1073075108.9851.16.camel@localhost>
	<20040103191901.GC3728@alpha.home.local>
	<16376.31727.114173.311369@wombat.chubb.wattle.id.au>
	<20040104205411.GA219@pcw.home.local>
X-Mailer: VM 7.14 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Willy" == Willy TARREAU <willy@w.ods.org> writes:
> >> So it is like 30 times slower on 2.6. when running for the first
> >> time...  this also happens if I do e.g. find ./ and watch the
> >> output pass by...
>> 
>> For some processes, allowing interrupts back on (hdparm -u1) helps;
>> for others, switching to the deadline elevator helps; neither are
>> complete solutions.

Willy> This is not I/O related since the problem happens even with
Willy> simple programs such as dmesg and seq.

Yes ... the first time you run a program it's fetched from disc and
shows a significant slowdown.  Second and subsequent times, it runs at
normal speed.  At least, that's what *I'm* seeing.

Peter C


