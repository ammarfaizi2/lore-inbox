Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261979AbVCaEu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbVCaEu1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 23:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbVCaEu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 23:50:27 -0500
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:14739 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261979AbVCaEuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 23:50:23 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16971.33143.517408.736512@wombat.chubb.wattle.id.au>
Date: Thu, 31 Mar 2005 14:49:59 +1000
To: Noah Silverman <noah@allresearch.com>
Cc: Burton Windle <bwindle@fint.org>, linux-kernel@vger.kernel.org
Subject: Re: Hangcheck problem
In-Reply-To: <424B2859.1070704@allresearch.com>
References: <424B0FF7.4090601@allresearch.com>
	<Pine.LNX.4.62.0503301709530.1159@morpheus>
	<424B2859.1070704@allresearch.com>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Noah" == Noah Silverman <noah@allresearch.com> writes:

Noah> Sorry 2.6.7


Noah> Burton Windle wrote:
>> Kernel version?

Are you running on an x86 machine without TSC, e.g., a 486?  the
Hangcheck timer then devolves into using jiffies, and a single jiffy
error gives you the printout you mention.

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
