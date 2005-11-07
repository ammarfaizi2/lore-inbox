Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbVKGLBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbVKGLBN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 06:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbVKGLBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 06:01:12 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:33504 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751312AbVKGLBL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 06:01:11 -0500
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
From: Dave Hansen <haveblue@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Kyle Moffett <mrmacman_g4@mac.com>,
       Paul Jackson <pj@sgi.com>, andy@thermo.lanl.gov, mbligh@mbligh.org,
       Andrew Morton <akpm@osdl.org>, arjan@infradead.org,
       arjanv@infradead.org, kravetz@us.ibm.com,
       lhms <lhms-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, mel@csn.ul.ie,
       Nick Piggin <nickpiggin@yahoo.com.au>
In-Reply-To: <20051107080042.GA29961@elte.hu>
References: <20051104010021.4180A184531@thermo.lanl.gov>
	 <Pine.LNX.4.64.0511032105110.27915@g5.osdl.org>
	 <20051103221037.33ae0f53.pj@sgi.com> <20051104063820.GA19505@elte.hu>
	 <Pine.LNX.4.64.0511040725090.27915@g5.osdl.org>
	 <796B585C-CB1C-4EBA-9EF4-C11996BC9C8B@mac.com>
	 <Pine.LNX.4.64.0511060756010.3316@g5.osdl.org>
	 <Pine.LNX.4.64.0511060848010.3316@g5.osdl.org>
	 <20051107080042.GA29961@elte.hu>
Content-Type: text/plain
Date: Mon, 07 Nov 2005 12:00:58 +0100
Message-Id: <1131361258.5976.53.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-07 at 09:00 +0100, Ingo Molnar wrote:
> * Linus Torvalds <torvalds@osdl.org> wrote:
> > So remappable kernels are certainly doable, they just have more 
> > fundamental problems than remappable user space _ever_ has. Both from 
> > a performance and from a complexity angle.
> 
> furthermore, it doesnt bring us any closer to removable RAM. The problem 
> is still unsolvable (due to the 'how to do you find live pointers to fix 
> up' issue), even if the full kernel VM is 'mapped' at 4K granularity.

I'm not sure I understand.  If you're remapping, why do you have to find
live and fix up live pointers?  Are you talking about things that
require fixed _physical_ addresses?

-- Dave

