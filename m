Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267758AbUHJViM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267758AbUHJViM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 17:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267751AbUHJViM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 17:38:12 -0400
Received: from jade.spiritone.com ([216.99.193.136]:46806 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S267755AbUHJVg7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 17:36:59 -0400
Date: Sun, 08 Aug 2004 07:50:10 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@hpce.nec.com>, Paul Jackson <pj@sgi.com>
cc: lse-tech@lists.sourceforge.net, akpm@osdl.org, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-ID: <2447730000.1091976606@[10.10.2.4]>
In-Reply-To: <200408071722.36705.efocht@hpce.nec.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com> <200408061730.06175.efocht@hpce.nec.com> <20040806231013.2b6c44df.pj@sgi.com> <200408071722.36705.efocht@hpce.nec.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If I understand correctly, CKRM is fine for simple resources like
> amount of memory or cputime and designed to control flexible sharing
> of these resources and ensure some degree of fairness. Cpusets is a
> complex NUMA specific compound resource which actually only allows for
> a rather static distribution across processes (especially with the
> exclusive bits set). Including cpusets control into CKRM will be
> trivial, because you already provide all that's needed.

I'd disagree with this - both are mechanisms for controlling the amount
of CPU time and memory that processes get to use. They have fundamentally
the same objective ... having 2 mechanisms to do the same thing with
different interfaces doesn't seem like a good plan. I don't think CKRM is 
anything like as far away from being ready as you seem to be implying -
we're talking about a month or two, I think.

M.

