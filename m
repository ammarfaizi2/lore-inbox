Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268149AbUHFPnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268149AbUHFPnE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 11:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268074AbUHFPl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 11:41:26 -0400
Received: from jade.spiritone.com ([216.99.193.136]:44509 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S268149AbUHFPgA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 11:36:00 -0400
Date: Fri, 06 Aug 2004 08:35:08 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@hpce.nec.com>
cc: lse-tech@lists.sourceforge.net, Paul Jackson <pj@sgi.com>, akpm@osdl.org,
       hch@infradead.org, steiner@sgi.com, jbarnes@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       colpatch@us.ibm.com, Simon.Derr@bull.net, ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-ID: <267050000.1091806507@[10.10.2.4]>
In-Reply-To: <200408061730.06175.efocht@hpce.nec.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com> <20040805190500.3c8fb361.pj@sgi.com> <247790000.1091762644@[10.10.2.4]> <200408061730.06175.efocht@hpce.nec.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There's no relation to PAGG but I think cpusets and CKRM should be
> made to come together. One of CKRM's user interfaces is a filesystem
> with the file-tree representing the class hierarchy. It's the same for
> cpusets. 

OK, that makes sense ...

> I'd vote for cpusets going in soon. CKRM could be extended by
> a cpusets controller which should be pretty trivial when using the
> infrastructure of this patch. It simply needs to create classes
> (cpusets) and attach processes to them. The enforcement of resources
> happens automatically. When CKRM is mature to enter the kernel, one
> could drop /dev/cpusets in favor of the CKRM way of doing it.

But I think that's dangerous. It's very hard to get rid of existing user
interfaces ... I'd much rather we sorted out what we're doing BEFORE
putting either in the kernel.

M.

