Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbUCAABp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 19:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbUCAABn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 19:01:43 -0500
Received: from mail022.syd.optusnet.com.au ([211.29.132.100]:64900 "EHLO
	mail022.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262191AbUCAABl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 19:01:41 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16450.32046.538912.553878@wombat.chubb.wattle.id.au>
Date: Mon, 1 Mar 2004 11:00:46 +1100
To: Paul Jackson <pj@sgi.com>
Cc: Joachim B Haga <c.j.b.haga@fys.uio.no>, peterw@aurema.com,
       miller@techsource.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
In-Reply-To: <894006121@toto.iv>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Paul" == Paul Jackson <pj@sgi.com> writes:


Paul> Is there anyway to provide a mechanism that would support
Paul> administering a system as follows:

Paul>   1) Users get so much CPU usage allowed, determined by an upper
Paul> limit on a running average of the combined CPU usage of all
Paul> their tasks, with a half life perhaps on the order of minutes.

Paul>   2) They can nice their tasks up and down, within a decent
Paul> range, as they will.

Paul>   3) But if they push too close to their allowed limit, all
Paul> their tasks get reined in.  The relative priorities within their
Paul> own tasks are not changed, but the priority of their tasks
Paul> relative to other users is weakened.

This is exactly what the commercial product ARMtech does.  The EBS
that Aurema have just released as open source is (a small) part of the
commercial product.

See http://www.aurema.com

Peter C (an ex-employee of Aurema)

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
