Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbWEUIDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbWEUIDT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 04:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbWEUIDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 04:03:18 -0400
Received: from mail28.syd.optusnet.com.au ([211.29.133.169]:4268 "EHLO
	mail28.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751496AbWEUIDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 04:03:17 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17520.7865.834016.118233@wombat.chubb.wattle.id.au>
Date: Sun, 21 May 2006 18:03:05 +1000
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: renzo@cs.unibo.it (Renzo Davoli)
Cc: linux-kernel@vger.kernel.org, osd@cs.unibo.it
Subject: Re: ptrace enhancements for VM support (patch proposals follow in sep.msgs)
In-Reply-To: <20060518155337.GA17498@cs.unibo.it>
References: <20060518155337.GA17498@cs.unibo.it>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Renzo" == Renzo Davoli <renzo@cs.unibo.it> writes:

Renzo> I am sending with three separate messages (as replies to this)
Renzo> a set of proposed patches for a better support of virtual
Renzo> machines through ptrace.

Goody.  I'm working on a linux vritualisation project for IA64
(Linux-on-Linux, or LoL for short ... yes the acronym is chosen
deliberately).

I also have some `ptrace improvement' patches.  some are the same as
yours (the one-shot syscall stop, for example).

One other that I found very useful for this kind of virtual machine,
is being able to specify an address range for the IP for syscalls to
stop on.  So I can specify that the VM should stop only for syscalls
in the virtual machine, not in the signal trampoline or in the
hypervisro code.

You can get my patches from
http://www.ertos.nicta.com.au/software/virtualisation/lol.pml


They're not quite ready for prime time yet, but are getting pretty close.

Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
http://www.ertos.nicta.com.au           ERTOS within National ICT Australia
