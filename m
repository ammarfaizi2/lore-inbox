Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311721AbSCNSjH>; Thu, 14 Mar 2002 13:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311720AbSCNSi5>; Thu, 14 Mar 2002 13:38:57 -0500
Received: from dsl-213-023-038-002.arcor-ip.net ([213.23.38.2]:26533 "EHLO
	starship") by vger.kernel.org with ESMTP id <S311721AbSCNSio>;
	Thu, 14 Mar 2002 13:38:44 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Momchil Velikov <velco@fadata.bg>, Anton Blanchard <anton@samba.org>
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
Date: Thu, 14 Mar 2002 19:33:40 +0100
X-Mailer: KMail [version 1.3.2]
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20020313085217.GA11658@krispykreme> <20020314112725.GA2008@krispykreme> <87wuwfxp25.fsf@fadata.bg>
In-Reply-To: <87wuwfxp25.fsf@fadata.bg>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16la2m-0000SX-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 14, 2002 02:21 pm, Momchil Velikov wrote:
> >>>>> "Anton" == Anton Blanchard <anton@samba.org> writes:
> Anton> Thats due to the way we manipulate the ppc hashed page table. Every
> Anton> time we update the linux page tables we have to update the hashed
> Anton> page table. There are some obvious optimisations we need to make,
> 
> Out of curiousity, why there's a need to update the linux page tables ?
> Doesn't pte/pmd/pgd family functions provide enough abstraction in
> order to maintain _only_ the hashed page table ?

No, it's hardwired to the x86 tree view of page translation.

-- 
Daniel
