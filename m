Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265295AbUAWGKO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 01:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265356AbUAWGKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 01:10:14 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:12486 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S265295AbUAWGKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 01:10:10 -0500
Date: Thu, 22 Jan 2004 22:09:17 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jes Sorensen <jes@wildopensource.com>
cc: Jack Steiner <steiner@sgi.com>, linux-kernel@vger.kernel.org,
       Jesse Barnes <jbarnes@sgi.com>
Subject: Re: [patch] increse MAX_NR_MEMBLKS to same as MAX_NUMNODES on NUMA
Message-ID: <43410000.1074838157@[10.10.2.4]>
In-Reply-To: <yq0d69cj9ab.fsf@wildopensource.com>
References: <E1AiZ5h-00043I-00@jaguar.mkp.net><4990000.1074542883@[10.10.2.4]> <20040119224535.GA12728@sgi.com><20040120022452.GA27294@sgi.com> <20040120031222.GA15435@sgi.com><11450000.1074579922@[10.10.2.4]> <yq0d69erilj.fsf@wildopensource.com><18520000.1074615108@[10.10.2.4]> <yq0d69cj9ab.fsf@wildopensource.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Tried it, no go! It conflicts with arch/ia64/mm/numa.c and
>>> arch/ia64/mm,/discontig.c as Jack had suggested.
> 
> Martin> Can you send me the build output? It shouldn't conflict
> Martin> ... there are two separate uses of the term "memblk" by the
> Martin> looks of it.
> 
> Ok,
> 
> This version boots, it seems we had to different uses of NR_MEMBLK in
> the kernel, I renamed one of them to NR_NODE_MEMBLK and it works.

Great - thanks for that. Nice to sort it out before the two uses got
more tangled together anyway ;-)

Thanks,

M.

