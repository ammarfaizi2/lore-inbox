Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965139AbVKPBHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965139AbVKPBHJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 20:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965140AbVKPBHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 20:07:09 -0500
Received: from mail15.syd.optusnet.com.au ([211.29.132.196]:48083 "EHLO
	mail15.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S965139AbVKPBHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 20:07:07 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17274.34333.348600.111728@wombat.chubb.wattle.id.au>
Date: Wed, 16 Nov 2005 12:06:37 +1100
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Shailabh Nagar <nagar@watson.ibm.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [Patch 1/4] Delay accounting: Initialization
In-Reply-To: <20051114202017.6f8c0327.akpm@osdl.org>
References: <43796596.2010908@watson.ibm.com>
	<20051114202017.6f8c0327.akpm@osdl.org>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew Morton <akpm@osdl.org> writes:

Andrew> Shailabh Nagar <nagar@watson.ibm.com> wrote:
>>  + *ts = sched_clock();

Andrew> I'm not sure that it's kosher to use sched_clock() for
Andrew> fine-grained timestamping like this.  Ingo had issues with it
Andrew> last time this happened?

It wasn't Ingo, it was Andi Kleen...  for my Microstate Accounting
patches, which do very similar things to Shailabh's patchsetm, but
using /proc and a system call instead (following Solaris's lead)

-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
