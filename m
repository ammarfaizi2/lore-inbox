Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbVB1AIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbVB1AIy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 19:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbVB1AHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 19:07:35 -0500
Received: from mail20.syd.optusnet.com.au ([211.29.132.201]:60575 "EHLO
	mail20.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261518AbVB0X4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 18:56:38 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16930.24088.251669.488622@wombat.chubb.wattle.id.au>
Date: Mon, 28 Feb 2005 10:56:08 +1100
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Andrew Morton <akpm@osdl.org>
Cc: <stone_wang@sohu.com>, riel@redhat.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux-2.6.11-rc5: kernel/sys.c setrlimit() RLIMIT_RSS cleanup
In-Reply-To: <20050227023136.0d1528a7.akpm@osdl.org>
References: <17855236.1109499454066.JavaMail.postfix@mx20.mail.sohu.com>
	<20050227023136.0d1528a7.akpm@osdl.org>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew Morton <akpm@osdl.org> writes:

Andrew> <stone_wang@sohu.com> wrote:
>>  $ ulimit -m 100000 bash: ulimit: max memory size: cannot modify
>> limit: Function not implemented

Andrew> I don't know about this.  The change could cause existing
Andrew> applications and scripts to fail.  Sure, we'll do that
Andrew> sometimes but this doesn't seem important enough. 

What's more, there have been (and still are) out-of-tree patches to
enforce rlimit-RSS in various ways.  There just hasn't been consensus
yet on the best implementation.

-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
