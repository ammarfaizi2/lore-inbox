Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311614AbSCNNSv>; Thu, 14 Mar 2002 08:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311615AbSCNNSl>; Thu, 14 Mar 2002 08:18:41 -0500
Received: from sun.fadata.bg ([80.72.64.67]:26377 "HELO fadata.bg")
	by vger.kernel.org with SMTP id <S311614AbSCNNSX>;
	Thu, 14 Mar 2002 08:18:23 -0500
To: Anton Blanchard <anton@samba.org>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
In-Reply-To: <20020313085217.GA11658@krispykreme>
	<460695164.1016001894@[10.10.2.3]> <20020314112725.GA2008@krispykreme>
X-No-CC: Reply to lists, not to me.
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <20020314112725.GA2008@krispykreme>
Date: 14 Mar 2002 15:21:38 +0200
Message-ID: <87wuwfxp25.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Anton" == Anton Blanchard <anton@samba.org> writes:
Anton> Thats due to the way we manipulate the ppc hashed page table. Every
Anton> time we update the linux page tables we have to update the hashed
Anton> page table. There are some obvious optimisations we need to make,

Out of curiousity, why there's a need to update the linux page tables ?
Doesn't pte/pmd/pgd family functions provide enough abstraction in
order to maintain _only_ the hashed page table ?

Regards,
-velco
