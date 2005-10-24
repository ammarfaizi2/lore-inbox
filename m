Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbVJXBV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbVJXBV6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 21:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbVJXBV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 21:21:58 -0400
Received: from mail21.syd.optusnet.com.au ([211.29.133.158]:40158 "EHLO
	mail21.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750894AbVJXBV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 21:21:57 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17244.14122.511599.225842@wombat.chubb.wattle.id.au>
Date: Mon, 24 Oct 2005 11:21:46 +1000
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Claudio Scordino <cloud.of.andor@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Task profiling in Linux
In-Reply-To: <200510232249.39236.cloud.of.andor@gmail.com>
References: <200510232249.39236.cloud.of.andor@gmail.com>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Claudio" == Claudio Scordino <cloud.of.andor@gmail.com> writes:


Claudio> I found out that Linux provides the getrusage() syscall which
Claudio> provides the information that I need. This syscall also says
Claudio> both user and system times used by the task, which is a very
Claudio> useful thing.

Claudio> However, it has two main drawbacks:

Claudio> - its precision is very low: I'm working with real-time tasks
Claudio> on a Athlon-64 and I need a more accurate estimation

Claudio> - it can't be invoked by a generic task to know the execution
Claudio> time of another task

This is part of what my microstate accounting package provides
.... but I haven't done a port to AMD64 yet...

See http://www.gelato.unsw.edu.au/patches/

-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
