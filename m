Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbTD1Rlp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 13:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbTD1Rlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 13:41:45 -0400
Received: from palrel13.hp.com ([156.153.255.238]:12430 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S261227AbTD1Rlo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 13:41:44 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16045.27313.369493.99346@napali.hpl.hp.com>
Date: Mon, 28 Apr 2003 10:53:53 -0700
To: Andi Kleen <ak@suse.de>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Dave Hansen <haveblue@us.ibm.com>, Henti Smith <bain@tcsn.co.za>,
       linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       Riley Williams <Riley@Williams.Name>
Subject: Re: [Lse-tech] Re: maximum possible memory limit ..
In-Reply-To: <20030428171353.GB1068@Wotan.suse.de>
References: <20030424200524.5030a86b.bain@tcsn.co.za>
	<3EAD27B2.9010807@gmx.net>
	<20030428141023.GC4525@Wotan.suse.de>
	<3EAD5AC1.7090003@us.ibm.com>
	<3EAD5D90.7010101@gmx.net>
	<20030428171353.GB1068@Wotan.suse.de>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 28 Apr 2003 19:13:53 +0200, Andi Kleen <ak@suse.de> said:

  >> Cool. Sorry to be pestering about the 64-bit limits, but can we
  >> really use 2^64 bytes of memory on ia64/ppc64/x86-64 etc.?
  >> (AFAIK, 64-bit arches don't suffer from a small ZONE_LOWMEM.)

  Andi> No. The hardware have far smaller physical limits.

  Andi> Current AMD64 CPUs are limited to 40bit physical, 48bit virtal
  Andi> (the virtual limit per process in the current Linux kernel is
  Andi> 39bits)

  Andi> Itanium 2 afaik support a bit more 50bits (51 or 52, I forgot)
  Andi> physical, probably more virtual.

Itanium 2 supports all 64 virtual address bits and 50 physical bits
(in what way is "1024 times more" "a bit more"? ;-).

	--david
