Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263241AbTKQA11 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 19:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263244AbTKQA11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 19:27:27 -0500
Received: from mail014.syd.optusnet.com.au ([211.29.132.160]:36543 "EHLO
	mail014.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263241AbTKQA10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 19:27:26 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16312.5605.129233.279407@wombat.chubb.wattle.id.au>
Date: Mon, 17 Nov 2003 11:27:17 +1100
To: Peter Zaitsev <peter@mysql.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Measuring per thread CPU consumption & others statistics for NPTL
In-Reply-To: <1068997909.2276.64.camel@abyss.local>
References: <1068997909.2276.64.camel@abyss.local>
X-Mailer: VM 7.14 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Peter" == Peter Zaitsev <peter@mysql.com> writes:


Peter> Are there any ways to get similar information for thread rather
Peter> than process ?

Peter> Second question is about accuracy - Is any way to get
Peter> system/user CPU consumption information with more than 1/100
Peter> sec accuracy ?

If you apply my microstate accounting patch, you can get nanosecomnd
resolution per thread.

Peter C
