Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWHRR3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWHRR3a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 13:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWHRR3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 13:29:30 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:24745 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750707AbWHRR33 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 13:29:29 -0400
Subject: Re: [ckrm-tech] [PATCH 4/7] UBC: syscalls (user interface)
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Rik van Riel <riel@redhat.com>, ckrm-tech@lists.sourceforge.net,
       Christoph@sc8-sf-spam2-b.sourceforge.net,
       List <linux-kernel@vger.kernel.org>, Kirill Korotaev <dev@sw.ru>,
       Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux@sc8-sf-spam2-b.sourceforge.net, rohitseth@google.com,
       hugh@veritas.com, Ingo Molnar <mingo@elte.hu>,
       Pavel Emelianov <xemul@openvz.org>, devel@openvz.org,
       Andi Kleen <ak@suse.de>, Linux Containers <containers@lists.osdl.org>
In-Reply-To: <20060818094248.cdca152d.akpm@osdl.org>
References: <44E33893.6020700@sw.ru> <44E33C3F.3010509@sw.ru>
	 <1155752277.22595.70.camel@galaxy.corp.google.com>
	 <1155755069.24077.392.camel@localhost.localdomain>
	 <1155756170.22595.109.camel@galaxy.corp.google.com>
	 <44E45D6A.8000003@sw.ru> <20060817084033.f199d4c7.akpm@osdl.org>
	 <20060818120809.B11407@castle.nmd.msu.ru>
	 <1155912348.9274.83.camel@localhost.localdomain>
	 <20060818094248.cdca152d.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 10:29:16 -0700
Message-Id: <1155922156.12204.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 09:42 -0700, Andrew Morton wrote:
> I have this mad idea that you can divide a 128GB machine up into 256 fake
> NUMA nodes, then you use each "node" as a 512MB unit of memory allocation. 
> So that 4.5GB job would be placed within an exclusive cpuset which has nine
> "mems" (what are these called?) and voila: the job has a hard 4.5GB limit,
> no kernel changes needed.

Is this similar to Mel Gorman's zone-based anti-fragmentation approach?
I thought he was discouraged from pursuing that at the VM summit.

-- Dave

