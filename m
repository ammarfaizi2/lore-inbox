Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268216AbUJHJZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268216AbUJHJZy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 05:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268270AbUJHJZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 05:25:54 -0400
Received: from mail01.hpce.nec.com ([193.141.139.228]:37516 "EHLO
	mail01.hpce.nec.com") by vger.kernel.org with ESMTP id S268216AbUJHJZv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 05:25:51 -0400
From: Erich Focht <efocht@hpce.nec.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Date: Fri, 8 Oct 2004 11:23:44 +0200
User-Agent: KMail/1.6.2
Cc: Paul Jackson <pj@sgi.com>, Simon.Derr@bull.net, colpatch@us.ibm.com,
       pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, ak@suse.de, sivanich@sgi.com
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com> <20041007105425.02e26dd8.pj@sgi.com> <1344740000.1097172805@[10.10.2.4]>
In-Reply-To: <1344740000.1097172805@[10.10.2.4]>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410081123.45762.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 October 2004 20:13, Martin J. Bligh wrote:
> It all just seems like a lot of complexity for a fairly obscure set of
> requirements for a very limited group of users, to be honest. Some bits
> (eg partitioning system resources hard in exclusive sets) would seem likely
> to be used by a much broader audience, and thus are rather more attractive.

May I translate the first sentence to: the requirements and usage
models described by Paul (SGI), Simon (Bull) and myself (NEC) are
"fairly obscure" and the group of users addressed (those mainly
running high performance computing (AKA HPC) applications) is "very
limited"? If this is what you want to say then it's you whose view is
very limited. Maybe I'm wrong with what you really wanted to say but I
remember similar arguing from your side when discussing benchmark
results in the context of the node affine scheduler.

This "very limited group of users" (small part of them listed in
www.top500.org) is who drives computer technology, processor design,
network interconnect technology forward since the 1950s. Their
requirements on the operating system are rather limited and that might
be the reason why kernel developers tend to ignore them. All that
counts for HPC is measured in GigaFLOPS or TeraFLOPS, not in elapsed
seconds for a kernel compile, AIM-7, Spec-SDET or Javabench. The way
of using these machines IS different from what YOU experience in day
by day work and Linux is not yet where it should be (though getting
close). Paul's endurance in this thread is certainly influenced by the
perspective of having to support soon a 20x512 CPU NUMA cluster at
NASA...

As a side note: put in the right context your statement on fairly
obscure requirements for a very limited group of users is a marketing
argument ... against IBM.

Thanks ;-)
Erich

--
Core Technology Group
NEC High Performance Computing Europe GmbH, EHPCTC

